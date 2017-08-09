//
//  SDBAlertUtils.h
//  sdbao
//
//  Created by ygj on 2017/7/19.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDPAlertUtils : NSObject

+ (void)presentAlertWithMessage:(NSString *)msg ctrl:(UIViewController *)ctrl;

+ (void)genTestButtonInView:(UIView *)view method:(id)method;
@end
