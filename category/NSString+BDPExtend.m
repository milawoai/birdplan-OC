//
//  NSString+BDPExtend.m
//  birdplanOC
//
//  Created by ygj on 2017/8/11.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "NSString+BDPExtend.h"

@implementation NSString (BDPExtend)

- (NSString *)trim {
    NSString *str = [self copy];
    NSString *trimStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *resultStr = [trimStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return resultStr;
}

- (NSString *)replaceSubString: (NSString *)subString with: (NSString *)newString {
   return [self stringByReplacingOccurrencesOfString:subString withString:newString];
}

@end
