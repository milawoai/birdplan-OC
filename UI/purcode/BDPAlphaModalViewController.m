//
//  BDPAlphaModalViewController.m
//  birdplanOC
//
//  Created by ygj on 2017/6/30.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPAlphaModalViewController.h"

@interface BDPAlphaModalViewController ()

@property(strong,nonatomic)UILabel *entryTitle;
@end

@implementation BDPAlphaModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setTitle:@"helllo"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI {
    [self.view setBackgroundColor:[UIColor colorWithWhite:1.f alpha:0.9f]];
}

- (void)setTitle:(NSString *)title {
    if (!_entryTitle) {
        _entryTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,  30 + self.view.frame.size.height/2 , self.view.frame.size.width, 30)];
        _entryTitle.numberOfLines = 0;
        _entryTitle.font = [UIFont systemFontOfSize:13];
        _entryTitle.textAlignment = NSTextAlignmentCenter;
        _entryTitle.textColor = [UIColor grayColor];
        [self.view addSubview:_entryTitle];
    }
    _entryTitle.text = title;
}

@end
