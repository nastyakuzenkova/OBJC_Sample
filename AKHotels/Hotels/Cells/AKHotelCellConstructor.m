//
//  AKHotelCellConstructor.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AKHotelCellConstructor.h"
#import "AKHotel.h"
#import "AKHotelCell.h"

@implementation AKHotelCellConstructor

#pragma mark - AKCellConstructor
- (void)constructCell:(UITableViewCell *)cell forItem:(id)item {
    AKHotel *hotel = item;
    AKHotelCell *hotelCell = (AKHotelCell *)cell;
    
    NSMutableString *stars = [NSMutableString new];
    for (int i = 0; i < hotel.rating; ++i) {
        [stars appendString:@"\u22C6 "];
    }
    hotelCell.starsLabel.text = stars;
    hotelCell.nameLabel.text = hotel.name;
    hotelCell.addressLabel.text = hotel.address;
    hotelCell.distanceLabel.text = [NSString stringWithFormat:@"%0.2f km to center", hotel.distance];
    hotelCell.availabilityLabel.text = [NSString stringWithFormat:@"suites available: %lu", (unsigned long)[hotel.availableRooms count]];
    
    hotelCell.selectionStyle = UITableViewCellSelectionStyleNone;
    hotelCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
