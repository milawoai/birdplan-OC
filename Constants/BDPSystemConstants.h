//
//  BDPSystemConstants.h
//  birdplanOC
//
//  Created by ygj on 2017/8/9.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#ifndef BDPSystemConstants_h
#define BDPSystemConstants_h

// 获取消息中心实例
#define BDPNotificationCenter [NSNotificationCenter defaultCenter]

//--- 模拟加载延迟

#define DelayImport (X, Y)  \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(X * NSEC_PER_SEC)), dispatch_get_main_queue(), Y);


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


// 是否iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 是否iPad
#define someThing (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? ipad: iphone

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//判断版本是否大于

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_3
#else
#endif

#endif /* BDPSystemConstants_h */
