//
//  QYCollectionViewCell.h
//  01-UICollectionDemo
//
//  Created by qingyun on 15/12/8.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYApp;

@interface QYCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong) QYApp *app;

@end
