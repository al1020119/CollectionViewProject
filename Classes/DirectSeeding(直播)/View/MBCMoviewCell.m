//
//  MBCMoviewCell.m
//  iCocosCollection
//
//  Created by iCocos on 16/8/3.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCMoviewCell.h"
#import "MBCMovieModel.h"
#import "UIImageView+WebCache.h"
@interface MBCMoviewCell ()
//图像
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *nick;
//标题
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation MBCMoviewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellModel:(MBCMovieModel *)obj
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.title.text =obj.title;
    self.nick.text = obj.nick;
    self.thumb.layer.cornerRadius = 8;
    self.thumb.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width/2;
    self.avatar.layer.masksToBounds = YES;
    
    [self.thumb sd_setImageWithURL:[NSURL URLWithString:obj.thumb]];
    
    if ([obj.avatar isEqualToString:@""]) {
        self.avatar.image = [UIImage imageNamed:@"nil"];
    }else
    {
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:obj.avatar]];
    }
}
@end
