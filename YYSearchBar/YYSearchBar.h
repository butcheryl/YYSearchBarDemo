//
//  YYSearchBar.h
//  YYSearchBar
//
//  Created by 于磊 on 14/12/5.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, YYRightButtonStyle) {
    YYRightButtonStyleSearch,
    YYRightButtonStyleCancel
};

@class YYSearchBar;

@protocol YYSearchBarDelegate <NSObject>

@optional
// return NO 时 搜索框不获得焦点
- (BOOL)searchBarShouldBeginEditing:(YYSearchBar *)searchBar;

// 当文本开始编辑时被调用
- (void)searchBarTextDidBeginEditing:(YYSearchBar *)searchBar;

// return NO 时 不回收键盘
- (BOOL)searchBarShouldEndEditing:(YYSearchBar *)searchBar;

// 当文本结束编辑时被调用
- (void)searchBarTextDidEndEditing:(YYSearchBar *)searchBar;

/*
 *   当文本改变时被调用（包括清除文本）
 *   @params searchText 改变后的文本
*/
- (void)searchBar:(YYSearchBar *)searchBar textDidChange:(NSString *)searchText;

// 当键盘上的 search/searchBar右侧的搜索按钮 点击时被调用
- (void)searchBarSearchButtonClicked:(YYSearchBar *)searchBar;

// 当点击取消按钮时被调用
- (void)searchBarCancelButtonClicked:(YYSearchBar *)searchBar;


@end

@interface YYSearchBar : UIView

@property (nonatomic, assign)id<YYSearchBarDelegate> delegate;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, retain) UIColor *backGroundColor;

@property (nonatomic, assign) YYRightButtonStyle rightButtonStyle;

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;
+ (YYSearchBar *)searchBarWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;
@end
