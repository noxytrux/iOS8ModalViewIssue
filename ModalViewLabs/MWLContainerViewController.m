//
//  MWLContainerViewController.m
//  ModalViewLabs
//
//  Created by Marcin Pędzimąż on 24.09.2014.
//  Copyright (c) 2014 Marcin Pedzimaz. All rights reserved.
//

#import "MWLContainerViewController.h"
#import "MWLCitiesTableViewController.h"

@interface MWLContainerViewController ()
<UITextFieldDelegate,
UIPopoverControllerDelegate,
MWLCitiesTableViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *typeCityTextField;
@property (nonatomic, strong) UIPopoverController *searchPopoverController;
@property (assign, nonatomic, getter = isKeyboardVisible) BOOL keyboardVisible;
@property (nonatomic, weak) MWLCitiesTableViewController *selectionController;

@end

@implementation MWLContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.typeCityTextField.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)keyboardDidShow:(NSNotification *)notification
{
    self.keyboardVisible = YES;
    
    if(self.typeCityTextField.editing) {
        
        [self showControllerIfNeeded:self.typeCityTextField];
    }
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    self.keyboardVisible = NO;
}

- (void)showControllerIfNeeded:(UIView *)sender
{
    if(self.searchPopoverController.popoverVisible == NO && self.keyboardVisible == YES) {
        
        self.searchPopoverController = [self itemSelectionPopover];
        [self.searchPopoverController presentPopoverFromRect:sender.bounds
                                                      inView:sender
                                    permittedArrowDirections:UIPopoverArrowDirectionDown
                                                    animated:YES];
    }
}

- (UIPopoverController *)itemSelectionPopover
{
    MWLCitiesTableViewController *cityController = [self.storyboard instantiateViewControllerWithIdentifier:kMWLSegueControllerIdentifier];
    self.selectionController = cityController;
    self.selectionController.delegate = self;
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:cityController];
    
    popoverController.delegate = self;
    popoverController.popoverContentSize = CGSizeMake(300, 400);
    
    return popoverController;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.typeCityTextField.clearsOnInsertion = YES;
    
    [self showControllerIfNeeded:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.searchPopoverController dismissPopoverAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    //delegate down
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    [self.typeCityTextField resignFirstResponder];
    
#warning This is the key to fix the issue
    return NO;//YES;
}

#pragma mark - MWLCitiesTableViewControllerDelegate

- (void)citiesTableView:(MWLCitiesTableViewController *)sender
          didSelectCity:(NSString *)cityName
{
    self.typeCityTextField.text = cityName;
    [self.typeCityTextField resignFirstResponder];
}

@end
