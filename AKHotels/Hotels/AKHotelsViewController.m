//
//  ViewController.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AKHotelsViewController.h"
#import "AKHotelsDataProvider.h"
#import "AKHotelCellConstructor.h"
#import "AKHotelDetailsViewController.h"
#import "AKHotel.h"
#import "AKGroupedSortControl.h"

NSString * const AKHotelsSortKeyAvailability = @"availability";
NSString * const AKHotelsSortKeyDistance = @"distance";

@interface AKHotelsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet AKGroupedSortControl *sortControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (strong, nonatomic) AKHotelsDataProvider *dataProvider;
@property (strong, nonatomic) AKHotelCellConstructor *cellConstructor;

@end

@implementation AKHotelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.dataProvider = [AKHotelsDataProvider new];
    self.cellConstructor = [AKHotelCellConstructor new];
    
    [self.sortControl setSortingTitle:AKHotelsSortKeyAvailability forKey:AKHotelsSortKeyAvailability];
    [self.sortControl setSortingTitle:AKHotelsSortKeyDistance forKey:AKHotelsSortKeyDistance];
    [self.sortControl addTarget:self action:@selector(sortBy:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.hidden = YES;
    [self.spinner startAnimating];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDataChanged) name:AKHotelsDataChangedNotification object:_dataProvider];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification Handlers
- (void)onDataChanged {
    __weak typeof(self) wSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(wSelf) sSelf = wSelf;
        if (sSelf) {
            [sSelf.tableView reloadData];
            [sSelf.spinner stopAnimating];
            sSelf.tableView.hidden = NO;
        }
    });
}

#pragma mark - Actiob Handlers
- (void)sortBy:(AKGroupedSortControl *)sortingControl {
    self.tableView.hidden = YES;
    [self.spinner startAnimating];
    if ([sortingControl.selectedSortKey isEqualToString:AKHotelsSortKeyAvailability]) {
        [self.dataProvider sortDataByKey:AKHotelsDataSortKeyAvailability ascending:sortingControl.selectedSortAscending];
    }
    else {
        [self.dataProvider sortDataByKey:AKHotelsDataSortKeyDistance ascending:sortingControl.selectedSortAscending];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataProvider numberOfItems];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AKHotelCellIdentifier" forIndexPath:indexPath];
    [self.cellConstructor constructCell:cell forItem:[self.dataProvider itemAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"HotelDetails"])
    {
        AKHotelDetailsViewController *hotelDetailsController = (AKHotelDetailsViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
        AKHotel *hotel = [self.dataProvider itemAtIndex:indexPath.row];
        hotelDetailsController.hotelId = hotel.hotelId;
    }
}

@end
