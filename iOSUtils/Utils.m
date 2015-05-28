//
//  Utils.m
//  iOSUtils
//
//  Created by Jakub Piatkowski on 19/02/2015.
//  Copyright (c) 2015 jbpi. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)getBundleDisplayName {
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    return [info objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)getBundleIdentifier {
    
    return [[NSBundle mainBundle] bundleIdentifier];
}

/**
 * Replaces the 1st occurence of a searched string with a replacement string.
 *
 * Taken from: http://stackoverflow.com/questions/8608346/replace-only-the-first-instance-of-a-substring-in-an-nsstring
 */
+ (NSString *)replaceFirstOccurenceOfString:(NSString *)searchedString withReplacementString:(NSString *)replacementString inString:(NSString *)fullString {
    
    NSRange range = [fullString rangeOfString:searchedString];
    NSString *newString = fullString;
    
    if (NSNotFound != range.location) {
        
        newString = [fullString stringByReplacingCharactersInRange:range withString:replacementString];
    }
    
    return newString;
}

/**
 * Executes given block after a delay.
 *
 * Taken from:
 * http://stackoverflow.com/questions/4139219/how-do-you-trigger-a-block-after-a-delay-like-performselectorwithobjectafter
 */
+ (void)performAfterDelay:(float)delayInSeconds block:(dispatch_block_t) block {
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

/**
 * Checks if a given VC is presented modally.
 *
 * Taken from:
 * http://stackoverflow.com/questions/2798653/is-it-possible-to-determine-whether-viewcontroller-is-presented-as-modal
 */
+ (bool)isPresentedModallyViewController:(UIViewController *)viewController {
    
    return viewController.presentingViewController.presentedViewController == viewController
        || (viewController.navigationController.presentingViewController.presentedViewController != nil
            && viewController.navigationController != nil
            && viewController.navigationController.presentingViewController.presentedViewController == viewController.navigationController)
        || [viewController.tabBarController.presentingViewController isKindOfClass:[UITabBarController class]];
}

/**
 * Assumes that a page is as wide as the ScrollView.
 */
+ (int)getCurrentPageForScrollView:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = scrollView.frame.size.width;
    
    return floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

/**
 * Generate a string of random alphanumeric characters and given length. Useful for things which
 * require unique strings.
 * 
 * Note: CASE SENSITIVE.
 * 
 * Note: length has a high influence on how likely it'll be to generate the same string twice.
 * The probability factor formula is: 1 / (number_of_possible_chars ^ stringLength). Using chars
 * from the English alphabet gives us: 1 / (62 ^ stringLength).
 */
+ (NSString *)generateRandomStringOfLength:(int)length {
    
    // A uuid can have chars from the following range: [A-Za-z0-9]
    // This means there's 62 possible chars for each char spot in the string
    char orderIdChars[length + 1];
    
    for (int i = 0; i < length; i++) {
        
        int randomCharIndex = arc4random_uniform((int) strlen(ALPHANUMERIC_CHARS_ENG));
        orderIdChars[i] = ALPHANUMERIC_CHARS_ENG[randomCharIndex];
    }
    // Add null termination for the array of chars to be treated as C-style string
    orderIdChars[length] = '\0';
    NSString *orderId = [[NSString alloc] initWithCString:orderIdChars encoding:NSUTF8StringEncoding];
    
    return orderId;
}

const char ALPHANUMERIC_CHARS_ENG[] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
    'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q',
    'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7',
    '8', '9' };

+ (NSString *)generateUuid {
    
    return [Utils generateRandomStringOfLength:32];
}

+ (long long)getCurrentTime {
    
    NSDate *dateNow = [[NSDate alloc] init];
    
    return (long long)([dateNow timeIntervalSince1970] * 1000.0);
}

@end
