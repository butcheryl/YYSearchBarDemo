//
//  ViewController.m
//  YYSearchBar
//
//  Created by 于磊 on 14/12/5.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import "ViewController.h"
#import "YYSearchBar.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YYSearchBar *searchBar = [YYSearchBar searchBarWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 80) placeholder:@"aaa"];
    [self.view addSubview:searchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
