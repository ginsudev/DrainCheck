//
//  Header.h
//  
//
//  Created by Noah Little on 21/9/2022.
//
#import <Foundation/Foundation.h>
#include <dlfcn.h>

@interface CPNotification : NSObject
+ (void)showAlertWithTitle:(id)title
            message:(id)message
          userInfo:(id)userInfo
        badgeCount:(int)badgeCount
         soundName:(id)soundName
             delay:(double)delay
           repeats:(BOOL)repeats
          bundleId:(id)bundleId
              uuid:(id)uuid
            silent:(BOOL)silent;

+ (void)hideAlertWithBundleId:(NSString *)bundleId uuid:(NSString*)uuid;
@end

@interface _CPNotification : NSObject
+ (void)showAlertWithTitle:(id)title
            message:(id)message
          userInfo:(id)userInfo
        badgeCount:(int)badgeCount
         soundName:(id)soundName
             delay:(double)delay
           repeats:(BOOL)repeats
          bundleId:(id)bundleId
              uuid:(id)uuid
            silent:(BOOL)silent;

+ (void)hideAlertWithBundleId:(NSString *)bundleId uuid:(NSString*)uuid;
@end
