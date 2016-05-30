//
//  AKImageHolder.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/20/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AKImageHolder.h"

@interface AKImageHolder ()
@property (strong, nonatomic) NSCache *imageCache;
@end

@implementation AKImageHolder
+ (AKImageHolder *)sharedInstance {
    static AKImageHolder *sharedOnceInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOnceInstance = [self new];
    });
    return sharedOnceInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _imageCache = [NSCache new];
    }
    return self;
}

- (UIImage *)imageByKey:(NSString *)key {
    return [self.imageCache objectForKey:key];
}
- (void)setImage:(UIImage *)image withKey:(NSString *)key {
    [self.imageCache setObject:image forKey:key];
}
@end
