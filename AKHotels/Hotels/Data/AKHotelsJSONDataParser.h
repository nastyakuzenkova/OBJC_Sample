//
//  AKHotelsDataParser.h
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

@import Foundation;

@class AKHotel;

@interface AKHotelsJSONDataParser : NSObject
+ (NSArray<AKHotel *> *)parseHotels:(NSData *)data error:(NSError **)error;
+ (AKHotel *)parseHotel:(NSData *)data error:(NSError **)error;
@end
