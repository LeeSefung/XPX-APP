//
//  LSKeyBoard.m
//  YPX
//
//  Created by cnxpx on 15/8/24.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import "LSKeyBoard.h"

@interface LSKeyBoard ()

//电话号码
@property (nonatomic, strong) UILabel *phoneNumberLabel;
//键盘视图
@property (nonatomic, strong) UIView *keyBoardView;

@end

@implementation LSKeyBoard

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initWithInterface];
    }
    return self;
}

- (void)initWithInterface {
    
    [self addSubview:self.keyBoardView];
    [self addSubview:self.phoneNumberLabel];
    self.phoneNumberLabel.text = @"";//测试使用
}

#pragma mark - getter

//显示电话号码
- (UILabel *)phoneNumberLabel {
    
    if (WindowHeight <= 480) {
        
        if (!_phoneNumberLabel) {
            
            _phoneNumberLabel = ({
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.5, 0.5, WindowsWidth-1, 43.5)];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor grayColor];
                label.backgroundColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:32];
                label;
            });
        }
        return _phoneNumberLabel;
    }else {
        
        if (!_phoneNumberLabel) {
            
            _phoneNumberLabel = ({
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.5*RATIO, 0.5*RATIO, WindowsWidth-1*RATIO, 43.5*RATIO)];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor grayColor];
                label.backgroundColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:32*RATIO];
                label;
            });
        }
        return _phoneNumberLabel;
    }
}

//键盘视图
- (UIView *)keyBoardView {
    
    if (!_keyBoardView) {
        
        _keyBoardView = [[UIView alloc] initWithFrame:self.bounds];
        _keyBoardView.backgroundColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1];
        [self setButton];//创建按钮
    }
    return _keyBoardView;
}

//创建按钮
- (void)setButton {
    
    NSArray *array = @[@"1", @"2", @"3", @"del",@"4", @"5", @"6", @"0", @"7", @"8", @"9", @"add"];

    if (WindowHeight <= 480) {
        
        for (int i = 0; i < 12; i ++) {
            
            UIButton *numberButton = ({
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.5+(i%4)*WindowsWidth/4.0, 44.5+(i/4*315/6.0), (WindowsWidth-0.5)/4.0-0.5, 315/6.0-0.5)];
                button.backgroundColor = [UIColor whiteColor];
                button.tag = 200 + i;
                [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
                [button addTarget:self action:@selector(buttonPressPre:) forControlEvents:UIControlEventTouchUpInside];
                button;
            });
            [self.keyBoardView addSubview:numberButton];
        }
    }else {
        
        for (int i = 0; i < 12; i ++) {
            
            UIButton *numberButton = ({
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.5*RATIO+(i%4)*WindowsWidth/4.0, 44.5*RATIO+(i/4*315/6.0*RATIO), (WindowsWidth-0.5*RATIO)/4.0-0.5*RATIO, 315/6.0*RATIO-0.5*RATIO)];
                [button setTitle:array[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                button.backgroundColor = [UIColor whiteColor];
                button.tag = 200 + i;
                [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
                [button addTarget:self action:@selector(buttonPressPre:) forControlEvents:UIControlEventTouchUpInside];
                button;
            });
            [self.keyBoardView addSubview:numberButton];
        }
    }
}

#pragma mark - 按钮点击事件

- (void)buttonPressPre:(UIButton *)sender {
    
    sender.backgroundColor = [UIColor whiteColor];
}

- (void)buttonPress:(UIButton *)sender {
    
    sender.backgroundColor = [UIColor redColor];
    int sign = sender.tag - 200;
    if (sign == 0) {
        
        NSMutableString *tmpString = [self.phoneNumberLabel.text mutableCopy];
        [tmpString appendString:@"1"];
        self.phoneNumberLabel.text = tmpString;
        self.phoneNumber = self.phoneNumberLabel.text;
        return;
    }
    if (sign == 1) {
        
        NSMutableString *tmpString = [self.phoneNumberLabel.text mutableCopy];
        [tmpString appendString:@"2"];
        self.phoneNumberLabel.text = tmpString;
        self.phoneNumber = self.phoneNumberLabel.text;
        return;
    }
    if (sign == 2) {
        
        NSMutableString *tmpString = [self.phoneNumberLabel.text mutableCopy];
        [tmpString appendString:@"3"];
        self.phoneNumberLabel.text = tmpString;
        self.phoneNumber = self.phoneNumberLabel.text;
        return;
    }
    if (sign == 3) {//del
        
        NSMutableString *tmpString = [self.phoneNumberLabel.text mutableCopy];
        if (tmpString.length == 0) {
            return;
        }
        [tmpString deleteCharactersInRange:NSMakeRange(tmpString.length-1, 1)];
        self.phoneNumberLabel.text = tmpString;
        self.phoneNumber = self.phoneNumberLabel.text;
        return;
    }
    if (sign == 4) {
        
        NSMutableString *tmpString = [self.phoneNumberLabel.text mutableCopy];
        [tmpString appendString:@"4"];
        self.phoneNumberLabel.text = tmpString;
        self.phoneNumber = self.phoneNumberLabel.text;
        return;
    }if (sign == 5) {
        
        NSMutableString *tmpString = [self.phoneNumberLabel.text mutableCopy];
        [tmpString appendString:@"5"];
        self.phoneNumberLabel.text = tmpString;
        self.phoneNumber = self.phoneNumberLabel.text;
        return;
    }if (sign == 6) {
        
        NSMutableString *tmpString = [self.phoneNumberLabel.text mutableCopy];
        [tmpString appendString:@"6"];
        self.phoneNumberLabel.text = tmpString;
        self.phoneNumber = self.phoneNumberLabel.text;
        return;
    }if (sign == 7) {
        
        NSMutableString *tmpString = [self.phoneNumberLabel.text mutableCopy];
        [tmpString appendString:@"0"];
        self.phoneNumberLabel.text = tmpString;
        self.phoneNumber = self.phoneNumberLabel.text;
        return;
    }if (sign == 8) {
        
        NSMutableString *tmpString = [self.phoneNumberLabel.text mutableCopy];
        [tmpString appendString:@"7"];
        self.phoneNumberLabel.text = tmpString;
        self.phoneNumber = self.phoneNumberLabel.text;
        return;
    }if (sign == 9) {
        
        NSMutableString *tmpString = [self.phoneNumberLabel.text mutableCopy];
        [tmpString appendString:@"8"];
        self.phoneNumberLabel.text = tmpString;
        self.phoneNumber = self.phoneNumberLabel.text;
        return;
    }if (sign == 10) {
        
        NSMutableString *tmpString = [self.phoneNumberLabel.text mutableCopy];
        [tmpString appendString:@"9"];
        self.phoneNumberLabel.text = tmpString;
        self.phoneNumber = self.phoneNumberLabel.text;
        return;
    }if (sign == 11) {//添加到联系人
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"正在开发中！" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
