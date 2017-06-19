//
//  UIImage+BDPHelper.h
//  birdplanOC
//
//  Created by ygj on 2017/6/19.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BDPHelper)

// 生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color havingSize:(CGSize)size;

// resize图片
+ (UIImage *)image:(UIImage *)image resize:(CGSize)newsize;

@end
