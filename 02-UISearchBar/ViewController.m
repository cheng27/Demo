//
//  ViewController.m
//  02-UISearchBar
//
//  Created by qingyun on 15/12/5.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,strong) NSArray *keys;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) BOOL isSearching;
@property (nonatomic,strong) NSArray *resultArray;//搜索结果

@end

@implementation ViewController

- (void)loadDatasFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *allKeys = _dict.allKeys;
    _keys = [allKeys sortedArrayUsingSelector:@selector(compare:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDatasFromFile];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITableViewDataSource
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isSearching) {
        return 1;
    }
    return _keys.count;
}
//每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearching) {
        return _resultArray.count;
    }
    
    NSString *key = _keys[section];
    NSArray *array = _dict[key];
    return array.count;
}
//行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (_isSearching) {
        cell.textLabel.text = _resultArray[indexPath.row];
    }else
    {
        NSString *key = _keys[indexPath.section];
        NSArray *array = _dict[key];
        cell.textLabel.text = array[indexPath.row];
    }
    return cell;
}
//section头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_isSearching) {
        return nil;
    }
    return _keys[section];
}
//索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_isSearching) {
        return nil;
    }
    return _keys;
}
#pragma mark - UISearchBarDelegate
//已经开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //显示取消按钮
    searchBar.showsCancelButton = YES;
}
//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //隐藏取消按钮
    searchBar.showsCancelButton = NO;
    //searchBar失去第一响应
    [searchBar resignFirstResponder];
    searchBar.text = nil;
    //更改搜索状态
    _isSearching = NO;
    [_tableView reloadData];
}
//点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //searchBar失去第一响应
    [searchBar resignFirstResponder];
    //隐藏取消按钮
    searchBar.showsCancelButton = NO;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {//clear
        _isSearching = NO;
        [_tableView reloadData];
        return;
    }
    _isSearching = YES;
    //搜索关键字
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[CD] %@",searchText];
    NSMutableArray *results = [NSMutableArray array];
    for (NSString *key in _keys) {
        NSArray *array = _dict[key];
        NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
        [results addObjectsFromArray:filteredArray];
    }
    _resultArray = results;
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
