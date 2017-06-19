//
//  BDPCodeHomePageViewController.h
//  birdplanOC
//
//  Created by ygj on 2017/6/19.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDPCodeHomePageViewController : UIViewController

- (instancetype)initWithColNumber: (NSInteger)colNumber;
- (instancetype)initWithColNumber: (NSInteger)colNumber sectionInset: (UIEdgeInsets)edgeInsets;
- (instancetype)initWithCellWidth: (float)cellWidth cellHeight: (float)cellHeight;

- (instancetype)initWithCellWidth: (float)cellWidth cellHeight: (float)cellHeight itemSpacing: (NSUInteger)itemSpacing lineSpacing: (NSUInteger)lineSpacing;
- (instancetype)initWithCellWidth: (float)cellWidth cellHeight: (float)cellHeight itemSpacing: (NSUInteger)itemSpacing lineSpacing: (NSUInteger)lineSpacing sectionInset: (UIEdgeInsets)edgeInsets headerReferenceSize: (CGSize)headerReferenceSize footerReferenceSize: (CGSize)footerReferenceSize;

@end
