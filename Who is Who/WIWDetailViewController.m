//
//  WIWDetailViewController.m
//  Who is Who
//
//  Created by Pablo Isidoro Carrillo Alvarez on 05/01/2014.
//  Copyright (c) 2014 Pablo Isidoro Carrillo Alvarez. All rights reserved.
//

#import "WIWDetailViewController.h"
#import "WIWStaff.h"
#import "UIImageView+AFNetworking.h"


@interface WIWDetailViewController ()
- (void)configureView;
@end

@implementation WIWDetailViewController

#pragma mark - Managing the detail item
/*!
 *\brief This method set the object passed by the segue
 * This method is modified from the boilerplate to admit a WIWStaff* instead of id
 *\param newDetailItem the WIWStaff object with the info
 *\return void
*/
- (void)setDetailItem:(WIWStaff*)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}
/*!
 *\brief Load the info on the elements of the view
 *
 *\return void
*/
- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.name.text = [self.detailItem name];
        self.jobTitle.text = [self.detailItem jobTitle];
        [self.photo setImageWithURL:[NSURL URLWithString:self.detailItem.photoURL]];
        self.biography.text = [self.detailItem biography];
    }
}
/*!
 *\brief Customize the elements of the view, like set a circle shape for the photo
 *
 *\return void
*/
-(void)customizeView{
    self.name.textColor=[UIColor colorWithRed:68.0f/255.0f green:68.0f/255.0f blue:68.0f/255.0f alpha:1.0];
    self.jobTitle.textColor=[UIColor colorWithRed:68.0f/255.0f green:68.0f/255.0f blue:68.0f/255.0f alpha:1.0];
    self.biography.textColor=[UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0];
    self.photo.layer.cornerRadius=self.photo.frame.size.width/2.0f;
    self.photo.layer.masksToBounds=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self customizeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
