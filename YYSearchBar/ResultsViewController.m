//
//  ResultsViewController.m
//  YYSearchBar
//
//  Created by Butcher on 14/12/7.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import "ResultsViewController.h"


@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    label.text = @"ResultsViewController";
    [self.view addSubview:label];
}
- (void)updateSearchResultsForSearchController:(YYSearchController *)searchController {
    NSLog(@"Input Content: %@", searchController.searchBar.text);
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
