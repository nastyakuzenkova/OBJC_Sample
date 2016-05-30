//
//  AKHotel.h
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

@import Foundation;

@interface AKHotel : NSObject
@property (assign, nonatomic) NSInteger hotelId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *address;
@property (assign, nonatomic) double distance;
@property (strong, nonatomic) NSArray *availableRooms;
@property (assign, nonatomic, readonly) NSUInteger availableRoomsCount;
@property (assign, nonatomic) NSInteger rating;
@property (copy, nonatomic) NSString *imageName;
@property (assign, nonatomic) double lat;
@property (assign, nonatomic) double lon;
@end
