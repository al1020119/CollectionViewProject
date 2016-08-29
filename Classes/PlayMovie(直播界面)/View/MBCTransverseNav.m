//
//  MBCTransverseNav.m
//  iCocosCollection
//
//  Created by iCocos on 16/8/4.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCTransverseNav.h"
#import "UIButton+Button.h"
@implementation MBCTransverseNav
{
    //返回按钮
    UIButton *_backBtn;
    
    //横屏状态时的按钮
    UIButton *_definitionBtn;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        
          _backBtn  =[UIButton ButtonWithRect:CGRectMake(5, 5, 30, 30) title:nil titleColor:nil Image:@"movie_back_s" HighlightedImage:nil clickAction:@selector(ONWillClick:) viewController:self contentEdgeInsets:UIEdgeInsetsZero tag:201];
        //创建按钮 添加按钮
        [self addSubview:_backBtn];
        
        
        _definitionBtn = [UIButton ButtonWithRect:CGRectMake(self.frame.size.width-50, 5, 30, 30) title:nil titleColor:nil Image:@"movie_setting" HighlightedImage:nil clickAction:@selector(ONWillClick:) viewController:self contentEdgeInsets:UIEdgeInsetsZero tag:201];
        [self addSubview:_definitionBtn];
      
    }
    
    return self;
}
//点击返回按钮 触发代理
-(void)ONWillClick:(UIButton *)btn
{

    if ([self.delegate respondsToSelector:@selector(TransverseNavWillDidOnclick:)]) {
        [self.delegate TransverseNavWillDidOnclick:btn.tag];
    }
}
@end
