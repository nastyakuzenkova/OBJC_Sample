//
//  AKHotelsDataParser.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AKHotelsJSONDataParser.h"
#import "AKHotel.h"

@implementation AKHotelsJSONDataParser

+ (NSArray<AKHotel *> *)parseHotels:(NSData *)data error:(NSError **)error
{
    NSError *localError = nil;
    NSArray *hotelsData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    if (localError) {
        *error = localError;
        return nil;
    }
    NSMutableArray<AKHotel *> *hotels = [NSMutableArray new];
    for (NSDictionary *hotelData in hotelsData) {
        AKHotel *hotel = [AKHotel new];
        for (NSString *key in hotelData) {
            [self parseCommonProperties:hotelData key:key hotel:hotel];
        }
        [hotels addObject:hotel];
    }
    
    return hotels;
}

+ (AKHotel *)parseHotel:(NSData *)data error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *hotelData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    if (localError) {
        *error = localError;
        return nil;
    }

    AKHotel *hotel = [AKHotel new];
    for (NSString *key in hotelData) {
        if (![self parseCommonProperties:hotelData key:key hotel:hotel]) {
            if ([key isEqualToString:@"image"]) {
                NSString *imageName = [hotelData valueForKey:key];
                hotel.imageName = imageName;
            }
            else if ([key isEqualToString:@"lat"]) {
                double lat = [[hotelData valueForKey:key] doubleValue];
                hotel.lat = lat;
            }
            else if ([key isEqualToString:@"lon"]) {
                double lon = [[hotelData valueForKey:key] doubleValue];
                hotel.lon = lon;
            }
        }
    }
    
    return hotel;
}

+ (BOOL)parseCommonProperties:(NSDictionary *)hotelData key:(NSString *)key hotel:(AKHotel *)hotel {
    if ([key isEqualToString:@"id"]) {
        NSInteger hotelId = [[hotelData valueForKey:key] integerValue];
        hotel.hotelId = hotelId;
        return YES;
    }
    else if ([key isEqualToString:@"name"]) {
        NSString *name = [hotelData valueForKey:key];
        hotel.name = name;
        return YES;
    }
    else if ([key isEqualToString:@"address"]) {
        NSString *address = [hotelData valueForKey:key];
        hotel.address = address;
        return YES;
    }
    else if ([key isEqualToString:@"stars"]) {
        NSInteger stars = [[hotelData valueForKey:key] integerValue];
        hotel.rating = stars;
        return YES;
    }
    else if ([key isEqualToString:@"distance"]) {
        double distance = [[hotelData valueForKey:key] doubleValue];
        hotel.distance = distance;
        return YES;
    }
    else if ([key isEqualToString:@"suites_availability"]) {
        NSString *suites = [hotelData valueForKey:key];
        NSArray *availableRooms = [suites componentsSeparatedByString:@":"];
        hotel.availableRooms = availableRooms;
        return YES;
    }
    return false;
}

@end
