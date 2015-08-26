//
//  FlexibleFrame.h
//  ScreenToFit
//
//  Created by rimi on 15/6/26.
//  Copyright (c) 2015年 LeeSefung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlexibleFrame : NSObject

+ (CGFloat)ratio;
+ (CGRect)frameWithIPhone5Frame:(CGRect)iPhone5Frame;


//自定义RATIO
+ (CGFloat)lsRatio;

@end
