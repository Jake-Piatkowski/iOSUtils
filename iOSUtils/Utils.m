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

@end
