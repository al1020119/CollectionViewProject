//
//  MBCReconmendController.m
//  iCocosCollection
//
//  Created by iCocos on 16/7/31.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCReconmendController.h"
#import "MBCProfileController.h"
#import "MBCPlayViewCtr.h"

#import "MBCBaseCell.h"
#import "MBCRecomScrollCell.h"
#import "MBCListClassCell.h"
#import "MBCRecomHeaderView.h"
#import "MBCMoviewCell.h"

#import "MBCRecomScrModel.h"
#import "MBCListClassModel.h"
#import "MBCRecomHeaderModel.h"
#import "MBCMovieModel.h"

#import "MJRefresh.h"
#import "AFNetworking.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//推荐url
#define RecommendUrl @"http://www.quanmin.tv/json/page/appv2-index/info.json?0330152228"
@interface MBCReconmendController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
//轮播图
@property(nonatomic , strong) NSMutableArray  *tempArrA;
//圆形 列表
@property(nonatomic , strong) NSMutableArray  *tempArrB;
//精彩推荐(头部)
@property(nonatomic , strong) NSMutableArray  *tempArrC;
//单个直播
@property(nonatomic , strong) NSMutableArray  *tempArrD;
//所有数据
@property(nonatomic , strong) NSMutableDictionary *dataDic;
@end

@implementation MBCReconmendController

#pragma mark 懒加载存放数据的数组
// 轮播图
-(NSMutableArray *)tempArrA{
    if (_tempArrA == nil) {
        _tempArrA = [[NSMutableArray alloc]init];
    }
    return _tempArrA;
}

//圆形列表
-(NSMutableArray *)tempArrB{
    if (_tempArrB == nil) {
        _tempArrB = [[NSMutableArray alloc]init];
    }
    return _tempArrB;
}
//精彩推荐(头部)
-(NSMutableArray *)tempArrC{
    if (_tempArrC == nil) {
        _tempArrC = [[NSMutableArray alloc]init];
    }
    return _tempArrC;
}
//直播数组
-(NSMutableArray *)tempArrD{
    if (_tempArrD == nil) {
        _tempArrD = [[NSMutableArray alloc]init];
    }
    return _tempArrD;
}
//所有数据
-(NSMutableDictionary *)dataDic{
    if (_dataDic == nil) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建流水布局
    [self CreatCollerctionView];
    //注册cell(流水布局必须要注册cell)
    [self registerCell];
    // 解析网络数据
    [self httpRequest];
    
    // 添加一个下拉刷新头部控件
    [self.collectionView addHeaderWithTarget:self action:@selector(httpRequest)];
    // 主动让下拉刷新头部控件进入刷新状态
    [self.collectionView headerBeginRefreshing];
}

#pragma mark -创建流水布局
-(void)CreatCollerctionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    self.flowLayout = flowLayout;
    self.collectionView = collectionView;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark -注册cell
-(void)registerCell
{
    //轮播图 Cell
    [self.collectionView registerClass:[MBCRecomScrollCell class] forCellWithReuseIdentifier:@"MBCRecomScrollCell"];
    
    //圆圈列表 Cell
    [self.collectionView registerClass:[MBCListClassCell class] forCellWithReuseIdentifier:@"MBCListClassCell"];
    
    //精彩推荐 Cell(头部) （此处是坑：注册collction头部(UICollectionReusableView)时必须要设置kind-与下面设置类型一致）否则报could  not dequeue a view of kind 错
    [self.collectionView registerNib:[UINib nibWithNibName:@"MBCRecomHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MBCRecomHeaderView"];
    
    
    //单个直播 Cell 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"MBCMoviewCell" bundle:nil] forCellWithReuseIdentifier:@"MBCMoviewCell"];
}

#pragma mark -解析网络数据
-(void)httpRequest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:RecommendUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (self.dataDic) { //再次请求数据时，有值则将每个数组清空
            [self.dataDic  removeAllObjects];
            [self.tempArrA removeAllObjects];
            [self.tempArrB removeAllObjects];
            [self.tempArrC removeAllObjects];
            [self.tempArrD removeAllObjects];
        }
        //轮播图数组
        self.tempArrA = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"app-index"]) {
            MBCRecomScrModel *recomM = [[MBCRecomScrModel alloc]init];
            recomM.title = dict[@"title"];
            recomM.thumb = dict[@"thumb"];
            [self.tempArrA addObject:recomM];
        }
        
        //圆形列表数组
        self.tempArrB = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"app-classification"]) {
            MBCListClassModel *classM = [[MBCListClassModel alloc]init];
            classM.title = dict[@"title"];
            classM.thumb = dict[@"thumb"];
            [self.tempArrB addObject:classM];
            
         //精彩推荐数组(头部)
            self.tempArrC = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"list"]) {
                MBCRecomHeaderModel *recomheaderM = [[MBCRecomHeaderModel alloc]init];
                recomheaderM.name = dict[@"name"];
                recomheaderM.slug = dict[@"slug"];
                [self.tempArrC addObject:recomheaderM];
            }
            
          //所有的数据列表标题（精彩推荐、英雄联盟、全民星秀、单机游戏。。。）
         NSArray *classArr = @[@"app-recommendation",@"app-lol",@"app-beauty",@"app-webgame",@"app-dota2",@"app-heartstone",@"app-tvgame",@"app-blizzard",@"app-sport",@"app-dnf",@"app-minecraft"];
            
            //直播数组
            self.tempArrD = [NSMutableArray array];
            for (int i =0; i<classArr.count; i++) {
                NSMutableArray *tempArr = [NSMutableArray array];
                for (NSDictionary *dict in responseObject[classArr[i]]) {
                    MBCMovieModel *movieM = [[MBCMovieModel alloc]init];
                    movieM.avatar = dict[@"link_object"][@"avatar"];
                    movieM.thumb = dict[@"link_object"][@"thumb"];
                    movieM.title = dict[@"link_object"][@"title"];
                    movieM.nick = dict[@"link_object"][@"nick"];
                    movieM.view =dict[@"link_object"][@"view"];
                    movieM.uid = dict[@"link_object"][@"uid"];
                    [tempArr addObject:movieM];
                }
                if (tempArr) {
                    [self.tempArrD addObject:tempArr];
                }
            }
        }
        //保存数据
        [self.dataDic setObject:self.tempArrA forKey:@"A"];
        [self.dataDic setObject:self.tempArrB forKey:@"B"];
        [self.dataDic setObject:self.tempArrC forKey:@"C"];
        [self.dataDic setObject:self.tempArrD forKey:@"D"];
        //刷新Collcetion
        [self.collectionView reloadData];
        //让下拉刷新头部控件停止刷新状态
        [self.collectionView headerEndRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark <UICollectionViewDataSource>
//返回多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.tempArrD.count +2;
}
//每组多少个
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==2) { //精彩推荐(头部)
        return 2;
    }else if (section>2)
    {
        NSArray *arr = self.tempArrD[section-2];
        if (arr.count>=2&&arr.count<4) { //大于2小于4返回2组
            return 2;
        }else if (arr.count>=4){ //其他的列表(英雄联盟、全民星秀、单机。。。。)
            return 4;
        }
    }
    return 1;
}
//布局CollctionViewのsection
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) { //轮播图
        return CGSizeMake(ScreenWidth, ScreenWidth/7*3);
    }else if (indexPath.section==1)//圆形列表
    {
        return CGSizeMake(ScreenWidth, ScreenWidth/5+20);
    } //其他列表
    return CGSizeMake((ScreenWidth-20)/2, (ScreenWidth-20)/2-10);
}

//collcetion的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID =nil;
    
    if (indexPath.section==0) {
        cellID =@"MBCRecomScrollCell";
    }else if (indexPath.section==1)
    {
        cellID =@"MBCListClassCell";
    }else{
        cellID =@"MBCMoviewCell";
    }
    MBCBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.section==0) //轮播图
    {
        [cell setCellModel:self.tempArrA];
    } else if(indexPath.section==1) //圆形列表
    {
        [cell setCellModel:self.tempArrB];
    }else if (indexPath.section>1) //其他列表
    {
        NSArray *arr = self.tempArrD[indexPath.section-2];
        MBCMovieModel *model =arr[indexPath.row];
        [cell setCellModel:model];
    }
    return cell;
}

//组之间的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0 ||section==1) { //轮播图||圆形列表
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
//collcetion(头部) 非轮播图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>1) { //大于圆形列表
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            MBCRecomHeaderView *ReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MBCRecomHeaderView"forIndexPath:indexPath];
            if (indexPath.section==2) //精彩推荐头部
            {
                [ReusableView.goUp setTitle:@"换一换" forState:UIControlStateNormal];
            }else{
                 [ReusableView.goUp setTitle:@"进去看看" forState:UIControlStateNormal];
            }
            ReusableView.recomHeaderModel = self.tempArrC[indexPath.section];
            return ReusableView;
        }
    }
    return nil;
}
//collction头部尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section>1)//大于圆形列表
    {
        return CGSizeMake(ScreenWidth, 40);
    }
    return CGSizeMake(0, 0);
}

#pragma mark <UICollectionViewDelegate>
//colletionView点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.section>1) { // 精彩推荐
        NSArray *arr = self.tempArrD[indexPath.section-2];
        MBCMovieModel *model = arr[indexPath.row];
        MBCPlayViewCtr *playCtr = [[MBCPlayViewCtr alloc]initWithVideoId:model.uid];playCtr.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:playCtr animated:YES];
    }

}
@end
