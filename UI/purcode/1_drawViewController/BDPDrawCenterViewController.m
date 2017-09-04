//
//  BDPDrawCenterViewController.m
//  birdplanOC
//
//  Created by ygj on 2017/6/28.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPDrawCenterViewController.h"
#import "BDPDrawerViewController.h"
#import "UIViewController+BDPExtend.h"

@interface BDPDrawCenterViewController ()<UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, weak) BDPDrawerViewController *drawerController;
@end

static NSString * const BDPDrawCenterViewControllerReuseIdentifier = @"BDPDrawCenterViewControllerCell";

@implementation BDPDrawCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setFakeData];
    [self setUI];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    // 开启返回手势
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
}

-(void) setUI {
    [self createSubView];
}

-(void) createSubView {
    BOOL isPresent = [self isPresent];
    // BOOL isPresent =  self.navigationController.topViewController == self;
    if (!_tableView) {
//        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,[self isPresent]?SCREEN_HEIGHT: SCREEN_HEIGHT_NO_NAV)];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,isPresent?SCREEN_HEIGHT:SCREEN_HEIGHT_NO_NAV)];

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
    }
}

-(void)setFakeData {
    if (!_datas) {
        self.datas = [[NSMutableArray alloc] init];
    }
    
    //--- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i< 10; i++) {
            [self.datas addObject:[NSString stringWithFormat:@"test_%d",i]];
        }
        [self.tableView reloadData];
    });
}

- (void) setDrawerController:(BDPDrawerViewController *)drawCtrl {
    _drawerController = drawCtrl;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
//    if (!tableView.editing)
//        return UITableViewCellEditingStyleNone;
//    else {
//        return UITableViewCellEditingStyleDelete;
//    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:NO animated:YES];
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BDPDrawCenterViewControllerReuseIdentifier];
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}
@end
