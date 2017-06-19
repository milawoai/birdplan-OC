//
//  BDPMainCollectionViewController.m
//  birdplanOC
//
//  Created by ygj on 2017/4/19.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "BDPMainCollectionViewController.h"
#import "BDPMainCollectionViewCell.h"

#define default_colNumber 3
#define default_cellHeight 100
// CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
#define default_top 0
#define default_left 0
#define default_bottom 0
#define default_right 0
#define default_edgeInsets UIEdgeInsetsMake(default_top, default_left, default_bottom, default_right)
#define default_headerReferenceSize CGSizeMake(0, 40)
#define default_footerReferenceSize CGSizeMake(0, 40)

#define default_itemSpacing 0
#define default_lineSpacing 0

@interface BDPMainCollectionViewController ()

@property (assign,nonatomic) NSInteger colNumber;
@property (assign,nonatomic) NSInteger cellHeight;
@property (assign,nonatomic) UIEdgeInsets edgeInsets;
@end

@implementation BDPMainCollectionViewController

static NSString * const reuseIdentifier_unuse = @"BDPMainCollectionViewCell_Unuse";

- (instancetype)init {
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
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView setBackgroundColor:bdp_color_white];
    [self.collectionView registerClass:[BDPMainCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier_unuse];
    //注册区头视图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BDPMainCollectionViewController_header"];
    //注册区尾视图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"BDPMainCollectionViewController_footer"];
    
//    [self.collectionView registerNib:[UINib nibWithNibName:@"BDPMainCollectionViewCell"bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    // return self.colNumber?self.colNumber:5;
    return 18;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDPMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier_unuse forIndexPath:indexPath];
    // Configure the cell
    [cell setUI];
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //返回每个item的大小
////    if (indexPath.section == 0) {
////        return CGSizeMake(200, 200);
////    }
////    return CGSizeMake(100, 100);
//}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


@end
