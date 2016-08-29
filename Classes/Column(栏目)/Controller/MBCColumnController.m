//
//  MBCColumnController.m
//  iCocosCollection
//
//  Created by iCocos on 16/7/31.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCColumnController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"

#import "MBCColumnCell.h"
#import "MBCColumnModel.h"
//栏目url
#define ColumnUrl @"http://www.quanmin.tv/json/categories/list.json?0330152804"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface MBCColumnController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation MBCColumnController

-(NSMutableArray *)dataArr
{
    if (_dataArr==nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UIControllerView
    [self createCollection];
    
    //注册cell
    [self registerCell];
    
    //解析网络数据
    [self httpRequest];
    //添加下拉刷新控件
    [self.collectionView addHeaderWithTarget:self action:@selector(httpRequest)];
    //自动下拉刷新
    [self.collectionView headerBeginRefreshing];
}

#pragma mark 创建UIControllerView
-(void)createCollection
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collcetionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    self.flowLayout = flowLayout;
    self.collectionView = collcetionView;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.collectionView.showsVerticalScrollIndicator = NO;
}

#pragma make -注册cell
-(void)registerCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"MBCColumnCell" bundle:nil] forCellWithReuseIdentifier:@"MBCColumnCell"];
}

#pragma mark -解析网络数据
-(void)httpRequest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:ColumnUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if (self.dataArr.count) {
            [self.dataArr removeAllObjects];
        }
        self.dataArr = [NSMutableArray array];
        
        for (NSDictionary *dict in responseObject) {
            MBCColumnModel *model = [[MBCColumnModel alloc]init];
            model.image = dict[@"image"];
            model.name = dict[@"name"];
            [self.dataArr addObject:model];
        }
        [self.collectionView reloadData];
        [self.collectionView headerEndRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-20)/3, (ScreenWidth-20)/9*4+30);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MBCColumnCell";
    MBCColumnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    MBCColumnModel *model = self.dataArr[indexPath.row];
    cell.column = model;
    return cell;

}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;//间隔 为5
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

@end
