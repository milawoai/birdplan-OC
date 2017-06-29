//
//  BDPDrawCenterViewController.m
//  birdplanOC
//
//  Created by ygj on 2017/6/28.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPDrawCenterViewController.h"
#import "BDPDrawerViewController.h"

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
    
    // self.view.backgroundColor = bdp_color_black;
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) setUI {
    [self createSubView];
}

-(void) createSubView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_NO_NAV)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
    }
}

-(void)setFakeData {
    if (!_datas) {
        self.datas = [[NSMutableArray alloc] init];
    }
    
    for (int i = 0; i< 10; i++) {
        [self.datas addObject:[NSString stringWithFormat:@"test_%d",i]];
    }
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
