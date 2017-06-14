//
//  BDPMainCollectionViewCell.m
//  birdplanOC
//
//  Created by ygj on 2017/5/3.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPMainCollectionViewCell.h"


@interface BDPMainCollectionViewCell ()

@property(strong,nonatomic)UILabel *entryTitle;

@end

@implementation BDPMainCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _entryTitle = [[UILabel alloc]initWithFrame:CGRectMake(7, 12 , SCREEN_WIDTH/3, SCREEN_WIDTH/3)];
        _entryTitle.numberOfLines = 0;
        _entryTitle.font = [UIFont systemFontOfSize:13];
        _entryTitle.textColor = [UIColor grayColor];
        [self.contentView addSubview:_entryTitle];
    }
    return self;
}

@end
