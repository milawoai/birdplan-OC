//
//  UIColor+BDPHelpers.h
//  birdplanOC
//
//  Created by ygj on 2017/6/14.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BDPHelpers)

// [UIColor UIColorFromRGBAColorWithRed:10 green:20 blue:30 alpha:0.8]
+ (UIColor *)UIColorFromRGBAColorWithR: (CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;
+ (UIColor *)UIColorFromRGBAColorWithR: (CGFloat)r G:(CGFloat)g B:(CGFloat)b ;
// [UIColor UIColorFromHex:0xc5c5c5 alpha:0.8];
+ (UIColor *)UIColorFromHex:(NSUInteger)rgb alpha:(CGFloat)alpha;
+ (UIColor *)UIColorFromHex:(NSUInteger)rgb;

+ (UIColor *)colorWithHexString:(NSString *)hex;

- (NSString *)hexString;

@end
