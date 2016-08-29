//
//  MBCPlayView.m
//  iCocosCollection
//
//  Created by iCocos on 16/8/4.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCPlayView.h"

@implementation MBCPlayView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
+(Class)layerClass
{
    return [AVPlayerLayer class];
}
//get 方法
-(AVPlayer *)player
{
    return [(AVPlayerLayer *)[self layer] player];
}

//set方法
-(void)setPlayer:(AVPlayer *)player
{
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}
@end
