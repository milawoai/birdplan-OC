//
//  BDPMainCollectionViewController.h
//  birdplanOC
//
//  Created by ygj on 2017/4/19.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDPMainCollectionViewController : UICollectionViewController

- (instancetype)initWithColNumber: (NSInteger)colNumber;
- (instancetype)initWithColNumber: (NSInteger)colNumber sectionInset: (UIEdgeInsets)edgeInsets;
- (instancetype)initWithCellWidth: (float)cellWidth cellHeight: (float)cellHeight;

- (instancetype)initWithCellWidth: (float)cellWidth cellHeight: (float)cellHeight itemSpacing: (NSUInteger)itemSpacing lineSpacing: (NSUInteger)lineSpacing;
- (instancetype)initWithCellWidth: (float)cellWidth cellHeight: (float)cellHeight itemSpacing: (NSUInteger)itemSpacing lineSpacing: (NSUInteger)lineSpacing sectionInset: (UIEdgeInsets)edgeInsets headerReferenceSize: (CGSize)headerReferenceSize footerReferenceSize: (CGSize)footerReferenceSize;

@end
