//
//  ViewController.m
//  01-时间选择器
//
//  Created by qingyun on 15/12/7.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置范围
    //设置最小的时间
    //创建时间的组成部分
    NSDateComponents *components = [[NSDateComponents alloc] init];
    //设置日期
    components.year = 2015;
    components.month = 11;
    components.day = 27;
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *mindate = [calendar dateFromComponents:components];
    _datePicker.minimumDate = mindate;
    
    //设置最大的时间
    NSDate *maxdate = [[NSDate alloc] initWithTimeIntervalSinceNow:10*24*60*60];
    _datePicker.maximumDate = maxdate;
    
    //把世界时间转化成当前时区的时间
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger inter = [timeZone secondsFromGMTForDate:_datePicker.date];
    NSDate *localDate = [_datePicker.date dateByAddingTimeInterval:inter];
    
    //添加事件监听
    [_datePicker addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)datePickerValueChange:(UIDatePicker *)datePicker
{
    NSLog(@"%@",[datePicker.date descriptionWithLocale:datePicker.locale]);
}
- (IBAction)selectedClick:(UIButton *)sender {
    //当前的时间
    NSString *selectedDate = [_datePicker.date descriptionWithLocale:_datePicker.locale];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你选择的时间是:" message:selectedDate preferredStyle:UIAlertControllerStyleAlert];
    //添加action
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
