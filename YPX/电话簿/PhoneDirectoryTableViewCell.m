//
//  PhoneDirectoryTableViewCell.m
//  YPX
//
//  Created by cnxpx on 15/8/25.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import "PhoneDirectoryTableViewCell.h"

@interface PhoneDirectoryTableViewCell ()

@property (nonatomic, strong) UIButton *dialButton;
@property (nonatomic, strong) UIButton *sendMessageButton;
@property (nonatomic, strong) UIButton *vidioCallButton;

@end


@implementation PhoneDirectoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithCell];
    }
    return self;
}

- (void)initWithCell {
    
    //添加姓名地址和电话号码
    [self.contentView addSubview:self.nameAndAdressLabel];
    [self.contentView addSubview:self.phoneNumberLabel];
    [self initWithInterface];
    [self.contentView addSubview:self.dialButton];
    [self.contentView addSubview:self.vidioCallButton];
    [self.contentView addSubview:self.sendMessageButton];
}

#pragma mark - getter

- (UILabel *)nameAndAdressLabel {
    
    if (!_nameAndAdressLabel) {
        
        _nameAndAdressLabel = ({
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12*LSRATIO, 10*LSRATIO, 180*LSRATIO, 15*LSRATIO)];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:14*LSRATIO];
            label.textAlignment = NSTextAlignmentLeft;
            label;
        });
    }
    return _nameAndAdressLabel;
}

- (UILabel *)phoneNumberLabel {
    
    if (!_phoneNumberLabel) {
        
        _phoneNumberLabel = ({
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12*LSRATIO, 25*LSRATIO, 180*LSRATIO, 15*LSRATIO)];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:14*LSRATIO];
            label.textAlignment = NSTextAlignmentLeft;
            label;
        });
    }
    return _phoneNumberLabel;
}

- (UIButton *)dialButton {
    
    if (!_dialButton) {
        
        _dialButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(WindowsWidth-120*LSRATIO+1*LSRATIO, 2*LSRATIO, 40*LSRATIO, 46*LSRATIO)];
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1].CGColor;
            [button addTarget:self action:@selector(dialButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _dialButton;
}

- (UIButton *)sendMessageButton {
    
    if (!_sendMessageButton) {
        
        _sendMessageButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(WindowsWidth-80*LSRATIO+0.5*LSRATIO, 2*LSRATIO, 40*LSRATIO, 46*LSRATIO)];
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1].CGColor;
            [button addTarget:self action:@selector(sendMessageButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _sendMessageButton;
}

- (UIButton *)vidioCallButton {
    
    if (!_vidioCallButton) {
        
        _vidioCallButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(WindowsWidth-40*LSRATIO, 2*LSRATIO, 40*LSRATIO, 46*LSRATIO)];
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1].CGColor;
            [button addTarget:self action:@selector(vidioCallButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _vidioCallButton;
}

#pragma mark - 给界面添加边框

- (void)initWithInterface {
    
    UIButton *rectH = ({
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(-1, 2*LSRATIO, WindowsWidth+2, 46*LSRATIO)];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1].CGColor;
        button.userInteractionEnabled = NO;
        button;
    });
    [self.contentView addSubview:rectH];
}

- (void)dialButtonPress:(UIButton *)sender {
    
    //拨打电话
    NSLog(@"拨打电话");
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.name forKey:@"name"];
    [dic setObject:self.phoneNumberLabel.text forKey:@"phoneNumber"];
    
    //播出号码:发送通知给controller，由controller处理拨号事件
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CallPhoneNumberWithName" object:self userInfo:dic];
}

- (void)sendMessageButtonPress:(UIButton *)sender {
    
    //发送短信
    NSLog(@"发送短信");
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.name forKey:@"name"];
    [dic setObject:self.phoneNumberLabel.text forKey:@"phoneNumber"];
    //播出号码:发送通知给controller，由controller处理拨号事件
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SendMessageWithName" object:self userInfo:dic];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送短信正在开发中！" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
//    [alert show];
}

- (void)vidioCallButtonPress:(UIButton *)sender {
    
    //视频通话
    NSLog(@"视频通话");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"视频通话正在开发中！" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
    [alert show];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
