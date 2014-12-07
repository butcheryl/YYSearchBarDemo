//
//  YYSearchController.h
//  YYSearchBar
//
//  Created by Butcher on 14/12/7.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYSearchBar.h"

@class YYSearchController;

@protocol YYSearchControllerDelegate <NSObject>
@optional
- (void)willPresentSearchController:(YYSearchController *)searchController;
- (void)didPresentSearchController:(YYSearchController *)searchController;
- (void)willDismissSearchController:(YYSearchController *)searchController;
- (void)didDismissSearchController:(YYSearchController *)searchController;

// 显示搜索视图前调用
-(void)presentSearchController:(YYSearchController *)searchController;
@end

@protocol YYSearchResultsUpdating <NSObject>
@required
// 当搜索框内容发生变化，或者获取焦点 方法被调用
- (void)updateSearchResultsForSearchController:(YYSearchController *)searchController;
@end


@interface YYSearchController : UIViewController
// 参数为nil时，在当前控制器中显示搜索结果视图
- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController;

// 负责显示更新内容的 searchResultsController 对象
@property (nonatomic, assign) id <YYSearchResultsUpdating> searchResultsUpdater;

// 设置个属性可以方便的让搜索结果视图 显示/消失。
// 如果想在搜索结果视图出现之前，想做些什么：实现 -presentSearchController:
@property (nonatomic, assign, getter = isActive) BOOL active;

// 代理
@property (nonatomic, assign) id <YYSearchControllerDelegate> delegate;

// 在文本框获取焦点时，是否遮挡背景
// default is YES
@property (nonatomic, assign) BOOL dimsBackgroundDuringPresentation;
// 在文本框获取焦点时，是否隐藏 NavigationBar
// default is YES
@property (nonatomic, assign) BOOL hidesNavigationBarDuringPresentation;

// 获取搜索结果控制器
@property (nonatomic, retain, readonly) UIViewController *searchResultsController;

// 你可以自由的改变 searchBar 的代理，负责监听 searchBar 的文本变化，和按钮点击事件
@property (nonatomic, retain, readonly) YYSearchBar *searchBar;

@end
