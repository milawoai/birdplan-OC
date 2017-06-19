//
//  BDPMainTabViewController.h
//  birdplanOC
//
//  Created by ygj on 2017/5/3.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BDPIndexOfMainTab) {
    BDPIndexOfMainTabCode = 0,
    BDPIndexOfMainTabXib = 1,
};


@interface BDPMainTabViewController : UITabBarController

+ (instancetype)sharedInstance;

+ (void)dellocTab;

- (void)switchToTab:(NSInteger)index;

- (UINavigationController *)currentNavController;

@end
