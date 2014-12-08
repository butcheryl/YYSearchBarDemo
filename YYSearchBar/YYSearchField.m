//
//  YYSearchField.m
//  YYSearchBar
//
//  Created by Butcher on 14/12/6.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import "YYSearchField.h"

@interface YYSearchField ()

@end

@implementation YYSearchField

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
        self.spellCheckingType = UITextSpellCheckingTypeNo;
        self.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_MagnifyingGlass_gray"]];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing | UITextFieldViewModeUnlessEditing;
        self.borderStyle = UITextBorderStyleRoundedRect;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self changeSearchFieldStyle:YYSearchFieldViewStyleCenter];
    }
    return self;
}
- (void)changeSearchFieldStyle: (YYSearchFieldViewStyle)style {
    self.leftViewStyle = style;
    self.placeholderStyle = style;
}
static CGFloat offset = 7;
// 未实现功能，通过placeholder长度改变placeholder位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    
    CGRect rect = CGRectMake(0, 0, bounds.size.height -2 *offset, bounds.size.height -2 *offset);
    switch (_leftViewStyle) {
        case YYSearchFieldViewStyleLeft:
            rect.origin = CGPointMake(offset, offset);
            break;
        case YYSearchFieldViewStyleCenter:
            rect.origin = CGPointMake(100, offset);
            break;
        default:
            break;
    }
    return rect;
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect rect;
    switch (_placeholderStyle) {
        case YYSearchFieldViewStyleLeft:
            rect = CGRectMake(bounds.size.height, 2, bounds.size.width -bounds.size.height, bounds.size.height);
            break;
        case YYSearchFieldViewStyleCenter:
            rect = CGRectMake(100 +bounds.size.height -10, 0, bounds.size.width -100, bounds.size.height);
            break;
        default:
            break;
    }
    return rect;
}

@end
