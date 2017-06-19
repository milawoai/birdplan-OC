//
//  BDPCodeHomePageViewController.m
//  birdplanOC
//
//  Created by ygj on 2017/6/19.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPCodeHomePageViewController.h"
#import "BDPMainCollectionViewCell.h"
#import "UIView+BDPHelper.h"

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

@interface BDPCodeHomePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (assign,nonatomic) NSInteger colNumber;
@property (assign,nonatomic) NSInteger cellWidth;
@property (assign,nonatomic) NSInteger cellHeight;
@property (assign,nonatomic) UIEdgeInsets edgeInsets;

@property (assign,nonatomic) CGSize headerReferenceSize;
@property (assign,nonatomic) CGSize footerReferenceSize;

@property (assign,nonatomic) NSUInteger itemSpacing;
@property (assign,nonatomic) NSUInteger lineSpacing;

@property (strong, nonatomic)  UICollectionView *collectionView;
@property (strong, nonatomic)  UICollectionViewFlowLayout *layout;

@property (assign,nonatomic) NSInteger totallNumber;
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
    // Do any additional setup after loading the view.
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:self.layout];
        [self.view addSubview:self.collectionView];

        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.collectionView registerClass:[BDPMainCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        //注册区头视图
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"%@_header",reuseIdentifier]];
        //注册区尾视图
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[NSString stringWithFormat:@"%@_footer",reuseIdentifier]];
    }
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

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totallNumber;
    // return _collectionInfos.count;
    //return _section0Array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDPMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    [cell addTopBorderWithColor:[UIColor darkGrayColor] andWidth:0.3];
    [cell addLeftBorderWithColor:[UIColor darkGrayColor] andWidth:0.3];
    
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
//    if (_collectionInfos && _collectionInfos.count > 0) {
//        SDHZShareCollectionInfo *info = _collectionInfos[indexPath.row];
//        [self shareActionWithFlag:info.shareFlag];
//    }
}
@end
