//
//  AKHotelDataProvider.h
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "AKDataProvider.h"

extern NSString *const AKHotelsDataChangedNotification;

typedef NS_ENUM(NSUInteger, AKHotelsDataSortKey)
{
    AKHotelsDataSortKeyAvailability = 0,
    AKHotelsDataSortKeyDistance
};

@interface AKHotelsDataProvider : NSObject <AKDataProvider>
- (void)sortDataByKey:(AKHotelsDataSortKey)key ascending:(BOOL)isAscending;
@end
