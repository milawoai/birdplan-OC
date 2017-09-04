//
//  UIViewController+navSetting.m
//  birdplanOC
//
//  Created by ygj on 2017/6/29.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "UIViewController+BDPExtend.h"

@implementation UIViewController (checkPresent)
- (BOOL)isPresent {
    return self.navigationController.topViewController != self;
}
@end

@implementation UIViewController (navSetting)

- (void)addLeftBarButtonItem {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:@"leftGoBackBlack.png"];
    [button setImage:backImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(barLeftButtonClick)
     forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
    button.frame = CGRectMake(0, 0, 40, 45);
    button.titleLabel.textColor = [UIColor colorWithRed:(1.0) green:(1.0) blue:(1.0) alpha:1];
    
    UIBarButtonItem *goBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = goBackButtonItem;
}

- (void)addRightBarButtonItem:(UIView *)barButtonItem {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButtonItem];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)addLeftBarButtonItem:(UIView *)barButtonItem {
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButtonItem];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)barLeftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
