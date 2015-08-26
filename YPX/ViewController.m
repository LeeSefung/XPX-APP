//
//  ViewController.m
//  YPX
//
//  Created by cnxpx on 15/8/24.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import "ViewController.h"
#import "LSNavigationBar.h"
#import "LSTabBar.h"
#import "LSKeyBoard.h"
#import "LSCallButton.h"
#import "DialViewController.h"
#import "AdressBookViewController.h"
#import "PersonCenterViewController.h"
#import "ShoppingCenterViewController.h"
#import "PhoneDirectory.h"
#import "AddPhoneNumberViewController.h"
#import "SendMessageViewController.h"

//屏幕高度
#define WindowHeight [UIScreen mainScreen].bounds.size.height
//屏幕宽度
#define WindowsWidth [UIScreen mainScreen].bounds.size.width


@interface ViewController () <LSNavigationBarDelegate>

//导航栏
@property (nonatomic, strong) LSNavigationBar *navigationBar;
//标签栏
@property (nonatomic, strong) LSTabBar *tabBar;
//键盘
@property (nonatomic, strong) LSKeyBoard *keyBoard;
//呼出电话按钮
@property (nonatomic, strong) LSCallButton *call;

//通话记录
@property (nonatomic, strong) UIView *adressBookView;
//电话簿
@property (nonatomic, strong) UIView *phoneDirectoryView;
//商城
@property (nonatomic, strong) UIView *shoppingCenterView;
//个人中心
@property (nonatomic, strong) UIView *personCenterView;

//记录当前tabBar的Index
@property (nonatomic, assign) NSUInteger currentTabBarIndex;
//记录当前呼叫电话按钮状态
@property (nonatomic, assign) BOOL callButtonHidden;
//记录当前电话号码
@property (nonatomic, copy) NSMutableString *cellPhoneNumber;

@end

@implementation ViewController

- (void)dealloc {
    
    // 3. 移除监听
    [self.tabBar removeObserver:self forKeyPath:@"currentSelectedIndex"];
    [self.tabBar removeObserver:self forKeyPath:@"returnKeyBoardSign"];
    //移除通知观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CallPhoneNumber" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CallPhoneNumberWithName" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SendMessageWithName" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航视图
    [self.view addSubview:self.navigationBar];
    //添加标签视图
    [self.view addSubview:self.tabBar];
    
    self.currentTabBarIndex = 10;
    self.callButtonHidden = YES;
    
    //添加打电话通知的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callPhoneNumber) name:@"CallPhoneNumber" object:nil];
    
    //添加打电话通知的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callPhoneNumberWithName:) name:@"CallPhoneNumberWithName" object:nil];
    
    //添加发送短信通知的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessageWithInfo:) name:@"SendMessageWithName" object:nil];
}

#pragma mark - getter

//导航栏
- (LSNavigationBar *)navigationBar {
    
    if (!_navigationBar) {
        
        _navigationBar = ({
            
            LSNavigationBar *nav = [[LSNavigationBar alloc] initWithFrame:CGRectMake(0, 0, WindowsWidth, 20+37*LSRATIO)];
            nav.delegate = self;
            nav.title = @"新品线";
            nav;
        });
    }
    return _navigationBar;
}

//标签栏
- (LSTabBar *)tabBar {
    
    if (WindowHeight <= 480) {//  <= iphone4s
        
        if (!_tabBar) {
            _tabBar = ({
                
                LSTabBar *tab = [[LSTabBar alloc] initWithFrame:CGRectMake(0, WindowHeight-44, WindowsWidth, 44)];
                // 1. 设置监听(注册监听)
                [tab addObserver:self forKeyPath:@"currentSelectedIndex" options:NSKeyValueObservingOptionNew context:nil];
                [tab addObserver:self forKeyPath:@"returnKeyBoardSign" options:NSKeyValueObservingOptionNew context:nil];
                tab;
            });
        }
        return _tabBar;
    }else {//  >= iphone5
        
        if (!_tabBar) {
            _tabBar = ({
                
                LSTabBar *tab = [[LSTabBar alloc] initWithFrame:CGRectMake(0, WindowHeight-44*RATIO, WindowsWidth, 44*RATIO)];
                // 1. 设置监听(注册监听)
                [tab addObserver:self forKeyPath:@"currentSelectedIndex" options:NSKeyValueObservingOptionNew context:nil];
                [tab addObserver:self forKeyPath:@"returnKeyBoardSign" options:NSKeyValueObservingOptionNew context:nil];
                tab;
            });
        }
        return _tabBar;
    }
}

//键盘320*202
- (LSKeyBoard *)keyBoard {
    
    if (WindowHeight <= 480) {
        
        if (!_keyBoard) {
            
            _keyBoard = ({
                
                LSKeyBoard *board = [[LSKeyBoard alloc] initWithFrame:CGRectMake(0, WindowHeight-44-201-0.5, 320, 202)];
                // 1. 设置监听(注册监听)
                [board addObserver:self forKeyPath:@"phoneNumber" options:NSKeyValueObservingOptionNew context:nil];
                board;
            });
        }
        return _keyBoard;
    }else {
        
        if (!_keyBoard) {
            
            _keyBoard = ({
                
                LSKeyBoard *board = [[LSKeyBoard alloc] initWithFrame:CGRectMake(0, WindowHeight-44*RATIO-201*RATIO-0.5*RATIO, 320*RATIO, 202*RATIO)];
                // 1. 设置监听(注册监听)
                [board addObserver:self forKeyPath:@"phoneNumber" options:NSKeyValueObservingOptionNew context:nil];
                board;
            });
        }
        return _keyBoard;
    }
}

//呼出电话按钮
- (LSCallButton *)call {
    
    if (WindowHeight <= 480) {
        
        if (!_call) {
            
            _call = ({
                
                LSCallButton *button = [[LSCallButton alloc] initWithFrame:CGRectMake(0, WindowHeight-44, WindowsWidth, 44)];
                button;
            });
        }
        return _call;
    }else {
        
        if (!_call) {
            
            _call = ({
                
                LSCallButton *button = [[LSCallButton alloc] initWithFrame:CGRectMake(0, WindowHeight-44*RATIO, WindowsWidth, 44*RATIO)];
                button;
            });
        }
        return _call;
    }
}

//电话簿
- (UIView *)phoneDirectoryView {
    
    if (!_phoneDirectoryView) {
        
        _phoneDirectoryView = ({

            PhoneDirectory *phoneDirectory = [[PhoneDirectory alloc] initWithFrame:CGRectMake(0, 20+37*LSRATIO, WindowsWidth, WindowHeight-44*LSRATIO-20-37*LSRATIO)];
            phoneDirectory;
        });
    }
    return _phoneDirectoryView;
}

//商城
- (UIView *)shoppingCenterView {
    
    if (!_shoppingCenterView) {
        
        _shoppingCenterView = ({
            
            ShoppingCenterViewController *shoppingCenter = [[ShoppingCenterViewController alloc] init];
            shoppingCenter.view.frame = [UIScreen mainScreen].bounds;
            shoppingCenter.view;
        });
    }
    return _shoppingCenterView;
}

//个人中心
- (UIView *)personCenterView {
    
    if (!_personCenterView) {
        
        _personCenterView = ({
            
            PersonCenterViewController *personCenter = [[PersonCenterViewController alloc] init];
            personCenter.view.frame = [UIScreen mainScreen].bounds;
            personCenter.view;
        });
    }
    return _personCenterView;
}

//通讯记录
- (UIView *)adressBookView {
    
    if (!_adressBookView) {
        
        _adressBookView = ({
            
            AdressBookViewController *adressBook = [[AdressBookViewController alloc] init];
            adressBook.view.frame = [UIScreen mainScreen].bounds;
            adressBook.view;
        });
    }
    return _adressBookView;
}

#pragma mark - 处理监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
//    NSLog(@"keypath : %@", keyPath);
//    NSLog(@"object : %@", object);
//    NSLog(@"change : %@", change);
    
    //判断是否为所监听的属性
    if ([keyPath isEqualToString:@"currentSelectedIndex"]) {//当前tabBar选中按钮
        
        // 2. 处理监听
        NSInteger index = [change[@"new"] integerValue];
        
        if (self.currentTabBarIndex == index && self.currentTabBarIndex != 0) {//如果点击同一按钮且不为第一个按钮，则返回不执行
            return;
        }else {
            self.currentTabBarIndex = index;
            NSLog(@"%ld",(long)index);
        }
        
        //处理tabBar点击事件
        [self tabBarClickWithIndex:self.currentTabBarIndex];
        
    }
    
    if ([keyPath isEqualToString:@"returnKeyBoardSign"]) {//返回键盘
        
        // 2. 处理监听:回收键盘
        [self returnKeyBoard];
    }
    
    if ([keyPath isEqualToString:@"phoneNumber"]) {//呼叫电话按钮状态
        
        // 2. 处理监听:出现呼叫电话按钮
        NSString  *phoneNumber = change[@"new"];
        self.cellPhoneNumber = [phoneNumber mutableCopy];
        if (phoneNumber.length == 0) {
            
            //移除呼叫电话按钮
            [self.call removeFromSuperview];
            self.call = nil;
            self.callButtonHidden = YES;
            return;
        }
        if (phoneNumber.length != 0 && self.callButtonHidden == YES) {
            
            //添加呼叫电话按钮
            [self.view addSubview:self.call];
            self.callButtonHidden = NO;
        }
    }
}

//处理tabBar的点击事件
- (void)tabBarClickWithIndex:(NSInteger)index {
    
    if (index == 0) {//键盘
        
        //添加键盘
        [self.view addSubview:self.keyBoard];
        self.navigationBar.title = @"新品线";
        [self removeOtherViewWithCurrentIndex:0];
        return;
    }
    if (index == 1) {//电话簿
        
        //添加电话簿
        [self.view insertSubview:self.phoneDirectoryView belowSubview:self.navigationBar ];
        self.navigationBar.title = @"电话簿";
        [self.navigationBar setRightItemWithTitle:@"+"];
        [self removeOtherViewWithCurrentIndex:1];
        return;
    }
    if (index == 2) {//商城
        
        //添加商城
        [self.view insertSubview:self.shoppingCenterView belowSubview:self.navigationBar];
        self.navigationBar.title = @"商城";
        [self removeOtherViewWithCurrentIndex:2];
        return;
    }
    if (index == 3) {//个人中心
        
        //添加个人中心
        [self.view insertSubview:self.personCenterView belowSubview:self.navigationBar];
        self.navigationBar.title = @"个人中心";
        [self removeOtherViewWithCurrentIndex:3];
        return;
    }
    
    //.....
}

//移除TabBar的其他视图层级
- (void)removeOtherViewWithCurrentIndex:(NSInteger)index {
    
    
    if (index != 0 && self.keyBoard != nil) {

        [self returnKeyBoard];
    }
    
    if (index != 1 && self.phoneDirectoryView != nil) {
        
        [self removePhoneDirectory];
    }
    
    if (index != 2 && self.shoppingCenterView != nil) {
        
        [self removeShoppingCenter];
    }
    
    if (index != 3 && self.personCenterView != nil) {
        
        [self removePersonCenter];
    }
}

//回收键盘
- (void)returnKeyBoard {
    
    //移除键盘
    [self.keyBoard removeFromSuperview];
    //移除监听
    [self.keyBoard removeObserver:self forKeyPath:@"phoneNumber"];
    self.keyBoard = nil;
}

//移除电话簿
- (void)removePhoneDirectory {
    
    //移除电话簿
    [self.navigationBar removeRightButton];
    [self.phoneDirectoryView removeFromSuperview];
    self.phoneDirectoryView = nil;
}

//移除商城
- (void)removeShoppingCenter {
    
    //移除商城
    [self.shoppingCenterView removeFromSuperview];
    self.shoppingCenterView = nil;
}

//移除个人中心
- (void)removePersonCenter {
    
    //移除个人中心
    [self.personCenterView removeFromSuperview];
    self.personCenterView = nil;
}

#pragma mark - 拨打电话

//打电话通知事件
- (void)callPhoneNumber {
    
    NSLog(@"%@",self.cellPhoneNumber);
    DialViewController *dial = ({
        
        DialViewController *vc = [[DialViewController alloc] initWithPhoneNumber:self.cellPhoneNumber];
        vc;
    });
    [self presentViewController:dial animated:YES completion:^{
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }];
}

- (void)callPhoneNumberWithName:(NSNotification *)notification {
    
    NSLog(@"%@",notification.userInfo);
    
    DialViewController *dial = ({
        
        DialViewController *vc = [[DialViewController alloc] initWithName:notification.userInfo[@"name"] phoneNumber:notification.userInfo[@"phoneNumber"]];
        vc;
    });
    [self presentViewController:dial animated:YES completion:^{
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }];
}

#pragma mark - 发送短信
- (void)sendMessageWithInfo:(NSNotification *)notification {
    
    SendMessageViewController *sms = ({
        
        SendMessageViewController *vc = [[SendMessageViewController alloc] initWithName:notification.userInfo[@"name"] phoneNumber:notification.userInfo[@"phoneNumber"]];
        vc;
    });
    [self presentViewController:sms animated:YES completion:nil];
}


#pragma mark - LSNavigationBarDelegate

- (void)rightItemClick {
    
    NSLog(@"呵呵，成功了");
    AddPhoneNumberViewController *addVC = ({
        
        AddPhoneNumberViewController *vc = [[AddPhoneNumberViewController alloc] init];
        vc;
    });
    [self presentViewController:addVC animated:YES completion:^{
        
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }];
}

@end
