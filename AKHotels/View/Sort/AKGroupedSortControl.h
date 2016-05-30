//
//  AKGroupedSortControl.h
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/20/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

@import UIKit;

@class AKSortButton;

@interface AKGroupedSortControl : UIControl
@property (assign, nonatomic) IBInspectable NSUInteger numberOfItems;
@property (copy, nonatomic, readonly) NSString *selectedSortKey;
@property (assign, nonatomic, readonly) BOOL selectedSortAscending;

@property (nonatomic, readonly) NSMutableDictionary *sortButtons;

- (void)setSelectedSortKey:(NSString *)selectedSortKey ascending:(BOOL)ascending;

- (AKSortButton *)setSortingTitle:(NSString *)title forKey:(NSString *)key;
- (AKSortButton *)setSortingTitle:(NSString *)title forKey:(NSString *)key defaultToAscending:(BOOL)defaultAscending;
@end
