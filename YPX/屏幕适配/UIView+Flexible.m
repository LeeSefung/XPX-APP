//
//  UIView+Flexible.m
//  ScreenToFit
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 LeeSefung. All rights reserved.
//

#import "UIView+Flexible.h"
#import "FlexibleFrame.h"

@implementation UIView (Flexible)

- (instancetype)initWithiPhone5Frame:(CGRect)frame {
    
    self = [self initWithFrame:[FlexibleFrame frameWithIPhone5Frame:frame]];
    
    return self;
}

@end
