//
//  MBCColumnCell.m
//  iCocosCollection
//
//  Created by iCocos on 16/8/4.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCColumnCell.h"
#import "MBCColumnModel.h"
#import "UIImageView+WebCache.h"
@implementation MBCColumnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setColumn:(MBCColumnModel *)column
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:column.image]];
    
    self.name.text = column.name;
    
}
@end
