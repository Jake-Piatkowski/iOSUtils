//
//  DeviceUtils.h
//  iOSUtils
//
//  Created by Jakub Piatkowski on 19/02/2015.
//  Copyright (c) 2015 jbpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceUtils : NSObject

+ (int)getScreenHeight;
+ (int)getScreenWidth;
+ (int)getScreenHeightInPts;
+ (int)getScreenWidthInPts;
+ (float)getScreenDensity;
+ (int)getStatusBarHeightInPts;

+ (bool)isCameraAvailable;

+ (NSString *)getUserFriendlyDeviceName;
+ (int)getOSVersion;

+ (void)showNetworkActivityIndicator;
+ (void)hideNetworkActivityIndicator;

@end
