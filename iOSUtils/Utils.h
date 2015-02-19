//
//  Utils.h
//  iOSUtils
//
//  Created by Jakub Piatkowski on 19/02/2015.
//  Copyright (c) 2015 jbpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString *)getBundleDisplayName;

+ (NSString *)replaceFirstOccurenceOfString:(NSString *)searchedString withReplacementString:(NSString *)replacementString inString:(NSString *)fullString;

+ (void)performAfterDelay:(float)delayInSeconds block:(dispatch_block_t) block;

@end
