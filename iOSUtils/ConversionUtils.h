//
//  ConversionUtils.h
//  iOSUtils
//
//  Created by Jakub Piatkowski on 19/02/2015.
//  Copyright (c) 2015 jbpi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ConversionUtils : NSObject

+ (NSString *)getHumanReadableByteCountBinary:(long long)bytes;
+ (UIColor *)getColourFromHexString:(NSString *)hexString;
+ (NSAttributedString *)getAttributedStringFromHtmlString:(NSString *)htmlString;

@end
