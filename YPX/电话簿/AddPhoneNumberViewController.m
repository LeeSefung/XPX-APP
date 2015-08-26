//
//  AddPhoneNumberViewController.m
//  YPX
//
//  Created by cnxpx on 15/8/25.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import "AddPhoneNumberViewController.h"
#import "LSNavigationBar.h"
#import <AddressBook/AddressBook.h>

@interface AddPhoneNumberViewController () <LSNavigationBarDelegate, UITextFieldDelegate>

@property (assign,nonatomic) ABAddressBookRef addressBook;//通讯录

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) LSNavigationBar *navigationBar;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) UITextField *firstNameTextField;

@property (nonatomic, strong) UITextField *lastNameTextField;

@property (nonatomic, strong) UITextField *phoneNumberTextField;

//添加边框
@property (nonatomic, strong) UIButton *firstNameRect;
@property (nonatomic, strong) UIButton *lastNameRect;
@property (nonatomic, strong) UIButton *phoneNumberRect;

@end

@implementation AddPhoneNumberViewController

//由于在整个视图控制器周期内addressBook都驻留在内存中，所有当控制器视图销毁时销毁该对象
-(void)dealloc{
    
    if (self.addressBook!=NULL) {
        CFRelease(self.addressBook);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestAddressBook];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.backgroundView];
    
    [self.view addSubview:self.navigationBar];
    [self.backgroundView addSubview:self.cancelButton];
    [self.backgroundView addSubview:self.saveButton];
    
    [self.backgroundView addSubview:self.firstNameRect];
    [self.backgroundView addSubview:self.firstNameTextField];
    [self.backgroundView addSubview:self.lastNameRect];
    [self.backgroundView addSubview:self.lastNameTextField];
    [self.backgroundView addSubview:self.phoneNumberRect];
    [self.backgroundView addSubview:self.phoneNumberTextField];
    
    //添加Label
    [self addLabel];
}

- (void)addLabel {
    
    NSArray *array = @[@"名字:", @"姓:", @"号码:"];
    for (int i = 0; i < 3; i ++) {
        
        UILabel *titleLabel = ({
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80*LSRATIO, 35*LSRATIO)];
            if (WindowHeight <= 480) {
                
                label.center = CGPointMake(50*LSRATIO, 120*LSRATIO+i*60*LSRATIO);
            }else {
                
                label.center = CGPointMake(50*LSRATIO, 135*LSRATIO+i*90*LSRATIO);
            }
            label.textAlignment = NSTextAlignmentRight;
            label.font = [UIFont systemFontOfSize:16*LSRATIO];
            
            label.text = array[i];
            label;
        });
        [self.backgroundView addSubview:titleLabel];
    }
}

#pragma mark - getter

- (UIView *)backgroundView {
    
    if (!_backgroundView) {
        
        _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _backgroundView;
}

- (LSNavigationBar *)navigationBar {
    
    if (!_navigationBar) {
        
        _navigationBar = [[LSNavigationBar alloc] initWithFrame:CGRectMake(0, 0, WindowsWidth, 20+37*LSRATIO)];
        _navigationBar.delegate = self;
        [_navigationBar setLeftItemWithTitle:@"<"];
        _navigationBar.title = @"添加联系人";
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

- (UIButton *)saveButton {
    
    if (!_saveButton) {
        
        _saveButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 188*LSRATIO, 35*LSRATIO)];
            button.center = CGPointMake(CGRectGetMidX(self.view.bounds), WindowHeight - 100*LSRATIO);
            [button setTitle:@"保存" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17*LSRATIO];
            button.backgroundColor = [UIColor redColor];
            button.layer.cornerRadius = 8.5*LSRATIO;
            [button addTarget:self action:@selector(saveButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.masksToBounds = NO;
            button;
        });
    }
    return _saveButton;
}

- (UIButton *)firstNameRect {
    
    if (!_firstNameRect) {
        
        _firstNameRect = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 188*LSRATIO, 35*LSRATIO)];
            if (WindowHeight <= 480) {
                
                button.center = CGPointMake(120+75*LSRATIO, 120*LSRATIO);
            }else {
                button.center = CGPointMake(120+75*LSRATIO, 135*LSRATIO);
            }
            button.layer.borderWidth = 0.5*LSRATIO;
            button.layer.borderColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1].CGColor;
            button.layer.cornerRadius = 17.5*LSRATIO;
            button.layer.masksToBounds = NO;
            button.userInteractionEnabled = NO;
            button;
        });
    }
    return _firstNameRect;
}

- (UITextField *)firstNameTextField {
    
    if (!_firstNameTextField) {
        
        _firstNameTextField = ({
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 188*LSRATIO-35*LSRATIO, 35*LSRATIO)];
            if (WindowHeight <= 480) {
                
                textField.center = CGPointMake(120+75*LSRATIO, 120*LSRATIO);
            }else {
                textField.center = CGPointMake(120+75*LSRATIO, 135*LSRATIO);
            }
            textField.tag = 400;
            textField.delegate = self;
            textField.returnKeyType = UIReturnKeyDone;
            textField;
        });
    }
    return _firstNameTextField;
}

- (UIButton *)lastNameRect {
    
    if (!_lastNameRect) {
        
        _lastNameRect = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 188*LSRATIO, 35*LSRATIO)];
            if (WindowHeight <= 480) {
                
                button.center = CGPointMake(120+75*LSRATIO, 120*LSRATIO+60*LSRATIO);
            }else {
                
                button.center = CGPointMake(120+75*LSRATIO, 135*LSRATIO+90*LSRATIO);
            }
            button.layer.borderWidth = 0.5*LSRATIO;
            button.layer.borderColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1].CGColor;
            button.layer.cornerRadius = 17.5*LSRATIO;
            button.layer.masksToBounds = NO;
            button.userInteractionEnabled = NO;
            button;
        });
    }
    return _lastNameRect;
}

- (UITextField *)lastNameTextField {
    
    if (!_lastNameTextField) {
        
        _lastNameTextField = ({
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 188*LSRATIO-35*LSRATIO, 35*LSRATIO)];
            if (WindowHeight <= 480) {
                
                textField.center = CGPointMake(120+75*LSRATIO, 120*LSRATIO+60*LSRATIO);
            }else {
                
                textField.center = CGPointMake(120+75*LSRATIO, 135*LSRATIO+90*LSRATIO);
            }
            textField.tag = 401;
            textField.delegate = self;
            textField.returnKeyType = UIReturnKeyDone;
            textField;
        });
    }
    return _lastNameTextField;
}

- (UIButton *)phoneNumberRect {
    
    if (!_phoneNumberRect) {
        
        _phoneNumberRect = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 188*LSRATIO, 35*LSRATIO)];
            if (WindowHeight <= 480) {
                
                button.center = CGPointMake(120+75*LSRATIO, 120*LSRATIO+120*LSRATIO);
            }else {
                
                button.center = CGPointMake(120+75*LSRATIO, 135*LSRATIO+180*LSRATIO);
            }
            button.layer.borderWidth = 0.5*LSRATIO;
            button.layer.borderColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1].CGColor;
            button.layer.cornerRadius = 17.5*LSRATIO;
            button.layer.masksToBounds = NO;
            button.userInteractionEnabled = NO;
            button;
        });
    }
    return _phoneNumberRect;
}

- (UITextField *)phoneNumberTextField {
    
    if (!_phoneNumberTextField) {
        
        _phoneNumberTextField = ({
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 188*LSRATIO-35*LSRATIO, 35*LSRATIO)];
            if (WindowHeight <= 480) {
                
                textField.center = CGPointMake(120+75*LSRATIO, 120*LSRATIO+120*LSRATIO);
            }else {
                
                textField.center = CGPointMake(120+75*LSRATIO, 135*LSRATIO+180*LSRATIO);
            }
            textField.tag = 402;
            textField.delegate = self;
            textField.returnKeyType = UIReturnKeyDone;
            textField;
        });
    }
    return _phoneNumberTextField;
}

#pragma mark - 点击事件

//返回
- (void)cancelButtonPress:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//保存
- (void)saveButtonPress:(UIButton *)sender {
    
    //保存用户信息
    //回收键盘
    [self.view endEditing:YES];
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
    
    //添加电话号码
    [self addPersonWithFirstName:self.firstNameTextField.text lastName:self.lastNameTextField.text workNumber:self.phoneNumberTextField.text];
    
    //发送通知更新电话簿
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdatePhoneDirectory" object:self userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 协议LSNavigationBarDelegate

- (void)leftItemClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextFieldDelegate

//回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    self.backgroundView.center = self.view.center;
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

//点击textField的时候触发
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 402) {//如果为电话号码
        
        //移动视图防止被键盘遮盖
        self.backgroundView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) - 150*LSRATIO);
    }
}

//点击textField外面的时候触发
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 402) {
        
        //恢复textField的位置
        self.backgroundView.center = self.view.center;
    }
}

#pragma mark - 初始化：ABAddressBook
/**
 *  初始化：ABAddressBook
 */
-(void)requestAddressBook{
    
    //创建通讯录对象
    self.addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
}

#warning 保存电话号码
#pragma mark - 保存电话号码

/**
 *  添加一条记录
 *
 *  @param firstName  名
 *  @param lastName   姓
 *  @param iPhoneName iPhone手机号
 */
-(void)addPersonWithFirstName:(NSString *)firstName lastName:(NSString *)lastName workNumber:(NSString *)workNumber{
    
    //创建一条记录
    ABRecordRef recordRef= ABPersonCreate();
    ABRecordSetValue(recordRef, kABPersonFirstNameProperty, (__bridge CFTypeRef)(firstName), NULL);//添加名
    ABRecordSetValue(recordRef, kABPersonLastNameProperty, (__bridge CFTypeRef)(lastName), NULL);//添加姓
    
    ABMutableMultiValueRef multiValueRef =ABMultiValueCreateMutable(kABStringPropertyType);//添加设置多值属性
    ABMultiValueAddValueAndLabel(multiValueRef, (__bridge CFStringRef)(workNumber), kABWorkLabel, NULL);//添加工作电话
    ABRecordSetValue(recordRef, kABPersonPhoneProperty, multiValueRef, NULL);
    
    //添加记录
    ABAddressBookAddRecord(self.addressBook, recordRef, NULL);
    
    //保存通讯录，提交更改
    ABAddressBookSave(self.addressBook, NULL);
    //释放资源
    CFRelease(recordRef);
    CFRelease(multiValueRef);
}


@end
