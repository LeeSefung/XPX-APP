//
//  PhoneDirectoryTableViewCell.h
//  YPX
//
//  Created by cnxpx on 15/8/25.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneDirectoryTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameAndAdressLabel;//姓名和地址
@property (nonatomic, strong) UILabel *phoneNumberLabel;//电话号码

@property (nonatomic, copy) NSString *name;


@end
