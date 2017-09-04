//
//  UIViewController+navSetting.h
//  birdplanOC
//
//  Created by ygj on 2017/6/29.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (checkPresent)

@property(nullable, nonatomic,readonly,strong) UINavigationController *navigationController;
- (BOOL)isPresent;

@end


@interface UIViewController (navSetting)

- (void)addLeftBarButtonItem;
- (void)barLeftButtonClick;
- (void)addRightBarButtonItem:(UIView *)barButtonItem;
- (void)addLeftBarButtonItem:(UIView *)barButtonItem;

@end
