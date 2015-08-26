//
//  DialViewController.m
//  YPX
//
//  Created by cnxpx on 15/8/24.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import "DialViewController.h"

@interface DialViewController ()

//头像
@property (nonatomic, strong) UIImageView *imageView;
//姓名Label
@property (nonatomic, strong) UILabel *nameLabel;
//呼叫电话号码Label
@property (nonatomic, strong) UILabel *phoneLabel;
//挂机按钮
@property (nonatomic, strong) UIButton *dialUpButton;

@end

@implementation DialViewController

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber {
    
    self = [super init];
    if (self) {
        
        self.phoneNumber = phoneNumber;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber {
    
    self = [super init];
    if (self) {
        
        self.phoneNumber = phoneNumber;
        self.name = name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeInterface];
}

- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor colorWithRed:10/255.0 green:31/255.0 blue:103/255.0 alpha:1];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.dialUpButton];
}

#pragma mark - getter

- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        _imageView = ({
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 95*RATIO, 95*RATIO)];
            imgView.center = CGPointMake(CGRectGetMidX(self.view.bounds), 147.5*RATIO);
            imgView.backgroundColor = [UIColor grayColor];
            imgView.layer.cornerRadius = 47.5*RATIO;
            imgView.layer.masksToBounds = NO;
            imgView;
        });
    }
    return _imageView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = ({
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, WindowHeight/2.0-50*RATIO, WindowsWidth, 20*RATIO)];
            if (self.name == nil) {
                
                label.text = @"未知用户";
            }else {
                
                label.text = self.name;
            }
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:17*RATIO];
            label;
        });
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    
    if (!_phoneLabel) {
        
        _phoneLabel = ({
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, WindowHeight/2.0-50*RATIO, WindowsWidth, 20*RATIO)];
            label.center = self.view.center;
            label.text = [NSString stringWithFormat:@"正在呼叫%@",self.phoneNumber];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:17*RATIO];
            label;
        });
    }
    return _phoneLabel;
}

- (UIButton *)dialUpButton {
    
    if (!_dialUpButton) {
        
        _dialUpButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 188*RATIO, 36*RATIO)];
            button.center = CGPointMake(CGRectGetMidX(self.view.bounds), WindowHeight - 80 * RATIO);
            button.backgroundColor = [UIColor colorWithRed:219/255.0 green:0 blue:17/255.0 alpha:1];
            [button setTitle:@"挂断呼叫" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:17*RATIO];
            button.layer.cornerRadius = 9*RATIO;
            button.layer.masksToBounds = NO;
            [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _dialUpButton;
}

#pragma mark - 挂断呼叫

- (void)dismiss {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
