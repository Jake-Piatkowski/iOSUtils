//
//  GraphicsUtils.m
//  iOSUtils
//
//  Created by Jakub Piatkowski on 19/02/2015.
//  Copyright (c) 2015 jbpi. All rights reserved.
//

#import "GraphicsUtils.h"

@implementation GraphicsUtils

+ (CGRect)rectFromPoint1:(CGPoint)point1 point2:(CGPoint)point2 {
    
    return CGRectMake(MIN(point1.x, point2.x), MIN(point1.y, point2.y), fabs(point1.x - point2.x), fabs(point1.y - point2.y));
}

+ (UIImage *)imageWithView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
