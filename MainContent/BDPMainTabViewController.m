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
// #import "UITabBar+BDPFuncFix.h"
//#import "UITabBar+BDPFuncFix.h"

static dispatch_once_t onceToken;
static BDPMainTabViewController *shared = nil;

@interface BDPMainTabViewController ()<UITabBarDelegate>

@property (nonatomic, strong) BDPNavigationViewController *codeNavigationController;

@property (nonatomic, strong) BDPCodeHomePageViewController *codeCollectionViewController;

@property (nonatomic, strong) BDPNavigationViewController *xibNavigationController;

@property (nonatomic, strong) BDPCodeHomePageViewController *xibCollectionViewController;

@property(nonatomic, strong) UIButton *centerButton;
@property(nonatomic, assign) NSUInteger centerButtonIndex;
@property(nonatomic, strong) UIViewController *centerEmptyCtrl;
@property(nonatomic, strong) UINavigationController *centerEmptyNav;
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
    [self setUI];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self addCenterButtonWithImage:[UIImage imageNamed:@"hood"] highlightImage:[UIImage imageNamed:@"hood-selected"] target:self action:@selector(buttonPressed:)];
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

- (BDPNavigationViewController *)codeNavigationController {
    if (_codeNavigationController) {
        return _codeNavigationController;
    }
    if (!_codeCollectionViewController) {
        _codeCollectionViewController = [[BDPCodeHomePageViewController alloc] init];
    }
    _codeNavigationController = [[BDPNavigationViewController alloc] initWithRootViewController:_codeCollectionViewController];
    _codeNavigationController.navigationBar.translucent = NO;
    
//    UIImage *tabbarImage = [UIImage image:[UIImage imageNamed:@"tabbar_code"] resize:CGSizeMake(60, 60)];
//    UIImage *selectedTabbarImage = [UIImage image:[UIImage imageNamed:@"tabbar_code"] resize:CGSizeMake(60, 60)];
    
    UIImage *tabbarImage = [UIImage imageNamed:@"tabbar_code"];
    UIImage *selectedTabbarImage = [UIImage imageNamed:@"tabbar_code"];
    _codeNavigationController.tabBarItem.image = [tabbarImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _codeNavigationController.tabBarItem.selectedImage = selectedTabbarImage;
    _codeNavigationController.tabBarItem.title = @"code";
    _codeNavigationController.tabBarItem.badgeValue = @"99";
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


// Create a custom UIButton and add it to the center of our tab bar
- (void)addCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action
{
    if (self.centerButton) {
        return ;
    }
    NSMutableArray<__kindof UIViewController *> *viewControllers = [self.viewControllers mutableCopy];
    
    if (viewControllers.count % 2 != 0) {
        return;
    } else {
        if (!_centerEmptyCtrl) {
            _centerEmptyCtrl = [[UIViewController alloc] init];
            _centerEmptyCtrl.view.backgroundColor = [UIColor UIColorFromHex:0xffffff alpha:0.8];
        }
        if (!_centerEmptyNav) {
            _centerEmptyNav = [[UINavigationController alloc] init];
        }
        _centerEmptyNav.tabBarItem.enabled = NO;
        _centerEmptyNav.navigationBar.hidden = YES;
        self.centerButtonIndex = viewControllers.count / 2;
        [viewControllers insertObject:_centerEmptyNav atIndex:(viewControllers.count / 2)];
        [self setViewControllers:viewControllers];
    }
    CGRect tabbarFrame = self.tabBar.bounds;
    CGFloat offsetFromBottom = 10.0f;
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake((tabbarFrame.size.width - buttonImage.size.width)/2, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0) {
        button.center = self.tabBar.center;
    } else {
        CGPoint center = self.tabBar.center;
        center.y = (self.tabBar.frame.size.height - buttonImage.size.height / 2) - offsetFromBottom;
        button.center = center;
    }
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:button];
    [self.tabBar bringSubviewToFront:button];
    self.centerButton = button;
}

- (void)buttonPressed:(id)sender
{
    [self setSelectedIndex:_centerButtonIndex];
    [self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
}

- (void)doHighlight:(UIButton*)b {
    [b setHighlighted:YES];
}

- (void)doNotHighlight:(UIButton*)b {
    [b setHighlighted:NO];
}

- (BOOL)tabBarHidden {
    return self.centerButton.hidden && self.tabBar.hidden;
}

- (void)setTabBarHidden:(BOOL)tabBarHidden
{
    self.centerButton.hidden = tabBarHidden;
    self.tabBar.hidden = tabBarHidden;
}

-(void) setUI {
    self.tabBar.backgroundColor = bdp_color_black;
}
#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (self.centerButton) {
        [self doNotHighlight:self.centerButton];
    }
}

@end
