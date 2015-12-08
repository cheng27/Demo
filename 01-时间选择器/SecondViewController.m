//
//  SecondViewController.m
//  01-时间选择器
//
//  Created by qingyun on 15/12/7.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong) NSArray *datas;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置pickerView的数据源和代理
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    _datas = [[NSArray alloc] initWithObjects:@"Luke", @"Leia", @"Han", @"Chewbacca", @"Artoo", @"Threepio", @"Lando", nil];
    
    //设置label的文本
    _label.text = _datas.firstObject;
    
}


#pragma  mark - UIPickerViewDataSource
//设置列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//每列中的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _datas.count;
}

#pragma mark - UIPickerDelegate
//设置文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _datas[row];
}
//设置属性文本
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0) {
        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:_datas[row] attributes:@{NSUnderlineStyleAttributeName:@1,NSForegroundColorAttributeName:[UIColor cyanColor]}];
        return attributeString;
    }
    return nil;
}
//设置行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:_datas[row] attributes:@{NSUnderlineStyleAttributeName:@1,NSForegroundColorAttributeName:[UIColor cyanColor]}];
    
    _label.attributedText = attributedString;
}


@end
