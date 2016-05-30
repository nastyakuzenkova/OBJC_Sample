//
//  AKImageParser.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/20/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AKImageParser.h"

@implementation AKImageParser
+ (UIImage *)imageWithData:(NSData *)data {
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
        CGFloat width = image.size.width - 2.0f;
        CGFloat height = image.size.height - 2.0f;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), YES, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(context);
        CGPoint origin = CGPointMake((width - image.size.width) / 2.0f,
                                 (height - image.size.height) / 2.0f);
        [image drawAtPoint:origin];
        UIGraphicsPopContext();
        UIImage *updatedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return updatedImage;
    }
    return image;
}

@end
