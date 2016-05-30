//
//  AKSortButton.h
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/20/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKSortButton : UIButton
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *sortKey;
@property (assign, nonatomic) BOOL defaultToAscending;
@property (nonatomic, getter=isSortAscending) BOOL sortAscending;

- (void)reset;
@end
