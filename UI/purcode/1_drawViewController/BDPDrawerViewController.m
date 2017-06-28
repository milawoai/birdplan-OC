//
//  BDPDrawerViewController.m
//  birdplanOC
//
//  Created by ygj on 2017/6/27.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPDrawerViewController.h"
#import "BDPLeftDrawController.h"
#import "BDPNavigationViewController.h"

@interface BDPDrawerViewController ()

@end

@implementation BDPDrawerViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.leftDrawerViewController = [[BDPLeftDrawController alloc] init];
        
        self.centerViewController = [[BDPLeftDrawController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark setter & getter
//- (BDPNavigationViewController *)naviHome {
//    if (!_naviHome) {
//        SYHomeController *home = [[SYHomeController alloc] init];
//        _naviHome = [[SYNavigationController alloc] initWithRootViewController:home];
//        _naviHome.navigationBar.hidden = YES;
//    }
//    return _naviHome;
//}

@end
