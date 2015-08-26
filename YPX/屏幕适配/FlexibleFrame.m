//
//  FlexibleFrame.m
//  ScreenToFit
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 LeeSefung. All rights reserved.
//

#import "FlexibleFrame.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define IPHONE_SIZE CGSizeMake(320,568)

@implementation FlexibleFrame

+ (CGFloat)ratio {
    
    return SCREEN_SIZE.height/IPHONE_SIZE.height;
}

+ (CGRect)frameWithIPhone5Frame:(CGRect)iPhone5Frame {
    
    CGFloat x = iPhone5Frame.origin.x * [self ratio];
    CGFloat y = iPhone5Frame.origin.y * [self ratio];
    CGFloat width = iPhone5Frame.size.width * [self ratio];
    CGFloat height = iPhone5Frame.size.height * [self ratio];
    
    return CGRectMake(x, y, width, height);
}

+ (CGFloat)lsRatio {
    
    if ([UIScreen mainScreen].bounds.size.height <= 480) {//iphone 4s
        
        return 1;
    }else {//iphone 5,iphone 6
        
        return [self ratio];
    }
}

@end
