//
//  SendMessageViewController.m
//  YPX
//
//  Created by cnxpx on 15/8/26.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import "SendMessageViewController.h"
#import "LSNavigationBar.h"

@interface SendMessageViewController ()

@property (nonatomic, strong) LSNavigationBar *navigationBar;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *message;

@end

@implementation SendMessageViewController

- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber {
    
    self = [super init];
    if (self) {
        
        self.name = name;
        self.phoneNumber = phoneNumber;
        NSLog(@"%@,%@", name, phoneNumber);
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.navigationBar];
}

#pragma mark - getter

- (LSNavigationBar *)navigationBar {
    
    if (!_navigationBar) {
        
        _navigationBar = ({
            
            LSNavigationBar *nav = [[LSNavigationBar alloc] initWithFrame:CGRectMake(0, 0, WindowsWidth, 20+37*LSRATIO)];
            nav.title = @"发送短信";
            nav;
        });
    }
    return _navigationBar;
}

- (UIButton *)cancelButton {
    
    if (!_cancelButton) {
        
        _cancelButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 188*LSRATIO, 35*LSRATIO)];
            button.center = CGPointMake(CGRectGetMidX(self.view.bounds), WindowHeight - 160*LSRATIO);
            [button setTitle:@"返回" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17*LSRATIO];
            button.backgroundColor = [UIColor redColor];
            button.layer.cornerRadius = 8.5*LSRATIO;
            [button addTarget:self action:@selector(cancelButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.masksToBounds = NO;
            button;
        });
    }
    return _cancelButton;
}

#pragma mark - 点击事件

//返回
- (void)cancelButtonPress:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
