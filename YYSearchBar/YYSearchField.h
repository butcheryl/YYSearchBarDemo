//
//  YYSearchField.h
//  YYSearchBar
//
//  Created by Butcher on 14/12/6.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYSearchFieldViewStyle) {
    YYSearchFieldViewStyleCenter, // default 
    YYSearchFieldViewStyleLeft
};



@interface YYSearchField : UITextField

@property (nonatomic, assign) YYSearchFieldViewStyle leftViewStyle;
@property (nonatomic, assign) YYSearchFieldViewStyle placeholderStyle;

- (void)changeSearchFieldStyle: (YYSearchFieldViewStyle)style;
@end
