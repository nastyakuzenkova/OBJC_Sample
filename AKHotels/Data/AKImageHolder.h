//
//  AKImageHolder.h
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/20/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface AKImageHolder : NSObject
+ (AKImageHolder *)sharedInstance;

- (UIImage *)imageByKey:(NSString *)key;
- (void)setImage:(UIImage *)image withKey:(NSString *)key;
@end
