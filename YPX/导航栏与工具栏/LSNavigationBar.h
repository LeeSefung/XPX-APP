//
//  LSNavigationBar.h
//  YPX
//
//  Created by cnxpx on 15/8/24.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  LSNavigationBarDelegate <NSObject>

@optional

- (void)rightItemClick;

- (void)leftItemClick;

@end

@interface LSNavigationBar : UIView

@property (nonatomic, retain) id<LSNavigationBarDelegate> delegate;

@property (nonatomic,copy) NSString *title;

- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)init;

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame;

//添加右侧按钮
- (void)setRightItemWithTitle:(NSString *)title;
//添加右侧图片背景按钮
- (void)setRightItemWithImageName:(NSString *)imageName;

- (void)removeRightButton;

//添加左侧按钮
- (void)setLeftItemWithTitle:(NSString *)title;
//添加左侧图片背景按钮
- (void)setLeftItemWithImageName:(NSString *)imageName;

- (void)removeLeftButton;
@end
