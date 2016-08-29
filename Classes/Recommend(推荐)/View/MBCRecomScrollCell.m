//
//  MBCRecomScrollCell.m
//  iCocosCollection
//
//  Created by iCocos on 16/7/31.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCRecomScrollCell.h"
#import "MBCRecomScrModel.h"
#import "UIImageView+WebCache.h"
#import "CycleScrollView.h"
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface MBCRecomScrollCell ()
//轮播图的第三方框架
@property (nonatomic,retain)CycleScrollView *mainScrollView;
@end
@implementation MBCRecomScrollCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)setCellModel:(NSArray *)obj
{
    if (obj) {
        NSMutableArray *viewsArray = [@[] mutableCopy];
        
        for (int i = 0; i<obj.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height)];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, ScreenWidth, 20)];
            [imageView addSubview:label];
            
            MBCRecomScrModel *model = [[MBCRecomScrModel alloc]init];
            model = obj[i];
            label.text = [NSString stringWithFormat:@"      %@",model.title];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
            [viewsArray addObject:imageView];
        }
//        初始化+数组 即可完成轮播图
        self.mainScrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height)animationDuration:2.0 Count:viewsArray.count]; // 2秒播一次
//        数据源：获取第pageIndex个位置的contentView

        self.mainScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex)
        {
            return viewsArray[pageIndex];
        };
        
        // 获取总的page个数
        self.mainScrollView.totalPagesCount = ^NSInteger(void){
            return viewsArray.count;
        };
        [self addSubview:self.mainScrollView];
    }
}
@end
