//
//  YYSearchController.m
//  YYSearchBar
//
//  Created by Butcher on 14/12/7.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import "YYSearchController.h"

typedef NS_ENUM(NSInteger, YYSearchControllerWorkingStatus) {
    YYSearchControllerWorkingStatusOriginal,     // 原始状态
    YYSearchControllerWorkingStatusWillBegin,    // 将要开始编辑状态
    YYSearchControllerWorkingStatusDidBegin,     // 已经开始编辑状态
    YYSearchControllerWorkingStatusEnd           // 结束编辑状态
};

@interface YYSearchController ()<YYSearchBarDelegate>

@property (nonatomic, retain) UIViewController *searchResultsController;
@property (nonatomic, retain) YYSearchBar *searchBar;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *resultsView;

@property (nonatomic, assign) CGRect overlapViewFrame;
@property (nonatomic, assign) CGRect searchBarOriginalFrame;

@property (nonatomic, assign) YYSearchControllerWorkingStatus workingStatus;
@end

@implementation YYSearchController

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController {
    if (self = [[[self class] alloc] init]) {
        self.workingStatus = YYSearchControllerWorkingStatusOriginal;
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
    CGFloat contentOffset_v;
    if ([[_searchBar superview] isKindOfClass:[UITableView class]]) {
        contentOffset_v = -[(UITableView *)[self.searchBar superview] contentOffset].y;
    }
    
    self.overlapViewFrame = CGRectMake(0,
                                       _searchBar.frame.origin.y +_searchBar.frame.size.height +contentOffset_v,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height -_searchBar.frame.origin.y -_searchBar.frame.size.height -contentOffset_v);
    
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

#define DelegateNaviVC [(UIViewController *)self.delegate navigationController]

#define NOT_NAVIBAR_FRAME CGRectMake(0, 20, _searchBar.frame.size.width, _searchBar.frame.size.height)
#define HAS_NAVIBAR_FRAME CGRectMake(0, 64, _searchBar.frame.size.width, _searchBar.frame.size.height);

#pragma mark - YYSearchBar/OverlapView Move Animation
- (void)viewMove2Top {
    self.searchBarOriginalFrame = self.searchBar.frame;
    [UIView animateWithDuration:.2f animations:^{
        // 有 navigationBar
        if (DelegateNaviVC) {
            // 隐藏 navigationBar
            if (self.hidesNavigationBarDuringPresentation) {
                [DelegateNaviVC setNavigationBarHidden:YES animated:YES];
                // scroll 自己会 滚动 searchBar 跟着动就行了
                // #warning -不完善处理
                if (![[_searchBar superview] isKindOfClass:[UIScrollView class]]) {
                    _searchBar.frame = NOT_NAVIBAR_FRAME;
                }
            } else { // 不隐藏 navigationBar
                _searchBar.frame = HAS_NAVIBAR_FRAME;
            }
        } else { // 没有 navigationBar
            _searchBar.frame = NOT_NAVIBAR_FRAME;
        }
        _backgroundView.frame = self.overlapViewFrame;
        _resultsView.frame = self.overlapViewFrame;
    } completion:^(BOOL finished) {}];
}
- (void)viewMove2Original {
    [UIView animateWithDuration:.2f animations:^{
        if (DelegateNaviVC) {
            [DelegateNaviVC setNavigationBarHidden:NO animated:YES];
        }
        _searchBar.frame = self.searchBarOriginalFrame;
        _backgroundView.frame = self.overlapViewFrame;
        _resultsView.frame = self.overlapViewFrame;
    } completion:^(BOOL finished) {}];
}


#define DelegateView [(UIViewController *)self.delegate view]
#pragma mark - YYSearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(YYSearchBar *)searchBar {

    if (self.workingStatus == YYSearchControllerWorkingStatusEnd) {
        if ([[DelegateView subviews] containsObject:_resultsView]) {
            [_resultsView removeFromSuperview];
        }
    } else {
        if (self.workingStatus == YYSearchControllerWorkingStatusOriginal) {
            [self viewMove2Top];
        }
        if (self.dimsBackgroundDuringPresentation) {
            [DelegateView addSubview:self.backgroundView];
        }
    }
    self.workingStatus = YYSearchControllerWorkingStatusWillBegin;
    return YES;
}

- (void)searchBar:(YYSearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    // 当文本框上没有文字时，状态改变为将要开始
    if (([searchText isEqualToString:@""] || !searchText || !searchText.length)) {
        self.workingStatus = YYSearchControllerWorkingStatusWillBegin;
        if ([self.delegate respondsToSelector:@selector(willDismissSearchController:)]) {
            [self.delegate willDismissSearchController:self];
        }
        
        [_resultsView removeFromSuperview];
        
        if ([self.delegate respondsToSelector:@selector(didDismissSearchController:)]) {
            [self.delegate didDismissSearchController:self];
        }
    } else {
        if (self.searchResultsController
            && self.workingStatus == YYSearchControllerWorkingStatusWillBegin) {
            self.workingStatus = YYSearchControllerWorkingStatusDidBegin;
            
            if ([self.delegate respondsToSelector:@selector(willPresentSearchController:)]) {
                [self.delegate willPresentSearchController:self];
            }
            
            [DelegateView addSubview:self.resultsView];
            
            if ([self.delegate respondsToSelector:@selector(didPresentSearchController:)]) {
                [self.delegate didPresentSearchController:self];
            }
        }
    }
    
    if ([self.searchResultsUpdater respondsToSelector:@selector(updateSearchResultsForSearchController:)]) {
        [self.searchResultsUpdater updateSearchResultsForSearchController:self];
    }
}
- (BOOL)searchBarShouldEndEditing:(YYSearchBar *)searchBar {
    self.workingStatus = YYSearchControllerWorkingStatusEnd;
    return YES;
}
- (void)searchBarSearchButtonClicked:(YYSearchBar *)searchBar {
    if ([self.searchResultsUpdater respondsToSelector:@selector(updateSearchResultsForSearchController:)]) {
        [self.searchResultsUpdater updateSearchResultsForSearchController:self];
    }
}
- (void)searchBarCancelButtonClicked:(YYSearchBar *)searchBar {
    if (self.workingStatus == YYSearchControllerWorkingStatusEnd) {
        self.workingStatus = YYSearchControllerWorkingStatusOriginal;
        self.searchBar.text = @"";
        
        [self viewMove2Original];
        
        [_backgroundView removeFromSuperview];
        
        if ([self.delegate respondsToSelector:@selector(willDismissSearchController:)]) {
            [self.delegate willDismissSearchController:self];
        }
        
        [_resultsView removeFromSuperview];
        
        if ([self.delegate respondsToSelector:@selector(didDismissSearchController:)]) {
            [self.delegate didDismissSearchController:self];
        }
    }
}
#pragma mark - Action
- (void)backgroundViewClicked: (UIView *)view {
    [self.searchBar endEditing:YES];
    
    [_backgroundView removeFromSuperview];
    [self viewMove2Original];
    self.workingStatus = YYSearchControllerWorkingStatusOriginal;
}

@end
