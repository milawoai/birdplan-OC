//
//  UIImage+BDPHelper.m
//  birdplanOC
//
//  Created by ygj on 2017/6/19.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "UIImage+BDPHelper.h"

@implementation UIImage (BDPHelper)

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color havingSize:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)imageWithColor:(UIColor *)color havingSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
