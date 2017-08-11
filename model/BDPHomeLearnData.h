//
//  BDPIncomData.h
//  birdplanOC
//
//  Created by ygj on 2017/6/20.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDPHomeLearnData : NSObject<NSCopying>
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger learnID;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *methodName;
@end
