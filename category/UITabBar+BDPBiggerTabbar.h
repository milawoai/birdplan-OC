//
//  UITabBar+BDPFuncFix.h
//  birdplanOC
//
//  Created by ygj on 2017/6/18.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (BDPBiggerTabbar)

-(void)setContentCtrl:(UITabBarController *)contentCtrl;
-(void)setImageSize:(CGSize)imageSize;
//- (void)setBadgetUIWithBadgetNumber:(NSUInteger)badgetNumber;
@end
