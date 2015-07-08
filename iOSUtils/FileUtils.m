//
//  FileUtils.m
//  iOSUtils
//
//  Created by Jakub Piatkowski on 19/02/2015.
//  Copyright (c) 2015 jbpi. All rights reserved.
//

#import "FileUtils.h"

@implementation FileUtils

+ (NSString *)getStringFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key {

    return (NSString *)[FileUtils getObjectFromPlistFile:filename forDictionaryKey:key];
}

+ (bool)getBoolFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key {
    
    return [[FileUtils getStringFromPlistFile:filename forDictionaryKey:key] boolValue];
}

+ (float)getFloatFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key {
    
    return [[FileUtils getStringFromPlistFile:filename forDictionaryKey:key] floatValue];
}

+ (float)getDoubleFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key {
    
    return [[FileUtils getStringFromPlistFile:filename forDictionaryKey:key] doubleValue];
}

+ (int)getIntFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key {
    
    return [[FileUtils getStringFromPlistFile:filename forDictionaryKey:key] intValue];
}

+ (NSString *)getStringFromPlistFile:(NSString *)filename forIndex:(int)index {
    
    NSString *dictionaryPlistPath = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:dictionaryPlistPath];
    
    return [array objectAtIndex:index];
}

+ (NSArray *)getArrayFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key {
    
    return (NSArray *)[FileUtils getObjectFromPlistFile:filename forDictionaryKey:key];
}

+ (NSArray *)getObjectFromPlistFile:(NSString *)filename forDictionaryKey:(NSString *)key {
    
    NSString *dictionaryPlistPath = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:dictionaryPlistPath];
    
    return [dictionary objectForKey:key];
}

/**
 * Returns a url to a file of a given name, located in the main bundle.
 */
+ (NSURL *)getUrlForFilename:(NSString *)filename {
    
    NSArray *splitFilename = [filename componentsSeparatedByString:@"."];
    NSString *nameProper = [splitFilename objectAtIndex:0];
    NSString *extension = [splitFilename objectAtIndex:1];
    
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:nameProper ofType:extension]];
}

@end
