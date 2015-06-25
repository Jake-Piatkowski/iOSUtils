//
//  DeviceUtils.m
//  iOSUtils
//
//  Created by Jakub Piatkowski on 19/02/2015.
//  Copyright (c) 2015 jbpi. All rights reserved.
//

#import "DeviceUtils.h"

#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@implementation DeviceUtils

/**
 * Returns the height of the screen in pixels.
 */
+ (int)getScreenHeight {
    
    int height = [[UIScreen mainScreen] bounds].size.height;
    float density = [DeviceUtils getScreenDensity];
    
    return height * density;
}

/**
 * Returns the width of the screen in pixels.
 */
+ (int)getScreenWidth {
    
    int width = [[UIScreen mainScreen] bounds].size.width;
    int density = [DeviceUtils getScreenDensity];
    
    return width * density;
}

/**
 * Returns the height of the screen in points.
 */
+ (int)getScreenHeightInPts {
    
    return [[UIScreen mainScreen] bounds].size.height;
}

/**
 * Returns the width of the screen in points.
 */
+ (int)getScreenWidthInPts {
    
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (float)getScreenDensity {
    
    return [[UIScreen mainScreen] scale];
}

/**
 * Taken from: http://stackoverflow.com/questions/12991935/how-to-programmatically-get-ios-status-bar-height
 */
+ (int)getStatusBarHeightInPts {
    
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    
    return (int) MIN(statusBarSize.width, statusBarSize.height);
}

+ (bool)isCameraAvailable {
    
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    return [videoDevices count] > 0;
}

+ (void)performIfCameraAccessibleBlock:(void (^)())blockSuccess inaccessiblebleBlock:(void (^)())blockFailure {
    
    // Taken from: http://stackoverflow.com/questions/25803217/presenting-camera-permission-dialog-in-ios-8
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (status == AVAuthorizationStatusAuthorized) { // authorized
        
        blockSuccess();
    }
    else if (status == AVAuthorizationStatusDenied) { // denied
        
        blockFailure();
    }
    else if (status == AVAuthorizationStatusRestricted) { // restricted
        
        blockFailure();
    }
    else if (status == AVAuthorizationStatusNotDetermined) { // not determined
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
            if (granted) { // Access has been granted ..do something
                
                blockSuccess();
            } 
            else { // Access denied ..do something
                
                blockFailure();
            }
        }];
    }
}

/**
 * Taken from: http://stackoverflow.com/questions/11197509/ios-how-to-get-device-make-and-model by NicolasMiari.
 * Will have to be updated with new devices every now and then.
 *
 */
+ (NSString *)getUserFriendlyDeviceName {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      :@"Simulator",
                              @"x86_64"    :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch",      // (Original)
                              @"iPod2,1"   :@"iPod Touch",      // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch",      // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch",      // (Fourth Generation)
                              @"iPhone1,1" :@"iPhone",          // (Original)
                              @"iPhone1,2" :@"iPhone",          // (3G)
                              @"iPhone2,1" :@"iPhone",          // (3GS)
                              @"iPad1,1"   :@"iPad",            // (Original)
                              @"iPad2,1"   :@"iPad 2",          //
                              @"iPad3,1"   :@"iPad",            // (3rd Generation)
                              @"iPhone3,1" :@"iPhone 4",        // (GSM)
                              @"iPhone3,3" :@"iPhone 4",        // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",       //
                              @"iPhone5,1" :@"iPhone 5",        // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",        // (model A1429, everything else)
                              @"iPad3,4"   :@"iPad",            // (4th Generation)
                              @"iPad2,5"   :@"iPad Mini",       // (Original)
                              @"iPhone5,3" :@"iPhone 5c",       // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",       // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",       // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",       // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",   //
                              @"iPhone7,2" :@"iPhone 6",        //
                              @"iPad4,1"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   :@"iPad Mini",       // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini"        // (2nd Generation iPad Mini - Cellular)
                              };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
    }
    
    return deviceName;
}

+ (int)getOSVersion {
    
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    char firstCharVersion = [osVersion characterAtIndex:0];
    
    if (firstCharVersion == '6') {
        
        return 6;
    }
    else if (firstCharVersion == '7') {
        
        return 7;
    }
    else if (firstCharVersion == '8') {
        
        return 8;
    }
    else {
        
        return 9;
    }
}

+ (void)showNetworkActivityIndicator {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

+ (void)hideNetworkActivityIndicator {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
