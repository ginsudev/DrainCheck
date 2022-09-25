#include "CPNotification.h"
#import <UIKit/UIKit.h>

@interface CCUIToggleModule : NSObject
- (void)refreshState;
@end

@interface CCUIModuleInstance : NSObject
@property (nonatomic,readonly) CCUIToggleModule *module;
@end

@interface CCUIModuleInstanceManager : NSObject
+ (instancetype)sharedInstance;
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
