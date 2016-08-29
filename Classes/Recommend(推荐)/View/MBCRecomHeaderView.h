//
//  MBCRecomHeaderView
//  iCocosCollection
//
//  Created by iCocos on 16/7/31.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//   直播头部

#import <UIKit/UIKit.h>

#import "MBCRecomHeaderModel.h"
@interface MBCRecomHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *goUp;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property(nonatomic,strong)MBCRecomHeaderModel *recomHeaderModel;
@end
