//
//  QYApp.h
//  01-UICollectionDemo
//
//  Created by qingyun on 15/12/8.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

#define kIconKey @"icon"
#define kTitleKey @"name"

@interface QYApp : NSObject

@property (nonatomic,strong) UIImage *icon;
@property (nonatomic,strong) NSString *title;

+ (instancetype)appWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
