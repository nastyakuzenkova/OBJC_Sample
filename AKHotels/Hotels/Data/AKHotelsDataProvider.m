//
//  AKHotelDataProvider.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AKHotelsDataProvider.h"
#import "AKHotel.h"
#import "AppDelegate.h"
#import "AKHotelsDataService.h"

NSString *const AKHotelsDataChangedNotification = @"AKHotelsDataChangedNotification";

@interface AKHotelsDataProvider ()
@property (nonatomic, strong) NSArray<AKHotel *> *hotels;
@end

@implementation AKHotelsDataProvider

- (instancetype)init {
    if (self = [super init]) {
        self.hotels = [NSArray new];
        AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
        __weak typeof(self) wSelf = self;
        [appDelegate.service requestHotelsData:^(NSArray<AKHotel *> *hotels) {
            [wSelf setHotels:hotels];
        } :^(NSError *error) {
            
        }];
    }
    return self;
}

- (void)setHotels:(NSArray<AKHotel *> *)hotels {
    if (_hotels == hotels) {
        return;
    }
    
    _hotels = hotels;
    [[NSNotificationCenter defaultCenter] postNotificationName:AKHotelsDataChangedNotification object:self];
}

- (void)sortDataByKey:(AKHotelsDataSortKey)key ascending:(BOOL)isAscending
{
    switch (key) {
        case AKHotelsDataSortKeyAvailability: {
            NSMutableArray *sortedHotels = [_hotels mutableCopy];
            [sortedHotels sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"availableRoomsCount" ascending:isAscending]]];
            self.hotels = sortedHotels;
            break;
        }
        case AKHotelsDataSortKeyDistance: {
            NSMutableArray *sortedHotels = [_hotels mutableCopy];
            [sortedHotels sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:isAscending]]];
            self.hotels = sortedHotels;
            break;
        }
    }
}

#pragma mark - AKDataProvider
- (NSUInteger)numberOfItems {
    return [self.hotels count];
}

- (id)itemAtIndex:(NSUInteger)index {
    return self.hotels[index];
}

@end
