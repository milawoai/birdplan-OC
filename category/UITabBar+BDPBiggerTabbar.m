//
//  UITabBar+BDPFuncFix.m
//  birdplanOC
//
//  Created by ygj on 2017/6/18.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "UITabBar+BDPBiggerTabbar.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

/** tabbaritem中的label的高度*/
#define kTabBarBtnLabelHeigh    16
/** tabbaritem中label与image的间隔*/
#define kSpace                  5

static NSString *contentCtrlKey = @"contentCtrlKey";
static NSString *imageSizeKey = @"imageSizeKey";
static NSString *badgetNumberKey = @"badgetNumberKey";
@interface UITabBar ()

@property (nonatomic, weak) UITabBarController *contentCtrl;
@end

@implementation UITabBar (BDPFuncFix)

-(void)setContentCtrl:(UITabBarController *)contentCtrl
{
    objc_setAssociatedObject(self, &contentCtrlKey, contentCtrl, OBJC_ASSOCIATION_ASSIGN);
}

-(NSString *)contentCtrl
{
    return objc_getAssociatedObject(self, &contentCtrlKey);
}

-(void)setBadgetNumber:(NSUInteger)badgetNumber
{
    NSString *badgetStr = @"";
    if (badgetNumber <= 99) {
        badgetStr = [NSString stringWithFormat:@"%lu", (unsigned long)badgetNumber];
    } else {
        badgetStr = @"99+";
    }
    objc_setAssociatedObject(self, &badgetNumberKey, badgetStr, OBJC_ASSOCIATION_ASSIGN);
}


-(void)setImageSize:(CGSize)imageSize
{
    objc_setAssociatedObject(self, &imageSizeKey, NSStringFromCGSize(imageSize), OBJC_ASSOCIATION_COPY_NONATOMIC);
}


+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchageMethod:@selector(layoutSubviews) swizzledSelector:@selector(my_layoutSubviews)];
        [self exchageMethod:@selector(hitTest:withEvent:) swizzledSelector:@selector(my_hitTest:withEvent:)];
        [self exchageMethod:@selector(touchesBegan:withEvent:) swizzledSelector:@selector(my_touchesBegan:withEvent:)];
    });
}

+(void)exchageMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod([self class], originalSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

-(void)my_layoutSubviews
{
    [self my_layoutSubviews];
    
    for (UIView *childView in self.subviews) {
        if (![childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            /** 如果不是按钮，那么就继续*/
            continue;
        }
        
        UIView* tabBarImage, *tabBarLabel;
        for (UIView *tabBtnChildView in childView.subviews) {
            /** tabbar的图片*/
            if ([tabBtnChildView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                tabBarImage = tabBtnChildView;
                CGRect frame = tabBarImage.frame;
                NSString *imgSizeStr = objc_getAssociatedObject(self, &imageSizeKey);
                CGSize imgSize = CGSizeFromString(imgSizeStr);
                if (imgSize.width > 0 && imgSize.height > 0) {
                    frame.size = imgSize;
                    tabBarImage.frame = frame;
                }
            }
            
            /** tabbar的label*/
            if ([tabBtnChildView isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
                tabBarLabel = tabBtnChildView;
            }
        }
        
        /** tabbarbtn总的高度*/
        CGFloat oldHeight = CGRectGetHeight(tabBarLabel.bounds)+CGRectGetHeight(tabBarImage.bounds);
        if (oldHeight > CGRectGetHeight(self.bounds)) {
            /** 图片和label的高度已经超出了tabbar的高度，此时需要重新布局*/
            CGRect frame = childView.frame;
            frame.origin.y = CGRectGetHeight(self.bounds)-oldHeight-kSpace;
            frame.size.height = oldHeight + kSpace;
            [childView setFrame:frame];
        }
    }
}

-(UIView *)my_hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.hidden) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    if (result) {
        return result;
    } else {
        for (UIView* subView in self.subviews) {
            CGPoint subPoint = [subView convertPoint:point fromView:self];
            result = [subView hitTest:subPoint withEvent:event];
            if (result) {
                return result;
            }
        }
    }
    
    return nil;
}

-(void)my_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self my_touchesBegan:touches withEvent:event];
    
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    
    NSInteger tabCount = 0;
    for (UIView *childView in self.subviews) {
        if (![childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        
        tabCount++;
    }
    CGFloat width = [UIScreen mainScreen].bounds.size.width / tabCount;
    NSUInteger clickIndex = ceilf(point.x) / ceilf(width);
    
    UITabBarController *controller = [self contentCtrl];
    if (!controller) {
        controller = (UITabBarController *)[AppDelegate mainWindow].rootViewController;
    }
    [controller setSelectedIndex:clickIndex];
}


@end
