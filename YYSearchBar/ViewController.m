//
//  ViewController.m
//  YYSearchBar
//
//  Created by 于磊 on 14/12/5.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import "ViewController.h"
#import "YYSearchBar.h"
#import "YYSearchController.h"
#import "ResultsViewController.h"

@interface ViewController () <YYSearchControllerDelegate>

@property (nonatomic, retain) YYSearchController *searchController;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    YYSearchBar *searchBar = [YYSearchBar searchBarWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 44) placeholder:@"search"];
//    searchBar.delegate = self;
//    [self.view addSubview:searchBar];
    
    ResultsViewController *resultsVC = [[ResultsViewController alloc] init];
    
    self.searchController = [[YYSearchController alloc] initWithSearchResultsController:resultsVC];
    self.searchController.searchResultsUpdater = resultsVC;
    
    self.searchController.searchBar.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 44);
    self.searchController.delegate = self;
    [self.view addSubview:self.searchController.searchBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 40)];
    label.text = @"YYSearchController Demo";
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//// 当文本改变时被调用（包括清除文本）
//- (void)searchBar:(YYSearchBar *)searchBar textDidChange:(NSString *)searchText {
//    NSLog(@"%@", searchText);
//}
//// 当键盘上的 search/searchBar右侧的搜索按钮 点击时被调用
//- (void)searchBarSearchButtonClicked:(YYSearchBar *)searchBar {
//    NSLog(@"search button clicked");
//}
//
//// 当点击取消按钮时被调用
//- (void)searchBarCancelButtonClicked:(YYSearchBar *)searchBar {
//    NSLog(@"cancel button clicked");    
//}
@end
