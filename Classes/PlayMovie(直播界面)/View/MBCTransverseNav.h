//
//  MBCTransverseNav.h
//  iCocosCollection
//
//  Created by iCocos on 16/8/4.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//  横屏

#import <UIKit/UIKit.h>

@protocol MBCTansveNavDelegate <NSObject>

-(void)TransverseNavWillDidOnclick:(NSInteger)tag;

@end
@interface MBCTransverseNav : UIView
@property (nonatomic,weak) id<MBCTansveNavDelegate>delegate;
@end
