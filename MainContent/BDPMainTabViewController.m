//
//  BDPMainTabViewController.m
//  birdplanOC
//
//  Created by ygj on 2017/5/3.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPMainTabViewController.h"
#import "BDPNavigationViewController.h"
#import "BDPCodeHomePageViewController.h"
#import "BDPAlphaModalViewController.h"
// #import "UITabBar+BDPFuncFix.h"
//#import "UITabBar+BDPFuncFix.h"

static dispatch_once_t onceToken;
static BDPMainTabViewController *shared = nil;

@interface BDPMainTabViewController ()<UITabBarDelegate>

@property (nonatomic, strong) BDPNavigationViewController *codeNavigationController;

@property (nonatomic, strong) BDPCodeHomePageViewController *codeCollectionViewController;

@property (nonatomic, strong) BDPNavigationViewController *xibNavigationController;

@property (nonatomic, strong) BDPCodeHomePageViewController *xibCollectionViewController;

@property (nonatomic, assign) BOOL isGenMidBigTab;
@property (nonatomic, assign) BOOL isMidBigTabAsNormalTab;

@property(nonatomic, strong) UIButton *centerButton;
@property(nonatomic, assign) NSUInteger centerButtonIndex;
@property(nonatomic, strong) UIViewController *centerEmptyCtrl;
@property(nonatomic, strong) UINavigationController *centerEmptyNav;

@property(nonatomic, strong) BDPAlphaModalViewController *presentCtrl;
@end

@implementation BDPMainTabViewController

- (instancetype)initWithBigTabFlag:(BOOL)isGenMidBigTab asNormalTab:(BOOL)isMidBigTabAsNormalTab {
    self = [super init];
    if (self) {
        self.isGenMidBigTab = isGenMidBigTab;
        self.isMidBigTabAsNormalTab = isMidBigTabAsNormalTab;
        [self initVC];
    }
    return self;
}

- (instancetype)init {
    return [self initWithBigTabFlag:YES asNormalTab:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

//- (void) viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self.selectedViewController endAppearanceTransition];
//}
//
//- (void) viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
//}
////
//- (void) viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    [self.selectedViewController endAppearanceTransition];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isGenMidBigTab) {
       [self addCenterButtonWithImage:[UIImage imageNamed:@"hood"] highlightImage:[UIImage imageNamed:@"hood-selected"] target:self action:@selector(centerButtonPressed:) asNormalTabbar:_isGenMidBigTab];
    }
    // [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Public
+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

+ (void)dellocTab {
    onceToken = 0;
    shared = nil;
}

- (void)switchToTab:(NSInteger)index{
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
    _codeNavigationController.tabBarItem.title = @"code";
    _codeNavigationController.tabBarItem.badgeValue = @"99";
    
//    UIImage *tabbarImage = [UIImage image:[UIImage imageNamed:@"tabbar_code"] resize:CGSizeMake(60, 60)];
//    UIImage *selectedTabbarImage = [UIImage image:[UIImage imageNamed:@"tabbar_code_sel"] resize:CGSizeMake(60, 60)];
//    
    UIImage *tabbarImage = [UIImage imageNamed:@"tabbar_code"];
    UIImage *selectedTabbarImage = [UIImage imageNamed:@"tabbar_code"];
    _codeNavigationController.tabBarItem.image = [tabbarImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _codeNavigationController.tabBarItem.selectedImage = selectedTabbarImage;
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
    _xibNavigationController.tabBarItem.title = @"xib";
    
    UIImage *tabbarImage = [UIImage imageNamed:@"tabbar_xib"];
    UIImage *selectedTabbarImage = [UIImage imageNamed:@"tabbar_xib_selected"];
    _xibNavigationController.tabBarItem.image = [tabbarImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _xibNavigationController.tabBarItem.selectedImage = selectedTabbarImage;
    return _xibNavigationController;
}

- (UINavigationController *)currentNavController {
    switch (self.selectedIndex) {
        case BDPIndexOfMainTabCode: {
            return self.codeNavigationController;
        }
            break;
        case BDPIndexOfMainTabXib: {
            return self.xibNavigationController;
        }
            break;
        default:
            break;
    }
    return nil;
}


// Create a custom UIButton and add it to the center of our tab bar
- (void)addCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action asNormalTabbar:(BOOL)asNormalTabbar {
    if (self.centerButton) {
        return ;
    }
    NSMutableArray<__kindof UIViewController *> *viewControllers = [self.viewControllers mutableCopy];
    
    if (asNormalTabbar) {
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

- (void)centerButtonPressed:(id)sender {
    if (_isGenMidBigTab) {
        if (_isMidBigTabAsNormalTab) {
            [self setSelectedIndex:_centerButtonIndex];
            [self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
        } else {
            if (!_presentCtrl) {
                _presentCtrl = [[BDPAlphaModalViewController alloc] init];
                _presentCtrl.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            self.modalPresentationStyle = UIModalPresentationCurrentContext;//关键语句，必须有
            [self presentViewController:_presentCtrl animated:YES completion:nil];
        }
        
    }
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

- (void)setTabBarHidden:(BOOL)tabBarHidden {
    self.centerButton.hidden = tabBarHidden;
    self.tabBar.hidden = tabBarHidden;
}

-(void)setUI {
    [[self tabBar] setTranslucent:NO];
    self.tabBar.tintColor = bdp_color_blue;
    self.tabBar.backgroundColor = bdp_color_black;
    [[self tabBar] setBackgroundImage:[UIImage imageWithColor:[UIColor UIColorFromHex:0xf8f8f8 alpha:0.98]]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor UIColorFromHex:0x999]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:bdp_color_blue} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} forState:UIControlStateSelected];
}

-(void)initVC {
    [self setViewControllers:@[self.codeNavigationController,self.xibNavigationController]];
    [self setSelectedViewController:self.codeNavigationController];
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (self.centerButton) {
        [self doNotHighlight:self.centerButton];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
