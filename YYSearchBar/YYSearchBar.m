//
//  YYSearchBar.m
//  YYSearchBar
//
//  Created by 于磊 on 14/12/5.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import "YYSearchBar.h"
#import "YYSearchField.h"

@interface YYSearchBar () <UITextFieldDelegate>
{
    UIView *_searchView;
    UIView *_rightButtonView;
}
@property (nonatomic, retain) YYSearchField *searchField;
@property (nonatomic, retain) UIButton *rightButton;
@property (nonatomic, retain) UIView *leftAccessoryView;
@property (nonatomic, assign) UIOffset offset;

@end

#pragma mark - init
@implementation YYSearchBar

#define kMultiple 4

#define kOffset_h _offset.horizontal
#define kOffset_v _offset.vertical

#define kOffsetDidWidth(width) width - 2*kOffset_h
#define kOffsetDidHeight(height) height - 2*kOffset_v

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat width = frame.size.width / (kMultiple + 1);
        CGFloat height = frame.size.height;
        
        self.offset = UIOffsetMake(8, 8);
        
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width *kMultiple, height)];
        [self addSubview:_searchView];
        
        self.searchField = [[YYSearchField alloc] initWithFrame:CGRectMake(kOffset_h, kOffset_v, kOffsetDidWidth(width *kMultiple), kOffsetDidHeight(height))];
        self.searchField.delegate = self;
        [_searchView addSubview:self.searchField];
        
        [self.searchField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        
        _rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(width *kMultiple, 0, width, height)];
        [self addSubview:_rightButtonView];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // 点击高亮
        self.rightButton.showsTouchWhenHighlighted = YES;

        self.rightButton.frame = _rightButtonView.bounds;
        self.rightButton.backgroundColor = [UIColor clearColor];
        [self.rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
        [_rightButtonView addSubview:_rightButton];
        
        // 要放到创建按钮之后执行
        self.rightButtonStyle = YYRightButtonStyleCancel;
        
        // 要放到搜索视图 和 右按钮视图后执行
        self.backGroundColor = [UIColor lightGrayColor];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    self = [self initWithFrame:frame];
    self.placeholder = placeholder;
    return self;
}
#pragma mark - 便利构造器
+ (YYSearchBar *)searchBarWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    return [[[self class] alloc] initWithFrame:frame placeholder:placeholder];
}
#pragma mark - getter/setter
- (void)setRightButtonStyle:(YYRightButtonStyle)rightButtonStyle {
    _rightButtonStyle = rightButtonStyle;
    
    if (rightButtonStyle == YYRightButtonStyleSearch) {
        [self.rightButton setTitle:@"搜索" forState:UIControlStateNormal];
    } else {
        [self.rightButton setTitle:@"取消" forState:UIControlStateNormal];
    }

}
- (void)setBackGroundColor:(UIColor *)backGroundColor {
    _backGroundColor = backGroundColor;
    
    _searchView.backgroundColor = backGroundColor;
    _rightButtonView.backgroundColor = backGroundColor;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    self.searchField.placeholder = placeholder;
}

- (void)setText:(NSString *)text {
    self.searchField.text = text;
}
- (NSString *)text {
    return _searchField.text;
}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // 改变searchField上 视图的位置 开始编辑时，在左边
    [self.searchField changeSearchFieldStyle:YYSearchFieldViewStyleLeft];

    // 改变右边按钮为搜索按钮
    self.rightButtonStyle = YYRightButtonStyleSearch;
    
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        return [self.delegate searchBarShouldBeginEditing:self];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.rightButtonStyle = YYRightButtonStyleCancel;
    
    // 当searchBar上没有文字时
    if ([textField.text isEqualToString:@""]) {
        // 改变searchField上 视图的位置 结束编辑时，在中间
        [self.searchField changeSearchFieldStyle:YYSearchFieldViewStyleCenter];
    }
    
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        return [self.delegate searchBarShouldEndEditing:self];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
        [self.delegate searchBarSearchButtonClicked:self];
    }
    return YES;
}
- (void)textFieldChanged:(YYSearchField *)searchField {
    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBar:self textDidChange:searchField.text];
    }
}
#pragma mark - rightButtonAction
- (void)rightButtonClicked:(UIButton *)button {
    
    switch (_rightButtonStyle) {
        case YYRightButtonStyleCancel:
            if ([self.delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]) {
                [self.delegate searchBarCancelButtonClicked:self];
            }
            break;
        case YYRightButtonStyleSearch:
            if ([self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
                [self.delegate searchBarSearchButtonClicked:self];
            }
        default:
            [self.searchField resignFirstResponder];
            break;
    }
}

#pragma mark - Override
// return 'best' size to fit given size. does not actually resize view. Default is return existing view size
//- (CGSize)sizeThatFits:(CGSize)size {
//    NSLog(@"1");
//    NSLog(@"%@", NSStringFromCGSize(size));
//    return [super sizeThatFits:CGSizeZero];
//}
//- (void)sizeToFit {
//    NSLog(@"%@", self.superview);
//    [super sizeToFit];
//    NSLog(@"2");
//}

@end
