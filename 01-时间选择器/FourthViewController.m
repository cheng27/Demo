//
//  FourthViewController.m
//  01-时间选择器
//
//  Created by qingyun on 15/12/7.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong) NSDictionary *dict;
//左列数据
@property (nonatomic,strong) NSArray *leftDatas;
//右列数据
@property (nonatomic,strong) NSArray *rightDatas;

@end

@implementation FourthViewController

- (void)loadDataFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"statedictionary" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    //左列数据
    _leftDatas = [_dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    //右列数据
    _rightDatas = _dict[_leftDatas.firstObject];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromFile];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(UIButton *)sender {
    
//    NSString *selectedData = [NSString stringWithFormat:@"%@,%@",_leftDatas.firstObject,_rightDatas];
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你选择的是:" message:selectedData preferredStyle:UIAlertControllerStyleAlert];
//    //添加action
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//        
//    }];
//    
//    [alertController addAction:action];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIPickerViewDataSource
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {//左列数据
        return _leftDatas.count;
    }
    //右列数据
    return _rightDatas.count;
}

#pragma mark - UIPickerViewDelegate
//设置行内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {//左列内容
        return _leftDatas[row];
    }
    //右列内容
    return _rightDatas[row];
}
//选中行数
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {//操作左列
        NSString *key = _leftDatas[row];
        _rightDatas = _dict[key];
        //刷新右列
        [pickerView reloadComponent:1];
        //更新右列选中的行为0
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}
//每列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return 100;
    }
    return 200;
}
@end
