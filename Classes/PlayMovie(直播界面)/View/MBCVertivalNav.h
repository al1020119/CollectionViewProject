//
//  MBCVertivalNav.h
//  iCocosCollection
//
//  Created by iCocos on 16/8/4.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//  竖屏

#import <UIKit/UIKit.h>

@protocol MBCVertivalNavDelegate <NSObject>

-(void)didWillVerticalNavOnclick:(NSInteger)tag;

@end
@interface MBCVertivalNav : UIView

@property (nonatomic,weak)id <MBCVertivalNavDelegate>delegate;
@end
