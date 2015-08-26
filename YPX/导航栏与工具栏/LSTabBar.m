//
//  LSTabBar.m
//  YPX
//
//  Created by cnxpx on 15/8/24.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import "LSTabBar.h"
//屏幕高度
#define WindowHeight [UIScreen mainScreen].bounds.size.height
//屏幕宽度
#define WindowsWidth [UIScreen mainScreen].bounds.size.width

@interface LSTabBar ()

@property (nonatomic, strong) UIView *tabBarView;

@end

@implementation LSTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initWithInterface];
    }
    return self;
}

//创建视图
- (void)initWithInterface{
    
    if (WindowHeight <= 480) {//iphone4
        
        self.tabBarView = ({//others
            
            UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowsWidth, 44)];
            tabView.backgroundColor = [UIColor whiteColor];
            tabView;
        });
        [self addSubview:self.tabBarView];
    }else {
        
        self.tabBarView = ({//others
            
            UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowsWidth, 44*RATIO)];
            tabView.backgroundColor = [UIColor whiteColor];
            tabView;
        });
        [self addSubview:self.tabBarView];
    }
    
    
    //添加按钮点击事件
    [self setButton];
}

//添加按钮
- (void)setButton {
    
    for (int i = 0; i < 4; i ++) {
        
        if (WindowHeight <= 480) {
            
            UIView *tabView = ({
                
                UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0+i*WindowsWidth/4.0, 0, WindowsWidth/4.0-0.5, 44)];
                tabView;
            });
            [self.tabBarView addSubview:tabView];
            
            
            UIButton *tabButton = ({
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WindowsWidth/4.0-0.5, 44)];
                button.tag = 100+i;
                button.backgroundColor = [UIColor colorWithRed:232.0/255 green:233.0/255 blue:232.0/255 alpha:1];;
                button.selected = NO;
                [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
                button;
            });
            [tabView addSubview:tabButton];
        }else {
            
            UIView *tabView = ({
                
                UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0+i*WindowsWidth/4.0, 0, WindowsWidth/4.0-0.5, 44*RATIO)];
                tabView;
            });
            [self.tabBarView addSubview:tabView];
            
            
            UIButton *tabButton = ({
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WindowsWidth/4.0-0.5, 44*RATIO)];
                button.tag = 100+i;
                button.backgroundColor = [UIColor colorWithRed:232.0/255 green:233.0/255 blue:232.0/255 alpha:1];;
                button.selected = NO;
                [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
                button;
            });
            [tabView addSubview:tabButton];
        }
    }
    self.currentSelectedIndex = 0;
}

//点击事件
- (void)buttonPress:(UIButton *)sender {
    
    NSLog(@"%ld",(long)sender.tag-100);
    //判断是否是第一个,回收键盘
    if (sender.tag == 100 && self.currentSelectedIndex+100 == 100 &&sender.selected == YES) {
        sender.backgroundColor = [UIColor colorWithRed:232.0/255 green:233.0/255 blue:232.0/255 alpha:1];;
        static int i = 0;
        self.returnKeyBoardSign = i++;//只要回收键盘值改变就立刻执行回收键盘程序
        sender.selected = NO;
        return;
    }
    UIButton *button = (UIButton *)[self viewWithTag:self.currentSelectedIndex+100];
    button.backgroundColor = [UIColor colorWithRed:232.0/255 green:233.0/255 blue:232.0/255 alpha:1];;
    //告诉外界我当前选中的按钮
    button.selected = NO;
    self.currentSelectedIndex = sender.tag - 100;
    sender.selected = YES;
    sender.backgroundColor = [UIColor redColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
