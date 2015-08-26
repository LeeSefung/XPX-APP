//
//  LSTabBar.h
//  YPX
//
//  Created by cnxpx on 15/8/24.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSTabBar : UIView

//当前选中的区域
@property (nonatomic, assign) NSUInteger currentSelectedIndex;

//回收键盘
@property (nonatomic, assign) NSUInteger returnKeyBoardSign;

- (instancetype)initWithFrame:(CGRect)frame;

@end
