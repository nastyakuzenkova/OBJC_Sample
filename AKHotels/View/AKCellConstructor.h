//
//  AKCellConstructor.h
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

@import Foundation;
@import UIKit;

@protocol AKCellConstructor <NSObject>
- (void)constructCell:(UITableViewCell *)cell forItem:(id)item;
@end
