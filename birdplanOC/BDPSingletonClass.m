//
//  BDPSingletonClass.m
//  birdplanOC
//
//  Created by ygj on 2017/8/6.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPSingletonClass.h"

@implementation BDPSingletonClass

+ (instancetype)sharedInstance
{
    static BDPSingletonClass *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [BDPSingletonClass new];
    });
    return shared;
}

@end
