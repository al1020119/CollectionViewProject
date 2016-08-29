//
//  MBCRecomHeaderView.m
//  iCocosCollection
//
//  Created by iCocos on 16/7/31.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
// 直播头部

#import "MBCRecomHeaderView.h"

@interface MBCRecomHeaderView ()


@end
@implementation MBCRecomHeaderView

-(void)setRecomHeaderModel:(MBCRecomHeaderModel *)recomHeaderModel
{
    self.name.text = recomHeaderModel.name;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
