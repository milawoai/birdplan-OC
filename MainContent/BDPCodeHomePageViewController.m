//
//  BDPCodeHomePageViewController.m
//  birdplanOC
//
//  Created by ygj on 2017/6/19.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPCodeHomePageViewController.h"
#import "BDPTestViewController.h"

#import "SDCycleScrollView.h"
#import "BDPMainCollectionViewCell.h"

#import "UIView+BDPHelper.h"

#import "BDPHomeLearnData.h"


#define default_colNumber 3
#define default_totalNumber 12
#define default_cellHeight 100
// CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
#define default_top 0
#define default_left 0
#define default_bottom 0
#define default_right 0
#define default_edgeInsets UIEdgeInsetsMake(default_top, default_left, default_bottom, default_right)
#define default_headerReferenceSize CGSizeMake(0, 0)
#define default_footerReferenceSize CGSizeMake(0, 0)

#define default_itemSpacing 0
#define default_lineSpacing 0

static NSString * const reuseIdentifier = @"BDPMainCollectionViewCell";

@interface BDPCodeHomePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@property (assign,nonatomic) NSInteger colNumber;
@property (assign,nonatomic) NSInteger cellWidth;
@property (assign,nonatomic) NSInteger cellHeight;
@property (assign,nonatomic) UIEdgeInsets edgeInsets;

@property (assign, nonatomic) CGSize headerReferenceSize;
@property (assign, nonatomic) CGSize footerReferenceSize;

@property (assign, nonatomic) NSUInteger itemSpacing;
@property (assign, nonatomic) NSUInteger lineSpacing;

@property (strong, nonatomic)  UICollectionView *collectionView;
@property (strong, nonatomic)  UICollectionViewFlowLayout *layout;

@property (assign, nonatomic) NSInteger totallNumber;

@property (strong, nonatomic) NSMutableArray<BDPHomeLearnData*> *datas;
@end

@implementation BDPCodeHomePageViewController


- (instancetype)init {
    return [self initWithTotalNumber:default_totalNumber];
}

- (instancetype)initWithTotalNumber: (NSInteger)totalNumber {
    self.totallNumber = totalNumber;
    return [self initWithColNumber:default_colNumber];
}

- (instancetype)initWithColNumber: (NSInteger)colNumber {
    if (colNumber <= 0) {
        colNumber = default_colNumber;
    }
    return [self initWithColNumber:colNumber sectionInset:default_edgeInsets];
}

- (instancetype)initWithColNumber: (NSInteger)colNumber sectionInset: (UIEdgeInsets)edgeInsets{
    float blockWidth = (SCREEN_WIDTH - (edgeInsets.left + edgeInsets.right) * (colNumber - 1))/(colNumber);
    self.colNumber = colNumber;
    self.edgeInsets = edgeInsets;
    return [self initWithCellWidth:blockWidth cellHeight:blockWidth];
}

- (instancetype)initWithCellWidth: (float)cellWidth cellHeight: (float)cellHeight {
    if (cellHeight <= 0) {
        cellHeight = default_cellHeight;
    }
    return [self initWithCellWidth: cellWidth cellHeight: cellHeight itemSpacing: default_itemSpacing lineSpacing: default_lineSpacing];
}

- (instancetype)initWithCellWidth: (float)cellWidth cellHeight: (float)cellHeight itemSpacing: (NSUInteger)itemSpacing lineSpacing: (NSUInteger)lineSpacing {
    return [self initWithCellWidth: cellWidth cellHeight: cellHeight itemSpacing: itemSpacing lineSpacing: lineSpacing sectionInset: default_edgeInsets headerReferenceSize:default_headerReferenceSize footerReferenceSize:default_footerReferenceSize];
}

- (instancetype)initWithCellWidth: (float)cellWidth cellHeight: (float)cellHeight itemSpacing: (NSUInteger)itemSpacing lineSpacing: (NSUInteger)lineSpacing sectionInset: (UIEdgeInsets)edgeInsets headerReferenceSize: (CGSize)headerReferenceSize footerReferenceSize: (CGSize)footerReferenceSize {
    self = [super init];
    if (self) {
        self.cellWidth = cellWidth;
        self.cellHeight = cellHeight;
        self.edgeInsets = edgeInsets;
        self.itemSpacing = itemSpacing;
        self.lineSpacing = lineSpacing;
        self.headerReferenceSize = headerReferenceSize;
        self.footerReferenceSize = footerReferenceSize;
        //创建一个流式布局对象
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //设置每个cell的大小
        
        layout.itemSize = CGSizeMake(cellWidth, cellHeight);
        //设置每个cell间的最小水平间距
        layout.minimumInteritemSpacing = itemSpacing;
        //设置每个cell间的行间距
        layout.minimumLineSpacing = lineSpacing;
        //设置每一组距离四周的内边距
        layout.sectionInset = edgeInsets;
        layout.headerReferenceSize = headerReferenceSize;
        layout.footerReferenceSize = footerReferenceSize;
        //返回
        self.layout = layout;

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFakeData];
    [self createUI];
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

// 本地加载 --- 创建不带标题的图片轮播器



#pragma mark ---- UI init

- (void) createUI {
    [self createCycleScrollView];
    [self createCollectionView];
    [self setUI];
}

- (void) createCycleScrollView {
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    // cycleScrollView2.titlesGroup = titles;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    });

    [self.view addSubview:cycleScrollView];
}

- (void) createCollectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH, SCREEN_HEIGHT - 180 - 64 - 48) collectionViewLayout:self.layout];
        [self.view addSubview:self.collectionView];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        [self.collectionView registerClass:[BDPMainCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        //注册区头视图
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"%@_header",reuseIdentifier]];
        //注册区尾视图
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[NSString stringWithFormat:@"%@_footer",reuseIdentifier]];
    }
}

-(void) setUI {
    self.view.backgroundColor = bdp_color_white;
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
    // return _collectionInfos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDPMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    [cell addTopBorderWithColor:[UIColor darkGrayColor] andWidth:0.3];
    [cell addLeftBorderWithColor:[UIColor darkGrayColor] andWidth:0.3];
    
    if (_datas && _datas.count > indexPath.row) {
        [cell setTitle:[[_datas objectAtIndex:indexPath.row] title]];
    }
    
    // 设置边框，防止重叠
    if (indexPath.row % _colNumber == (_colNumber - 1) || indexPath.row == (_totallNumber-1)) {
        [cell addRightBorderWithColor:[UIColor darkGrayColor] andWidth:0.3];
    }
    if (indexPath.row >= ((_totallNumber - _colNumber))) {
        [cell addBottomBorderWithColor:[UIColor darkGrayColor] andWidth:0.3];
    }
    [cell setUI];
//    if (_collectionInfos && _collectionInfos.count > 0) {
//        SDHZShareCollectionInfo *info = _collectionInfos[indexPath.row];
//        [cell setCollectionCellWithLabelName:[self getLabelNameByFlag:info.shareFlag] imageName:[self getImageNameByFlag:info.shareFlag]];
//    }
    //cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}


- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){_cellWidth,_cellHeight};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return _edgeInsets;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return _itemSpacing;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return _lineSpacing;
}


#pragma mark ---- UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    BDPHomeLearnData *cellLearnData = (BDPHomeLearnData *)[self.datas objectAtIndex:index];
    
    BDPTestViewController *ctrl = [[BDPTestViewController alloc] init];
    [ctrl setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ctrl animated:YES];
//    
//    if (cellLearnData && cellLearnData.className) {
//        Class clzz = NSClassFromString(cellLearnData.className);
//        if ([clzz isSubclassOfClass: [UIViewController class]]) {
//            UIViewController * ctrl = [[clzz alloc] init];
//            [ctrl setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:ctrl animated:YES];
//        }
//    } else {
//        BDPTestViewController *ctrl = [[BDPTestViewController alloc] init];
//        [ctrl setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:ctrl animated:YES];
//    }
    
}

- (void)setFakeData {
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    
    for (int i = 0; i<self.totallNumber; i++) {
        BDPHomeLearnData *obj = [BDPHomeLearnData new];
        obj.learnID = i;
        obj.title = [NSString stringWithFormat:@"第%d课",i+1];
        if (i == 0 ) {
            obj.className = @"BDPDrawerViewController";
        } else {
            obj.className = @"BDPTestViewController";
        }
        [_datas addObject:obj];
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"---点击了第%ld张图片", (long)index);
    BDPTestViewController *ctrl = [[BDPTestViewController alloc] init];
    [ctrl setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ctrl animated:YES];
}

//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
//    NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
//}

@end
