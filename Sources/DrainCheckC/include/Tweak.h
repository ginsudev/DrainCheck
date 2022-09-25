#include "CPNotification.h"
#import <UIKit/UIKit.h>

@interface CCUIToggleModule : NSObject
@end

@interface CCUIModuleInstance : NSObject
@end

@interface CCUIModuleInstanceManager : NSObject
+ (instancetype)sharedInstance;
- (void)_updateModuleInstances;
- (CCUIModuleInstance*)instanceForModuleIdentifier:(NSString*)moduleIdentifier;
@end

@interface DNDState : NSObject
@property (getter=isActive,nonatomic,readonly) BOOL active;
@end

@interface DNDStateUpdate : NSObject
@property (nonatomic,copy,readonly) DNDState * state;
@end

@interface DNDNotificationsService : NSObject
@end
