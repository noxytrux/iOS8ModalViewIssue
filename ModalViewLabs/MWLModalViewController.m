//
//  MWLModalViewController.m
//  ModalViewLabs
//
//  Created by Marcin Pędzimąż on 24.09.2014.
//  Copyright (c) 2014 Marcin Pedzimaz. All rights reserved.
//

#import "MWLModalViewController.h"

@implementation MWLModalViewController

- (IBAction)cancelButtonPress:(UIBarButtonItem *)sender {

    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 
                             }];
    
}

@end
