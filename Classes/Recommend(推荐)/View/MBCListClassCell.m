//
//  MBCListClassCell.m
//  iCocosCollection
//
//  Created by iCocos on 16/7/31.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//   圆圈列表

#import "MBCListClassCell.h"
#import "MBCListClassModel.h"
#import "UIImageView+WebCache.h"
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
@implementation MBCListClassCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)setCellModel:(NSArray *)obj
{
    //创建 Scroll
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height)];
    [self addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    for (NSInteger i =0; i<obj.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10+(ScreenWidth/5+20)*i, 0, ScreenWidth/5, ScreenWidth/5);
        MBCListClassModel *model = obj[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth/7, ScreenWidth/7)];
        imageView.layer.cornerRadius = imageView.frame.size.width /2;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
        
        [btn addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth/7+15, ScreenWidth/5, 20)];
        [btn addSubview:label];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = model.title;
        [scrollView addSubview:btn];
    }
    scrollView.contentSize = CGSizeMake(ScreenWidth/4*obj.count+20, 0);
}
@end
