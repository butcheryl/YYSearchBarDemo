//
//  YYSearchBar.m
//  YYSearchBar
//
//  Created by 于磊 on 14/12/5.
//  Copyright (c) 2014年 Butcher_. All rights reserved.
//

#import "YYSearchBar.h"

@interface YYSearchBar ()

@property (nonatomic, retain) UITextField *searchField;
@property (nonatomic, retain) UIButton *rightButton;
@property (nonatomic, retain) UIView *leftAccessoryView;
@property (nonatomic, assign) UIOffset adjustment;

@end

#pragma mark - init
@implementation YYSearchBar

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        
        self.adjustment = UIOffsetMake(10, 5);
        self.searchField = [[UITextField alloc] initWithFrame:CGRectMake(_adjustment.horizontal, _adjustment.vertical, frame.size.width - 2 *_adjustment.horizontal, frame.size.height - 2 * _adjustment.vertical)];
        self.searchField.backgroundColor = [UIColor redColor];
        [self addSubview:_searchField];
        
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    if (self = [self initWithFrame:frame]) {
        self.placeholder = placeholder;
    }
    return self;
}
#pragma mark - 便利构造器
+ (YYSearchBar *)searchBarWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    return [[[self class] alloc] initWithFrame:frame placeholder:placeholder];
}
- (void)initialize {
    
}
@end
