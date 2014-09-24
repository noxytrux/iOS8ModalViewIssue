//
//  MWLCitiesTableViewController.m
//  ModalViewLabs
//
//  Created by Marcin Pędzimąż on 24.09.2014.
//  Copyright (c) 2014 Marcin Pedzimaz. All rights reserved.
//

#import "MWLCitiesTableViewController.h"
#import "NSLocale+LocalizedCountryCodes.h"

NSString * const kMWLSegueControllerIdentifier = @"kMWLSegueControllerIdentifier";
NSString * const kMWLBaseCellIdeintifier = @"kMWLBaseCellIdeintifier";

@interface MWLCitiesTableViewController ()
@property(nonatomic, strong) NSMutableArray *dataItems;
@end

@implementation MWLCitiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *countryCodes = [NSLocale localizedNamesWithCodesDictionary];
    
    self.dataItems = [NSMutableArray arrayWithCapacity:[countryCodes count]];
    
    for (NSString *countryCode in countryCodes) {
        
        [self.dataItems addObject:countryCodes[countryCode]];
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMWLBaseCellIdeintifier
                                                            forIndexPath:indexPath];
  
    cell.textLabel.text = self.dataItems[indexPath.row];
  
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(citiesTableView:didSelectCity:)]) {
     
        NSString *cityName = self.dataItems[indexPath.row];
        
        [self.delegate citiesTableView:self
                         didSelectCity:cityName];
    }
}

@end
