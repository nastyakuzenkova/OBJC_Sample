//
//  AKGroupedSortControl.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/20/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AKGroupedSortControl.h"
#import "AKSortButton.h"

@interface AKGroupedSortControl ()
@property (strong, nonatomic) NSMutableArray *sortKeys;
@property (strong, nonatomic) NSMutableDictionary *sortButtons;
@property (strong, nonatomic) NSMutableArray *sortButtonConstraints;
@property (weak, nonatomic) AKSortButton *lastSortingButton;
@property (copy, nonatomic, readwrite) NSString *selectedSortKey;
@property (assign, nonatomic, readwrite) BOOL selectedSortAscending;
@end

@implementation AKGroupedSortControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.sortKeys = [NSMutableArray array];
    self.sortButtons = [NSMutableDictionary dictionary];
    self.sortButtonConstraints = [NSMutableArray array];
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (BOOL)selectedSortAscending {
    AKSortButton *button = self.sortButtons[self.selectedSortKey];
    return button.sortAscending;
}

- (void)setSelectedSortKey:(NSString *)selectedSortKey {
    if (![self.sortKeys containsObject:selectedSortKey]) {
        return;
    }
    
    if (![_selectedSortKey isEqualToString:selectedSortKey]) {
        AKSortButton *previousSelectedSortingButton = self.sortButtons[self.selectedSortKey];
        [previousSelectedSortingButton reset];
        _selectedSortKey = selectedSortKey;
    }
    
    AKSortButton *currentSortingButton = self.sortButtons[self.selectedSortKey];
    self.selectedSortAscending = currentSortingButton.sortAscending;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setSelectedSortKey:(NSString *)selectedSortKey ascending:(BOOL)ascending {
    self.selectedSortKey = selectedSortKey;
    
    AKSortButton *sortingButton = self.sortButtons[self.selectedSortKey];
    sortingButton.sortAscending = ascending;
}

- (AKSortButton *)setSortingTitle:(NSString *)title forKey:(NSString *)key {
    return [self setSortingTitle:title forKey:key defaultToAscending:NO];
}

- (AKSortButton *)setSortingTitle:(NSString *)title forKey:(NSString *)key defaultToAscending:(BOOL)defaultAscending {
    AKSortButton *sortingButton = [self sortingButtonWithTitle:title sortKey:key defaultAscending:defaultAscending];
    
    [sortingButton addTarget:self action:@selector(updateSortSelection:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sortButtons[key] = sortingButton;
    [self.sortKeys addObject:key];
    
    [self addSubview:sortingButton];
    [self constrainButton:sortingButton];
    
    if (self.sortKeys.count == self.numberOfItems) {
        [self setNeedsUpdateConstraints];
    }
    
    return sortingButton;
}

- (AKSortButton *)sortingButtonWithTitle:(NSString *)title sortKey:(NSString *)key defaultAscending:(BOOL)defaultAscending {
    AKSortButton *sortingButton = [AKSortButton buttonWithType:UIButtonTypeCustom];
    sortingButton.title = title;
    sortingButton.sortKey = key;
    sortingButton.defaultToAscending = defaultAscending;
    
    return sortingButton;
}

- (void)updateSortSelection:(AKSortButton *)sortingButton {
    self.selectedSortKey = sortingButton.sortKey;
}

#pragma mark - Utility -

- (void)constrainButton:(AKSortButton *)button {
    NSMutableArray *constraints = [NSMutableArray array];
    NSDictionary *views, *metrics;
    AKSortButton *previousButton = self.lastSortingButton;
    
    
    metrics = @{@"dividerWidth":@(1), @"dividerHeight":@39};
    
    if (!previousButton) {
        views = NSDictionaryOfVariableBindings(button);
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[button]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
    } else {
        UIView *divider = [self createDivider];
        [self addSubview:divider];
        
        views = NSDictionaryOfVariableBindings(button, previousButton, divider);
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[previousButton][divider(dividerWidth)][button(==previousButton)]"
                                                                                 options:NSLayoutFormatAlignAllCenterY
                                                                                 metrics:metrics
                                                                                   views:views]];
        
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[divider(dividerHeight)]"
                                                                                 options:0
                                                                                 metrics:metrics
                                                                                   views:views]];
    }
    
    if (self.sortButtons.count == self.numberOfItems) {
        views = NSDictionaryOfVariableBindings(button);
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[button]|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
    }
    
    views = NSDictionaryOfVariableBindings(button);
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:button
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1
                                                         constant:0]];
    
    [self addConstraints:constraints];
    
    self.lastSortingButton = button;
}

- (UIView *)createDivider {
    UIView *divider = [[UIView alloc] init];
    divider.translatesAutoresizingMaskIntoConstraints = NO;
    divider.backgroundColor = [UIColor whiteColor];
    
    return divider;
}

- (void)prepareForInterfaceBuilder {
    for (int i = 1; i <= self.numberOfItems; i++) {
        NSString *title = [NSString stringWithFormat:@"%d", i];
        [self setSortingTitle:title forKey:title];
    }
}
@end
