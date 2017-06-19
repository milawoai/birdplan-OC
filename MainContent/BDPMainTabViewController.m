//
//  BDPMainTabViewController.m
//  birdplanOC
//
//  Created by ygj on 2017/5/3.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPMainTabViewController.h"
#import "BDPMainCollectionViewController.h"
#import "BDPNavigationViewController.h"
#import "BDPCodeHomePageViewController.h"

static dispatch_once_t onceToken;
static BDPMainTabViewController *shared = nil;

@interface BDPMainTabViewController ()

@property (nonatomic, strong) BDPNavigationViewController *codeNavigationController;

@property (nonatomic, strong) BDPCodeHomePageViewController *codeCollectionViewController;

@property (nonatomic, strong) BDPNavigationViewController *xibNavigationController;

@property (nonatomic, strong) BDPCodeHomePageViewController *xibCollectionViewController;
@end

@implementation BDPMainTabViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [[self tabBar] setTranslucent:NO];
        self.tabBar.tintColor = bdp_color_blue;
        [[self tabBar] setBackgroundImage:[UIImage imageWithColor:[UIColor UIColorFromHex:0xf8f8f8 alpha:0.98]]];
        
        [self setViewControllers:@[self.codeNavigationController,self.xibNavigationController]];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor UIColorFromHex:0x999]} forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:bdp_color_blue} forState:UIControlStateSelected];
        
        [self setSelectedViewController:self.codeNavigationController];
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


#pragma mark - Public
+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

+ (void)dellocTab
{
    onceToken = 0;
    shared = nil;
}

- (void)switchToTab:(NSInteger)index
{
    [self setSelectedIndex:index];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BDPNavigationViewController *)codeNavigationController {
    if (_codeNavigationController) {
        return _codeNavigationController;
    }
    if (!_codeCollectionViewController) {
        _codeCollectionViewController = [[BDPCodeHomePageViewController alloc] init];
    }
    _codeNavigationController = [[BDPNavigationViewController alloc] initWithRootViewController:_codeCollectionViewController];
    _codeNavigationController.navigationBar.translucent = NO;
    
    UIImage *tabbarImage = [UIImage imageNamed:@"tabbar_code"];
    UIImage *selectedTabbarImage = [UIImage imageNamed:@"tabbar_code_sel"];
    
    _codeNavigationController.tabBarItem.image = [tabbarImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _codeNavigationController.tabBarItem.selectedImage = selectedTabbarImage;
    _codeNavigationController.tabBarItem.title = @"code";
    [_codeNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} forState:UIControlStateNormal];
    [_codeNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} forState:UIControlStateSelected];
    
    return _codeNavigationController;
}

- (BDPNavigationViewController *)xibNavigationController
{
    if (_xibNavigationController) {
        return _xibNavigationController;
    }
    if (!_xibCollectionViewController) {
        _xibCollectionViewController = [[BDPCodeHomePageViewController alloc] init];
    }

    _xibNavigationController = [[BDPNavigationViewController alloc] initWithRootViewController:_xibCollectionViewController];
    
    _xibNavigationController.navigationBar.translucent = NO;
    
    UIImage *tabbarImage = [UIImage imageNamed:@"tabbar_xib"];
    UIImage *selectedTabbarImage = [UIImage imageNamed:@"tabbar_xib_selected"];
    
    
    _xibNavigationController.tabBarItem.image = [tabbarImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _xibNavigationController.tabBarItem.selectedImage = selectedTabbarImage;
    _xibNavigationController.tabBarItem.title = @"xib";
    [_xibNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} forState:UIControlStateNormal];
    [_xibNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} forState:UIControlStateSelected];
    
    return _xibNavigationController;
}

- (UINavigationController *)currentNavController
{
    switch (self.selectedIndex)
    {
        case BDPIndexOfMainTabCode:
        {
            return self.codeNavigationController;
        }
            break;
        case BDPIndexOfMainTabXib:
        {
            return self.xibNavigationController;
        }
            break;
        default:
            break;
    }
    
    return nil;
}
@end
