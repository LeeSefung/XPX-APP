//
//  LSNavigationBar.m
//  YPX
//
//  Created by cnxpx on 15/8/24.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import "LSNavigationBar.h"
//屏幕宽度
#define WindowsWidth [UIScreen mainScreen].bounds.size.width

@interface LSNavigationBar ()

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation LSNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initWithInterfaceWithTitle:@""];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    
    self = [super init];
    if (self) {
        
        [self initWithInterfaceWithTitle:title];
    }
    return self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self initWithInterfaceWithTitle:@""];
    }
    return self;
}

//添加右侧按钮
- (void)setRightItemWithTitle:(NSString *)title {
    
    if (!_rightButton) {
        
        _rightButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(WindowsWidth-28*LSRATIO, 20+7*LSRATIO, 21*LSRATIO, 21*LSRATIO)];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:24*LSRATIO];
            [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    [self addSubview:_rightButton];
}

//添加右侧图片背景按钮
- (void)setRightItemWithImageName:(NSString *)imageName {
    
    if (!_rightButton) {
        
        _rightButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(WindowsWidth-28*LSRATIO, 20+7*LSRATIO, 21*LSRATIO, 21*LSRATIO)];
            [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            button;
        });
    }
    [self addSubview:_rightButton];
}

//移除按钮
- (void)removeRightButton {
    
    [self.rightButton removeFromSuperview];
}

//添加左侧按钮
- (void)setLeftItemWithTitle:(NSString *)title {
    
    if (!_leftButton) {
        
        _leftButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(7*LSRATIO, 20+7*LSRATIO, 21*LSRATIO, 21*LSRATIO)];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:24*LSRATIO];
            [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    [self addSubview:_leftButton];
}
//添加左侧图片背景按钮
- (void)setLeftItemWithImageName:(NSString *)imageName {
    
    if (!_leftButton) {
        
        _leftButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(7*LSRATIO, 20+7*LSRATIO, 21*LSRATIO, 21*LSRATIO)];
            [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            button;
        });
    }
    [self addSubview:_leftButton];
}

- (void)removeLeftButton {
    
    [self.leftButton removeFromSuperview];
}

#warning 导航栏高度为37+20？！44+20
- (void)initWithInterfaceWithTitle:(NSString *)navigationTitle {
    
    if (WindowHeight <= 480) {
        
        //设置导航视图
        UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowsWidth, 20+37)];
        navigationView.backgroundColor = [UIColor colorWithRed:232.0/255 green:233.0/255 blue:232.0/255 alpha:1];
        [self addSubview:navigationView];
        
        //设置标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, WindowsWidth, 37)];
        self.titleLabel.text = navigationTitle;
        self.titleLabel.textColor = [UIColor redColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [navigationView addSubview:self.titleLabel];
    }else {
        
        //设置导航视图
        UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowsWidth, 20+37*RATIO)];
        navigationView.backgroundColor = [UIColor colorWithRed:232.0/255 green:233.0/255 blue:232.0/255 alpha:1];
        [self addSubview:navigationView];
        
        //设置标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, WindowsWidth, 37*RATIO)];
        self.titleLabel.text = navigationTitle;
        self.titleLabel.textColor = [UIColor redColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16*RATIO];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [navigationView addSubview:self.titleLabel];
    }
}

#pragma mark - setter
//修改标题
- (void)setTitle:(NSString *)title {
    
    self.titleLabel.text = title;
}


#pragma mark - 右侧按钮点击事件

- (void)buttonPress:(UIButton *)sender {
    
#pragma mark - 协议LSNavigationBarDelegate
    
    if (_delegate && [_delegate respondsToSelector:@selector(rightItemClick)]) {
        
        [self.delegate rightItemClick];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(leftItemClick)]) {
        
        [self.delegate leftItemClick];
    }
}

- (void)rightItemClick {
    
}

- (void)leftItemClick {
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
