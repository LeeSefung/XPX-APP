//
//  DialViewController.h
//  YPX
//
//  Created by cnxpx on 15/8/24.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DialViewController : UIViewController

@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber;

- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber;

@end
