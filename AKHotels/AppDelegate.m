//
//  AppDelegate.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AppDelegate.h"
#import "AKHotelsDataService.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.service = [AKHotelsDataService new];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

@end
