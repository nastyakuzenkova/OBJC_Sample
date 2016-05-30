//
//  AKSortButton.m
//  AKHotels
//
//  Created by Anastasia Kuzenkova on 5/20/16.
//  Copyright © 2016 askuzenkova. All rights reserved.
//

#import "AKSortButton.h"

@interface AKSortButton ()
@property (nonatomic) UILabel *topArrowLabel;
@property (nonatomic) UILabel *bottomArrowLabel;

@property (nonatomic) NSMutableArray *arrowConstraints;
@end

@implementation AKSortButton

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
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.topArrowLabel = [UILabel new];
    self.topArrowLabel.font = [UIFont systemFontOfSize:12.0f];
    self.topArrowLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.topArrowLabel.textAlignment = NSTextAlignmentCenter;
    self.topArrowLabel.text = @"\u25b2";
    self.topArrowLabel.textColor = [UIColor orangeColor];
    self.topArrowLabel.hidden = YES;
    [self addSubview:self.topArrowLabel];
    
    self.bottomArrowLabel = [UILabel new];
    self.bottomArrowLabel.font = [UIFont systemFontOfSize:12.0f];
    self.bottomArrowLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomArrowLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomArrowLabel.text = @"\u25bc";
    self.bottomArrowLabel.textColor = [UIColor orangeColor];
    self.bottomArrowLabel.hidden = YES;
    [self addSubview:self.bottomArrowLabel];
    
    [self.topArrowLabel sizeToFit];
    [self.bottomArrowLabel sizeToFit];
    
    self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(updateSelection) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateConstraints {
    if (!self.arrowConstraints) {
        NSMutableArray *constraints = [NSMutableArray array];
        
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.topArrowLabel
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1
                                                             constant:0]];
        
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.topArrowLabel
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1
                                                             constant:0]];
        
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.bottomArrowLabel
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1
                                                             constant:0]];
        
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.bottomArrowLabel
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1
                                                             constant:0]];
        
        
        [self addConstraints:constraints];
        self.arrowConstraints = constraints;
    }
    [super updateConstraints];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(44, 44);
}

- (void)setTitle:(NSString *)title {
    if ([_title isEqualToString:title]) {
        return;
    }
    
    _title = title;
    
    [self setTitle:_title forState:UIControlStateNormal];
}

- (void)setDefaultToAscending:(BOOL)defaultToAscending {
    _defaultToAscending = defaultToAscending;
    
    if (_defaultToAscending != self.sortAscending) {
        _sortAscending = _defaultToAscending;
    }
}

- (void)setSortAscending:(BOOL)sortAscending {
    _sortAscending = sortAscending;
    
    [self updateIcon];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    } else {
        self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    
    [self updateIcon];
}

- (void)updateSelection {
    if (![self isSelected]) {
        self.selected = YES;
        self.sortAscending = self.defaultToAscending;
    } else {
        self.sortAscending = !self.sortAscending;
    }
}

- (void)reset {
    self.selected = NO;
    self.sortAscending = self.defaultToAscending;
}

- (void)updateIcon {
    self.topArrowLabel.hidden = !(self.isSelected && self.sortAscending);
    self.bottomArrowLabel.hidden = !(self.isSelected && !self.sortAscending);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.isSelected) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end

