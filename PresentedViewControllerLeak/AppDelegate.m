//
//  AppDelegate.m
//  PresentedViewControllerLeak
//
//  Created by andy on 16/06/2015.
//  Copyright (c) 2015 Bitwink. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *a = [[ViewControllerA alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = a;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    UIViewController *c = [[ViewControllerC alloc] initWithNibName:nil bundle:nil];
    [self.window setRootViewController:c];

    if ([self.window.rootViewController isKindOfClass:[ViewControllerA class]]
        && [self.window.rootViewController.presentedViewController isKindOfClass:[ViewControllerB class]]) {
        NSLog(@"A and B instances have now leaked!");
    }
}

@end
