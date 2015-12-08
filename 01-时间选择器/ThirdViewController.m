//
//  ThirdViewController.m
//  01-时间选择器
//
//  Created by qingyun on 15/12/7.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *showView;

//存储每列中选中的行代表的rgb的值
@property (nonatomic)CGFloat redColorNum;
@property (nonatomic)CGFloat greenColorNum;
@property (nonatomic)CGFloat blueColorNum;
@end

@implementation ThirdViewController

#define QYRGBMax 255                              //rgb取值
#define QYStepValue 5                             //间隔
#define QYRowNum QYRGBMax/QYStepValue + 1         //行数
#define QYComponents 3                            //列数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //红
    NSInteger selectedRedRow = round(arc4random()%52);
    [self selectPicker:_pickerView forRow:selectedRedRow inComponemt:QYRGBComponentTypeRed];
    //绿
    NSInteger selectedGreenRow = round(arc4random()%52);
    [self selectPicker:_pickerView forRow:selectedGreenRow inComponemt:QYRGBComponentTypeGreen];
    //蓝
    NSInteger selectedBlueRow = round(arc4random()%52);
    [self selectPicker:_pickerView forRow:selectedBlueRow inComponemt:QYRGBComponentTypeBlue];
}

- (void)selectPicker:(UIPickerView *)pickerView forRow:(NSInteger)row inComponemt:(NSInteger)componmet
{
    [pickerView selectRow:row inComponent:componmet animated:YES];
    [self pickerView:pickerView didSelectRow:row inComponent:componmet];
}
#pragma mark - UIPickerViewDataSource
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return QYComponents;
}
//行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return QYRowNum;
}

#pragma mark - UIPickerViewDelegate
//属性文本
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    CGFloat redNum = 0;
    CGFloat greenNum = 0;
    CGFloat blueNum = 0;
    
    NSInteger currentNum = row * QYStepValue;
    switch (component) {
        case QYRGBComponentTypeRed:
            redNum = currentNum;
            break;
        case QYRGBComponentTypeGreen:
            greenNum = currentNum;
            break;
        case QYRGBComponentTypeBlue:
            blueNum = currentNum;
            break;
        default:
            break;
    }
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[@(currentNum) stringValue] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:redNum/255.0 green:greenNum/255.0 blue:blueNum/255.0 alpha:1]}];
    
    return attributedString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    CGFloat value = row *QYStepValue / 255.0;
    
    switch (component) {
        case QYRGBComponentTypeRed:
            _redColorNum = value;
            break;
        case QYRGBComponentTypeGreen:
            _greenColorNum = value;
            break;
        case QYRGBComponentTypeBlue:
            _blueColorNum = value;
            break;
        default:
            break;
    }
    _showView.backgroundColor = [UIColor colorWithRed:_redColorNum green:_greenColorNum blue:_blueColorNum alpha:1];
}

@end
