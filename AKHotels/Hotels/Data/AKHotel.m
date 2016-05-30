//
//  AKHotel.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AKHotel.h"

@implementation AKHotel
- (void)setAvailableRooms:(NSArray *)availableRooms {
    _availableRooms = availableRooms;
    _availableRoomsCount = availableRooms.count;
}
@end
