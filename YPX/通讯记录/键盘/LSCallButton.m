//
//  LSCallButton.m
//  YPX
//
//  Created by cnxpx on 15/8/24.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import "LSCallButton.h"

@implementation LSCallButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initWithInterface];
    }
    return self;
}

- (void)initWithInterface {
    
    UIButton *callButton = ({
        
        UIButton *button = [[UIButton alloc] initWithFrame:self.bounds];
        [button setTitle:@"呼出电话" forState:UIControlStateNormal];
        if (WindowHeight <= 480) {
            
            button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        }else {
            
            button.titleLabel.font = [UIFont boldSystemFontOfSize:20*RATIO];
        }
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:221/255.0 green:0 blue:16/255.0 alpha:1];
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:callButton];
}

- (void)buttonPress:(UIButton *)sender {
    
    //播出号码:发送通知给controller，由controller处理拨号事件
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CallPhoneNumber" object:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
