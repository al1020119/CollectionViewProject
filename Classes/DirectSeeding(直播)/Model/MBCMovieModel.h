//
//  MBCMovieModel.h
//  iCocosCollection
//
//  Created by iCocos on 16/8/3.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//  播放

#import <Foundation/Foundation.h>

@interface MBCMovieModel : NSObject
/**头像*/
@property (nonatomic,strong)NSString *avatar;
/**图片*/
@property (nonatomic,strong)NSString *thumb;
/**标题*/
@property (nonatomic,strong)NSString *title;
/**昵称*/
@property (nonatomic,strong)NSString *nick;
/***/
@property (nonatomic,strong)NSString *view;
/**Uid*/
@property (nonatomic,strong)NSString *uid;

@end
