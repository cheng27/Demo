//
//  FifthViewController.m
//  01-时间选择器
//
//  Created by qingyun on 15/12/7.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "FifthViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface FifthViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
//图片
@property (nonatomic,strong) NSArray *images;
//播放器
@property (nonatomic,strong) AVAudioPlayer *player;
//困难程度
@property (nonatomic) NSInteger hardLevel;

@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置数据源和代理
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    _segmentedControl.selectedSegmentIndex = 1;
    _hardLevel = 3;
    
    _images = @[@"apple",@"bar",@"cherry",@"crown",@"lemon",@"seven"];
    
    [self start:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//更改难易程度
- (IBAction)segmentControlValueChange:(UISegmentedControl *)sender {
    _hardLevel = sender.selectedSegmentIndex + 2;
}
//开始游戏
- (IBAction)start:(UIButton *)sender {
    _winLabel.text = @"";
    //声明连续的相同的个数
    int sameRowNum = 0;
    int campareRow = 100;
    BOOL isWin = NO;
    
    for (int i = 0;i < 5; i++) {
        //随机数
        int ramNum = round(arc4random() % _images.count);
        if (i == 0) {
            sameRowNum = 1;
            campareRow = ramNum;
        }else
        {
            if (campareRow == ramNum) {
                sameRowNum ++;
            }else
            {
                sameRowNum = 1;
            }
            campareRow = ramNum;
        }
        //更改选中的行
        [_pickerView selectRow:ramNum inComponent:i animated:YES];
        if (sameRowNum >= _hardLevel) {
            isWin = YES;
        }
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"crunch" ofType:@"wav"];
    [self play:path];
    
    if (isWin) {
        _winLabel.text = @"win!!!";
        NSString *winPath = [[NSBundle mainBundle] pathForResource:@"win" ofType:@"wav"];
        [self play:winPath];
    }
}

- (void)play:(NSString *)soundPath
{
    _player = [[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfFile:soundPath] error:nil];
    _player.delegate = self;
    [_player prepareToPlay];
    [_player play];
}
#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _images.count;
}

#pragma mark - UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_images[row]]];
    return imageView;
}

//行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 80;
}

@end
