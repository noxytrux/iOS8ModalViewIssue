//
//  MWLCitiesTableViewController.h
//  ModalViewLabs
//
//  Created by Marcin Pędzimąż on 24.09.2014.
//  Copyright (c) 2014 Marcin Pedzimaz. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const kMWLSegueControllerIdentifier;

@class MWLCitiesTableViewController;

@protocol MWLCitiesTableViewControllerDelegate <NSObject>

@optional
- (void)citiesTableView:(MWLCitiesTableViewController *)sender
          didSelectCity:(NSString *)cityName;

@end

@interface MWLCitiesTableViewController : UITableViewController
@property(nonatomic, weak) id<MWLCitiesTableViewControllerDelegate> delegate;
@end
