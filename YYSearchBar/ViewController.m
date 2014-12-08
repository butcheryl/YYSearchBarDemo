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

@interface ViewController () <YYSearchControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) YYSearchController *searchController;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, retain) NSArray *dataArray;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    YYSearchBar *searchBar = [YYSearchBar searchBarWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 44) placeholder:@"search"];
//    searchBar.delegate = self;
//    [self.view addSubview:searchBar];

    self.title = @"YYSearchController Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    
    ResultsViewController *resultsVC = [[ResultsViewController alloc] init];
    resultsVC.sourceData = self.dataArray;
    
    self.searchController = [[YYSearchController alloc] initWithSearchResultsController:resultsVC];
    self.searchController.searchResultsUpdater = resultsVC;
    
    self.searchController.searchBar.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 44);
    self.searchController.delegate = self;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
                                    
    self.definesPresentationContext = YES;
}
- (void)initData {
    self.dataArray = @[@"Here's", @"to", @"the", @"crazy", @"ones.", @"The", @"misfits.", @"The", @"rebels.", @"The", @"troublemakers.", @"The", @"round", @"pegs", @"in", @"the", @"square", @"holes.", @"The", @"ones", @"who", @"see", @"things", @"differently.", @"They're", @"not", @"fond", @"of", @"rules.", @"And", @"they", @"have", @"no", @"respect", @"for", @"the", @"status", @"quo.", @"You", @"can", @"quote", @"them,", @"disagree", @"with", @"them,", @"glorify", @"or", @"vilify", @"them.", @"About", @"the", @"only", @"thing", @"you", @"can't", @"do", @"is", @"ignore", @"them.", @"Because", @"they", @"change", @"things.", @"They", @"push", @"the", @"human", @"race", @"forward.", @"And", @"while", @"some", @"may", @"see", @"them", @"as", @"the", @"crazy", @"ones,", @"we", @"see", @"genius.", @"Because", @"the", @"people", @"who", @"are", @"crazy", @"enough", @"to", @"think", @"they", @"can", @"change", @"the", @"world,", @"are", @"the", @"ones", @"who", @"do."];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
