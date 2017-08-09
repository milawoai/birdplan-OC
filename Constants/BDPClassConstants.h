//
//  BDPClassConstants.h
//  birdplanOC
//
//  Created by ygj on 2017/8/6.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#ifndef BDPClassConstants_h
#define BDPClassConstants_h

// 获取weak类
#define WEAKSELF typeof(self) __weak weakSelf = self;

//单例化一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

#endif /* BDPClassConstants_h */
