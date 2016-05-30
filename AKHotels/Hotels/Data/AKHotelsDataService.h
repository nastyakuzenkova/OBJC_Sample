//
//  AKHotelsDataService.h
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

@import UIKit;

@class AKHotel;

@interface AKHotelsDataService : NSObject
- (void)requestHotelsData:(void (^)(NSArray<AKHotel *> *hotels))successBlock :(void (^)(NSError *error))failureBlock;
- (void)requestHotelDataById:(NSInteger)hotelId :(void (^)(AKHotel * hotel))successBlock :(void (^)(NSError *error))failureBlock;
- (void)requestHotelImageDataByName:(NSString *)name :(void (^)(UIImage *image))successBlock :(void (^)(NSError *error))failureBlock;
@end
