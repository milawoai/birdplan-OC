//
//  BDPIncomData.m
//  birdplanOC
//
//  Created by ygj on 2017/6/20.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPHomeLearnData.h"

@implementation BDPHomeLearnData

- (id)copyWithZone:(NSZone *)zone {
    BDPHomeLearnData *homeLearnData = [[[self class] allocWithZone:zone] init];
    
    homeLearnData.url = [self.url copy];
    homeLearnData.title = [self.title copy];
    homeLearnData.learnID = self.learnID;
    homeLearnData.className = [self.className copy];
    homeLearnData.methodName = [self.methodName copy];
    return homeLearnData;
}

@end
