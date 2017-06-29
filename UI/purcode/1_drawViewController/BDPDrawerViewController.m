//
//  BDPDrawerViewController.m
//  birdplanOC
//
//  Created by ygj on 2017/6/27.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPDrawerViewController.h"
#import "BDPDrawCenterViewController.h"
#import "BDPLeftDrawController.h"
#import "BDPNavigationViewController.h"
#import "UIViewController+BDPNavSetting.h"

@interface BDPDrawerViewController ()
@property (nonatomic, strong) UIButton *rightNavBtn;
@end

@implementation BDPDrawerViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.leftDrawerViewController = [[BDPLeftDrawController alloc] init];
        
        self.centerViewController = [[BDPDrawCenterViewController alloc] init];
        
        [(BDPDrawCenterViewController*)self.centerViewController setDrawerController:self];
//        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
//        
//        
//        // self.navigationItem.leftBarButtonItems = rightBarButtonItem;
//        rightBarButtonItem.width=100;
//    
//       self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: self.navigationItem.backBarButtonItem, rightBarButtonItem, nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    self.maximumLeftDrawerWidth = 200.0;
    self.maximumRightDrawerWidth = 200.0;
    
    [self addLeftBarButtonItem];
    [self addRightBarButtonItem:_rightNavBtn];
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer* pan = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint p = [pan translationInView:pan.view];
        
        if(fabs(p.y)<fabs(p.x) && p.x > 0)
        {
            return NO;
        }
        
        return fabs(p.y)<fabs(p.x);
    }
    return YES;
}


#pragma mark setter & getter
- (UIButton *)rightNavBtn {
    _rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightNavBtn.frame = CGRectMake(0, 0, 60, 45);
    [_rightNavBtn setTitle:@"测试" forState:UIControlStateNormal];
    [_rightNavBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightNavBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    _rightNavBtn.backgroundColor = [UIColor redColor];
    _rightNavBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_rightNavBtn addTarget:self action:@selector(rightNaviBtnAction) forControlEvents:UIControlEventTouchUpInside];
    return _rightNavBtn;
}

#pragma mark event handler

-(void) rightNaviBtnAction {
    [self toggleDrawer];
}


- (void)openDrawer {
    [self openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)closeDrawer {
    [self closeDrawerAnimated:YES completion:nil];
    
}

- (void)toggleDrawer {
    self.openSide == MMDrawerSideNone ? [self openDrawer]:[self closeDrawer];
}
@end
