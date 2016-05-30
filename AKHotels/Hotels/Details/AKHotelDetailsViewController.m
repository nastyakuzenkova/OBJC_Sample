//
//  AKHotelDetailsViewController.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/19/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AKHotelDetailsViewController.h"
#import "AKHotel.h"
#import "AppDelegate.h"
#import "AKHotelsDataService.h"
#import "AKImageHolder.h"

@interface AKHotelDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotelImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *suitesLabel;
@property (weak, nonatomic) IBOutlet UIButton *showMapButton;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (strong, nonatomic) AKHotel *hotel;
@property (strong, nonatomic) AKHotelsDataService *service;
@end

@implementation AKHotelDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.service = [appDelegate service];
    self.hotelImageView.bounds = CGRectInset(self.hotelImageView.frame, 10.0f, 10.0f);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.spinner startAnimating];
    __weak typeof(self) wSelf = self;
    [self.service requestHotelDataById:self.hotelId :^(AKHotel *hotel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wSelf setHotel:hotel];
        });
    } :^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"                                                                                 message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                __strong typeof(wSelf) sSelf = wSelf;
                if (sSelf) {
                    [sSelf.navigationController popViewControllerAnimated:YES];
                }
            }]];
            [wSelf presentViewController:alertController animated:YES completion:nil];
        });
    }];
}

- (void)setHotel:(AKHotel *)hotel {
    _hotel = hotel;
    
    NSMutableString *stars = [NSMutableString new];
    for (int i = 0; i < hotel.rating; ++i) {
        [stars appendString:@"\u22C6 "];
    }
    self.starsLabel.text = stars;
    self.nameLabel.text = hotel.name;
    self.addressLabel.text = hotel.address;
    self.distanceLabel.text = [NSString stringWithFormat:@"%0.2f km to center", hotel.distance];
    self.suitesLabel.text = [NSString stringWithFormat:@"suites available: %@", [hotel.availableRooms componentsJoinedByString:@", "]];
    UIImage *hotelImage = [[AKImageHolder sharedInstance] imageByKey:hotel.imageName];
    if (!hotelImage) {
        __weak typeof(self) wSelf = self;
        __block NSString *imageName = hotel.imageName;
        [self.service requestHotelImageDataByName:imageName :^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(wSelf) sSelf = wSelf;
                if (sSelf) {
                    if (image) {
                        [sSelf.hotelImageView setImage:image];
                        [[AKImageHolder sharedInstance] setImage:image withKey:imageName];
                    }
                    [sSelf.spinner stopAnimating];
                    sSelf.overlayView.hidden = YES;
                }
            });
        } :^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(wSelf) sSelf = wSelf;
                if (sSelf) {
                    [sSelf.spinner stopAnimating];
                    sSelf.overlayView.hidden = YES;
                }
            });
        }];
    }
    else {
        [self.hotelImageView setImage:hotelImage];
        [self.spinner stopAnimating];
        self.overlayView.hidden = YES;
    }
    
    
}

- (IBAction)onShowMapButtonTap:(UIButton *)sender {
    MKPlacemark *hotelLocation = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(self.hotel.lat, self.hotel.lon) addressDictionary:nil];
    MKMapItem *hotelItem = [[MKMapItem alloc] initWithPlacemark:hotelLocation];
    hotelItem.name = self.hotel.name;
    [hotelItem openInMapsWithLaunchOptions:nil];
}
@end
