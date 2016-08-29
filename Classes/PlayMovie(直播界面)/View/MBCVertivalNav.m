//
//  MBCVertivalNav.m
//  iCocosCollection
//
//  Created by iCocos on 16/8/4.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCVertivalNav.h"
#import "UIButton+Button.h"
@implementation MBCVertivalNav
{
    //满屏
    UIButton *_fullScreenBtn;
    UIButton *_backBtn;
    BOOL _staraView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _backBtn = [UIButton ButtonWithRect:CGRectMake(5, 5, 30, 30) title:nil titleColor:nil Image:@"movie_back_s" HighlightedImage:nil clickAction:@selector(Onclick:) viewController:self contentEdgeInsets:UIEdgeInsetsZero tag:101];
        [self addSubview:_backBtn];
        
        _fullScreenBtn = [UIButton ButtonWithRect:CGRectMake(self.frame.size.width-35, self.frame.size.height-35, 30, 30) title:nil titleColor:nil Image:@"movie_fullscreen" HighlightedImage:nil clickAction:@selector(Onclick:) viewController:self contentEdgeInsets:UIEdgeInsetsZero tag:102];
       
        [self addSubview:_fullScreenBtn];
        _staraView = NO;
    }
    return self;
}

-(void)Onclick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didWillVerticalNavOnclick:)]) {
        [self.delegate didWillVerticalNavOnclick:btn.tag];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_staraView==NO) {
        _backBtn.hidden = YES;
        _fullScreenBtn.hidden = YES;
        _staraView= YES;
    }else{
        _backBtn.hidden = NO;
        _fullScreenBtn.hidden= NO;
        _staraView = NO;
    }
}
@end
