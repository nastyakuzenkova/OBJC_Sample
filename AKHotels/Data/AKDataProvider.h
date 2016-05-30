//
//  AKDataProvider.h
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

@import Foundation;

@protocol AKDataProvider <NSObject>
- (NSUInteger)numberOfItems;
- (id)itemAtIndex:(NSUInteger)index;
@end
