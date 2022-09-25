//
//  _CPNotification.m
//  
//
//  Created by Noah Little on 21/9/2022.
//

#import "include/CPNotification.h"
#import <objc/runtime.h>

@implementation _CPNotification

+ (void)showAlertWithTitle:(id)title message:(id)message userInfo:(id)userInfo badgeCount:(int)badgeCount soundName:(id)soundName delay:(double)delay repeats:(BOOL)repeats bundleId:(id)bundleId uuid:(id)uuid silent:(BOOL)silent {
    [objc_getClass("CPNotification") showAlertWithTitle:title message:message userInfo:userInfo badgeCount:badgeCount soundName:soundName delay:delay repeats:repeats bundleId:bundleId uuid:uuid silent:silent];
}

+ (void)hideAlertWithBundleId:(NSString *)bundleId uuid:(NSString*)uuid {
    [objc_getClass("CPNotification") hideAlertWithBundleId:bundleId uuid:uuid];
}

@end
