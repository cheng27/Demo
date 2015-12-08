//
//  QYCollectionViewCell.m
//  01-UICollectionDemo
//
//  Created by qingyun on 15/12/8.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "QYCollectionViewCell.h"
#import "QYApp.h"

@implementation QYCollectionViewCell

- (void)setApp:(QYApp *)app
{
    _app = app;
    _imageView.image = app.icon;
    _label.text = app.title;
}

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor orangeColor];
    self.selectedBackgroundView = view;
}

@end
