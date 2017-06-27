//
//  BDPMainCollectionViewCell.m
//  birdplanOC
//
//  Created by ygj on 2017/5/3.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPMainCollectionViewCell.h"
#import "UIView+BDPHelper.h"

@interface BDPMainCollectionViewCell ()

@property(strong,nonatomic)UILabel *entryTitle;

@end

@implementation BDPMainCollectionViewCell

-(instancetype)init {
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

- (void)setUI {
    self.backgroundColor = bdp_color_white;
//    self.layer.borderColor=[UIColor darkGrayColor].CGColor;
//    self.layer.borderWidth= 0.3;
//    [self addBottomBorderWithColor:[UIColor darkGrayColor] andWidth:0.3];
//    [self addTopBorderWithColor:[UIColor darkGrayColor] andWidth:0.3];
//    [self addLeftBorderWithColor:[UIColor darkGrayColor] andWidth:0.3];
//    [self addRightBorderWithColor:[UIColor darkGrayColor] andWidth:0.3];
}

- (void)setTitle:(NSString *)title {
    if (!_entryTitle) {
        _entryTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,  30 + self.frame.size.height/2 , self.frame.size.width, 30)];
        _entryTitle.numberOfLines = 0;
        _entryTitle.font = [UIFont systemFontOfSize:13];
        _entryTitle.textAlignment = NSTextAlignmentCenter;
        _entryTitle.textColor = [UIColor grayColor];
        [self.contentView addSubview:_entryTitle];
    }
    _entryTitle.text = title;
}

@end
