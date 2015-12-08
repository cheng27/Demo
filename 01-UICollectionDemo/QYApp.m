//
//  QYApp.m
//  01-UICollectionDemo
//
//  Created by qingyun on 15/12/8.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "QYApp.h"
#import <UIKit/UIKit.h>

@implementation QYApp

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _icon = [UIImage imageNamed:dict[kIconKey]];
        _title = dict[kTitleKey];
    }
    return self;
}

+ (instancetype)appWithDict:(NSDictionary *)dict
{
    return [[QYApp alloc] initWithDict:dict];
}
@end
