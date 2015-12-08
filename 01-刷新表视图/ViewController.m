//
//  ViewController.m
//  01-刷新表视图
//
//  Created by qingyun on 15/12/5.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController
static NSString *identifier = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    //设置数据源和代理
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 120;
    
    //注册单元格
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    _datas = [NSMutableArray arrayWithObjects:@"程玉娟",@"杨佑丽",@"祝献花",@"张香玉",@"张珊珊",@"赵静静", nil];
    
    //下拉刷新视图，加载齿轮
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [_tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    //添加尾视图，下拉加载更多
    UIButton *footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footerBtn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
    footerBtn.backgroundColor = [UIColor colorWithRed:189/255.0 green:64/255.0 blue:145/255.0 alpha:1];
    [footerBtn addTarget:self action:@selector(loadMoreSource) forControlEvents:UIControlEventTouchUpInside];
    
    [footerBtn setTitle:@"加载更多..." forState:UIControlStateNormal];
    //_tableView.tableFooterView = footerBtn;
    
    // Do any additional setup after loading the view, typically from a nib.
}
//加载更多
- (void)loadMoreSource
{
    [_datas addObject:@"没有了"];
    [_tableView reloadData];
}
//下拉刷新
- (void)refresh:(UIRefreshControl *)refreshControl
{
    [refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:5];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_tableView.contentOffset.y > (_tableView.contentSize.height - _tableView.frame.size.height) + 100) {
        [self loadMoreSource];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
