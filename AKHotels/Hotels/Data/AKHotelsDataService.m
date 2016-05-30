//
//  AKHotelsDataService.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AKHotelsDataService.h"
#import "AKHotel.h"
#import "AKHotelsJSONDataParser.h"
#import "AKImageParser.h"

@implementation AKHotelsDataService

- (void)requestHotelsData:(void (^)(NSArray<AKHotel *> *))successBlock :(void (^)(NSError *))failureBlock
{
    NSString *urlAsString = @"https://dl.dropboxusercontent.com/u/109052005/1/0777.json";
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }
        else {
            NSError *error = nil;
            NSArray<AKHotel *> *hotels = [AKHotelsJSONDataParser parseHotels:data error:&error];
            
            if (error != nil) {
                if (failureBlock) {
                    failureBlock(error);
                }
                
            } else {
                if (successBlock) {
                    successBlock(hotels);
                }
            }
        }
    }] resume];
}

- (void)requestHotelDataById:(NSInteger)hotelId :(void (^)(AKHotel *))successBlock :(void (^)(NSError *))failureBlock {
    NSString *urlAsString = [NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/109052005/1/%ld.json", (long)hotelId];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }
        else {
            NSError *error = nil;
            AKHotel * hotel = [AKHotelsJSONDataParser parseHotel:data error:&error];
            
            if (error != nil) {
                if (failureBlock) {
                    failureBlock(error);
                }
                
            } else {
                if (successBlock) {
                    successBlock(hotel);
                }
            }
        }
    }] resume];
}

- (void)requestHotelImageDataByName:(NSString *)name :(void (^)(UIImage *image))successBlock :(void (^)(NSError *error))failureBlock {
    NSString *urlAsString = [NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/109052005/1/%@", name];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }
        else {
            if (successBlock) {
                successBlock([AKImageParser imageWithData:data]);
            }
        }
    }] resume];
}

@end
