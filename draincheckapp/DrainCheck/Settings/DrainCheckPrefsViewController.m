//
//  DrainCheckPrefsViewController.m
//  DrainCheck
//
//  Created by Noah Little on 25/9/2022.
//

#import "DrainCheckPrefsViewController.h"
#import "objc/runtime.h"

@implementation DrainCheckPrefsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/draincheck.bundle"];
    
    [bundle load];
    
    if ([bundle isLoaded]) {
        self.root = [objc_getClass("draincheck.RootListController") new];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.viewControllers = @[self.root];
}

@end
