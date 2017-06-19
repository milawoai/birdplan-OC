//
//  UIView+BDPHelper.h
//  birdplanOC
//
//  Created by ygj on 2017/6/19.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BDPHelper)

-(void)addBottomBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
-(void)addLeftBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
-(void)addRightBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
-(void)addTopBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

@end
