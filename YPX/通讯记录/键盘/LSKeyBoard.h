//
//  LSKeyBoard.h
//  YPX
//
//  Created by cnxpx on 15/8/24.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSKeyBoard : UIView

//电话号码
@property (nonatomic, copy) NSString *phoneNumber;

- (instancetype)initWithFrame:(CGRect)frame;

@end
