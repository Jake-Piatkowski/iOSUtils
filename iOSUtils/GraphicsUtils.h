//
//  GraphicsUtils.h
//  iOSUtils
//
//  Created by Jakub Piatkowski on 19/02/2015.
//  Copyright (c) 2015 jbpi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GraphicsUtils : NSObject

+ (CGRect)rectFromPoint1:(CGPoint)point1 point2:(CGPoint)point2;
+ (UIImage *)imageWithView:(UIView *)view;

@end
