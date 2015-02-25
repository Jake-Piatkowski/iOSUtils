//
//  ConversionUtils.m
//  iOSUtils
//
//  Created by Jakub Piatkowski on 19/02/2015.
//  Copyright (c) 2015 jbpi. All rights reserved.
//

#import "ConversionUtils.h"

@implementation ConversionUtils

+ (NSString *)getHumanReadableByteCountBinary:(long long)bytes {
    
    return [NSByteCountFormatter stringFromByteCount:bytes countStyle:NSByteCountFormatterCountStyleBinary];
}

/**
 * Taken from:
 * http://stackoverflow.com/questions/3010216/how-can-i-convert-rgb-hex-string-into-uicolor-in-objective-c
 *
 * Modified to return transparent colour if given string is nil or empty.
 */
+ (UIColor *)getColourFromHexString:(NSString *)hexString {
    
    if (hexString == nil || [hexString isEqualToString:@""]) {
        
        return [UIColor clearColor];
    }
    
    // Remove the #
    NSString *noHashString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    // Remove + and $
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]];
    
    unsigned hex;
    
    if (![scanner scanHexInt:&hex]) {
        
        return nil;
    }
    
    int red = (hex >> 16) & 0xFF;
    int green = (hex >> 8) & 0xFF;
    int blue = (hex) & 0xFF;
    
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:1.0f];
}

+ (NSAttributedString *)getAttributedStringFromHtmlString:(NSString *)htmlString {
    
    return [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
}

@end
