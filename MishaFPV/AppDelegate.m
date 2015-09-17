//
//  AppDelegate.m
//  MishaFPV
//
//  Created by Vitaly Berg on 17/09/15.
//  Copyright © 2015 Vitaly Berg. All rights reserved.
//

#import "AppDelegate.h"

#import "FPVViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.idleTimerDisabled = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    FPVViewController *fpvVC = [[FPVViewController alloc] init];
    self.window.rootViewController = fpvVC;
    
    return YES;
}

@end
