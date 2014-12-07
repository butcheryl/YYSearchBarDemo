//
//  YYSearchController.m
//  YYSearchBar
//
//  Created by Butcher on 14/12/7.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import "YYSearchController.h"

@interface YYSearchController ()<YYSearchBarDelegate>

@property (nonatomic, retain) UIViewController *searchResultsController;
@property (nonatomic, retain) YYSearchBar *searchBar;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *resultsView;

@property (nonatomic, assign) CGRect overlapViewFrame;
@property (nonatomic, assign) CGRect searchBarOriginalFrame;
@end

@implementation YYSearchController

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController {
    if (self = [[[self class] alloc] init]) {
        self.searchResultsController = searchResultsController;

        self.dimsBackgroundDuringPresentation = YES;
        self.hidesNavigationBarDuringPresentation = YES;
        
        self.searchBar = [YYSearchBar searchBarWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)placeholder:@"search"];
        self.searchBar.delegate = self;
    }
    return self;
}
#pragma mark - getter/setter
- (CGRect)overlapViewFrame {
    
    self.overlapViewFrame = CGRectMake(0,
                                       _searchBar.frame.origin.y +_searchBar.frame.size.height,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height -_searchBar.frame.origin.y);
    
    return _overlapViewFrame;
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor lightGrayColor];
        _backgroundView.alpha = 0.3;

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewClicked:)];
        [self.backgroundView addGestureRecognizer:tapGestureRecognizer];
    }
    _backgroundView.frame = self.overlapViewFrame;
    return _backgroundView;
}
- (UIView *)resultsView {
    if (!_resultsView) {
        _resultsView = _searchResultsController.view;
        _resultsView.backgroundColor = [UIColor whiteColor];
    }
    _resultsView.frame = self.overlapViewFrame;
    return _resultsView;
}
#pragma mark - YYSearchBar/OverlapView Move Animation
- (void)viewMove2Top {
    self.searchBarOriginalFrame = self.searchBar.frame;
    [UIView animateWithDuration:.1f animations:^{
        if ([(UIViewController *)self.delegate navigationController]
            && self.hidesNavigationBarDuringPresentation) {
            _searchBar.frame = CGRectMake(0, 64, _searchBar.frame.size.width, _searchBar.frame.size.height);
        } else {
            _searchBar.frame = CGRectMake(0, 20, _searchBar.frame.size.width, _searchBar.frame.size.height);
        }
        _backgroundView.frame = self.overlapViewFrame;
        _resultsView.frame = self.overlapViewFrame;
    } completion:^(BOOL finished) {}];
}
- (void)viewMove2Original {
    [UIView animateWithDuration:.1f animations:^{
        _searchBar.frame = _searchBarOriginalFrame;
        _backgroundView.frame = self.overlapViewFrame;
        _resultsView.frame = self.overlapViewFrame;
    } completion:^(BOOL finished) {}];
}


#define DelegateView [(UIViewController *)self.delegate view]
#pragma mark - YYSearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(YYSearchBar *)searchBar {
    if (self.dimsBackgroundDuringPresentation) {
        [DelegateView addSubview:self.backgroundView];
    }
    
    if (self.searchResultsController) {
        [DelegateView addSubview:self.resultsView];
    }
    
    [self viewMove2Top];
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(YYSearchBar *)searchBar {
    [self viewMove2Original];
    [_backgroundView removeFromSuperview];
    [_resultsView removeFromSuperview];
    return YES;
}

- (void)searchBar:(YYSearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([self.searchResultsUpdater respondsToSelector:@selector(updateSearchResultsForSearchController:)]) {
        [self.searchResultsUpdater updateSearchResultsForSearchController:self];
    }
}
#pragma mark - Action
- (void)backgroundViewClicked: (UIView *)view {
    [self.searchBar endEditing:YES];
}

@end
