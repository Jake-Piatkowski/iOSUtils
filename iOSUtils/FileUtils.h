//
//  FileUtils.h
//  iOSUtils
//
//  Created by Jakub Piatkowski on 19/02/2015.
//  Copyright (c) 2015 jbpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject

+ (NSString *)getStringFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key;
+ (bool)getBoolFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key;
+ (float)getFloatFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key;
+ (int)getIntFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key;
+ (NSString *)getStringFromPlistFile:(NSString *)filename forIndex:(int)index;
+ (NSArray *)getArrayFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key;

+ (NSURL *)getUrlForFilename:(NSString *)filename;

@end
