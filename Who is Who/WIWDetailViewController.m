//
//  WIWDetailViewController.m
//  Who is Who
//
//  Created by Pablo Isidoro Carrillo Alvarez on 05/01/2014.
//  Copyright (c) 2014 Pablo Isidoro Carrillo Alvarez. All rights reserved.
//

#import "WIWDetailViewController.h"

@interface WIWDetailViewController ()
- (void)configureView;
@end

@implementation WIWDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
