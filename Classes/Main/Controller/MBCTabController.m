//
//  MBCTabController.m
//  iCocosCollection
//
//  Created by iCocos on 16/7/31.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCTabController.h"
#import "MBCNavigationController.h"
#import "MBCReconmendController.h"
#import "MBCColumnController.h"
#import "MBCDirectSeedController.h"
#import "MBCProfileController.h"
@interface MBCTabController ()

@end



@implementation MBCTabController

+(void)initialize
{
    //    获取当前页面下所有的item
    UITabBarItem *item = [UITabBarItem appearance];
    //    设置当前页面下选中状态下所有的item的颜色
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:([UIColor orangeColor])} forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildVCS];
   
}

#pragma mark - 添加全部控制器

-(void)addChildVCS
{
    //推荐
    MBCReconmendController *reconmend = [[MBCReconmendController alloc]init];
    [self addChildVC:reconmend andTitlt:@"推荐" andImage:@"tabbar_home" andSelectedImage:@"tabbar_home_sel"];
    
    //栏目
    MBCColumnController *column = [[MBCColumnController alloc]init];
    [self addChildVC:column andTitlt:@"栏目" andImage:@"tabbar_game" andSelectedImage:@"tabbar_game_sel"];
    
    //直播
    MBCDirectSeedController *dicectSeed = [[MBCDirectSeedController alloc]init];
    [self addChildVC:dicectSeed andTitlt:@"直播" andImage:@"tabbar_room" andSelectedImage:@"tabbar_room_sel"];

    //我的
    MBCProfileController *my = [[MBCProfileController alloc]init];
    [self addChildVC:my andTitlt:@"我的" andImage:@"tabbar_me" andSelectedImage:@"tabbar_me"];
}

#pragma mark 添加单个控制器
-(void)addChildVC:(UIViewController *)childVC andTitlt:(NSString *)title andImage:(NSString *)image andSelectedImage:(NSString *)selectedImage
{
    childVC.title = title;
    childVC.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MBCNavigationController *nav = [[MBCNavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:nav];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
   }



@end
