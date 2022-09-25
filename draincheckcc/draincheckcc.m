#import "draincheckcc.h"

@implementation draincheckcc

// Most third-party Control Center modules out there use non-CAML approach because it's easier to get icon images than create CAML
// Choose either CAML and non-CAML portion of the code for your final implementation of the toggle
// IMPORTANT: To prepare your icons and configure the toggle to its fullest, check out CCSupport Wiki: https://github.com/opa334/CCSupport/wiki

#pragma mark - Non-CAML approach

// Icon of your module
- (UIImage *)iconGlyph {
    return [UIImage imageNamed:@"icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

// Optional: Icon of your module, once selected 
- (UIImage *)selectedIconGlyph {
    return [UIImage imageNamed:@"icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

// Selected color of your module
- (UIColor *)selectedColor {
    return [UIColor colorWithRed: 0.30 green: 0.50 blue: 0.35 alpha: 1.00];
}

#pragma mark - End Non-CAML approach

// Current state of your module
- (BOOL)isSelected {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"DrainCheck.isEnabled"];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
        
    if (selected) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"DrainCheck.isEnabled"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DrainCheck.Notification.Enable" object:nil];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"DrainCheck.isEnabled"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DrainCheck.Notification.Disable" object:nil];
    }
}

@end
