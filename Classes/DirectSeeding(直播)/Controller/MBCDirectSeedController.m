//
//  MBCDirectSeedController.m
//  iCocosCollection
//
//  Created by iCocos on 16/7/31.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCDirectSeedController.h"
#import "MBCPlayViewCtr.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "MBCMoviewCell.h"

#import "MBCMovieModel.h"
//直播url
#define DirectSeedingUrl @"http://www.quanmin.tv/json/play/list.json?0330152923"
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface MBCDirectSeedController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collcetionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
//所有的数据
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation MBCDirectSeedController

-(NSMutableArray *)dataArr
{
    if (_dataArr==nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建collctionView
    [self creactCollectionView];
    //注册cell
    [self registerCell];
    //解析网络数据
    [self httpReuest];
    
    //添加下拉刷新控件
    [self.collcetionView addHeaderWithTarget:self action:@selector(httpReuest)];
    //自动下拉刷新
    [self.collcetionView headerBeginRefreshing];

}

#pragma mark 创建UIControllerView
-(void)creactCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collctionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.flowLayout = flowLayout;
    self.collcetionView = collctionView;
    self.collcetionView.delegate = self;
    self.collcetionView.dataSource = self;
    [self.view addSubview:self.collcetionView];
    self.collcetionView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.collcetionView.showsVerticalScrollIndicator = NO;
    
}

#pragma make -注册cell
-(void)registerCell
{
    [self.collcetionView registerNib:[UINib nibWithNibName:@"MBCMoviewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

#pragma mark -解析网络数据
-(void)httpReuest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:DirectSeedingUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (self.dataArr.count) { //请求有值
            [self.dataArr removeAllObjects]; //清空数组
        }
        for (NSDictionary *dict in responseObject[@"data"]) {
            //让下拉刷新头部控件停止刷新状态
            [self.collcetionView headerEndRefreshing];
            MBCMovieModel *liveM = [[MBCMovieModel alloc]init];
            liveM.avatar = dict[@"avatar"];
            liveM.thumb = dict[@"thumb"];
            liveM.title =dict[@"title"];
            liveM.nick = dict[@"nick"];
            liveM.view = dict[@"view"];
            liveM.uid = dict[@"uid"];
            [self.dataArr addObject:liveM];
        }
        //刷新collctionView
        [self.collcetionView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1; //1组
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     return CGSizeMake((ScreenWidth-15)/2, (ScreenWidth-15)/2-10);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"Cell";
    MBCMoviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
//    [cell setCellModel:self.dataArr[indexPath.row]];
    MBCMovieModel *model = self.dataArr[indexPath.row];
    [cell setCellModel:model];
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);

}
//间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//线条
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MBCMovieModel *model = self.dataArr[indexPath.row];
    MBCPlayViewCtr *playCtl = [[MBCPlayViewCtr alloc]initWithVideoId:model.uid];
    playCtl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playCtl animated:NO];
    
}
@end
