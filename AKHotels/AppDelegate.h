//
//  AppDelegate.h
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

@import UIKit;

@class AKHotelsDataService;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AKHotelsDataService *service;
@end

