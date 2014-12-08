//
//  ResultsViewController.m
//  YYSearchBar
//
//  Created by Butcher on 14/12/7.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import "ResultsViewController.h"


@interface ResultsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *searchData;
@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.searchData[indexPath.row];
    return cell;
}
- (void)updateSearchResultsForSearchController:(YYSearchController *)searchController {
    NSString *searchStr = searchController.searchBar.text;

//    // 使用 NSPredicate 来过滤想要的结果
//    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"self contains[c] %@", searchStr];
//    self.searchData = [self.sourceData filteredArrayUsingPredicate:filterPredicate];

    // 使用 循环 来过滤想要的结果
    NSMutableArray *searchResultArray = [@[] mutableCopy];
    for (NSString *str in self.sourceData) {
        if ([str rangeOfString:searchStr].location != NSNotFound) {
            [searchResultArray addObject:str];
        }
    }
    self.searchData = searchResultArray;
    
    // 获取到搜索结果数据后要刷新tableView
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
