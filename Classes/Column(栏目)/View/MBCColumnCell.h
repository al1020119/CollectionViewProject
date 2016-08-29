//
//  MBCColumnCell.h
//  iCocosCollection
//
//  Created by iCocos on 16/8/4.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBCColumnModel;
@interface MBCColumnCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic,strong)MBCColumnModel *column;
@end
