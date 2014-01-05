//
//  WIWDetailViewController.h
//  Who is Who
//
//  Created by Pablo Isidoro Carrillo Alvarez on 05/01/2014.
//  Copyright (c) 2014 Pablo Isidoro Carrillo Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIWStaff.h"

@interface WIWDetailViewController : UIViewController

@property (strong, nonatomic) WIWStaff* detailItem;
/// The name of the staff's member
@property (weak, nonatomic) IBOutlet UILabel *name;
/// The job Title of the staff's member
@property (weak, nonatomic) IBOutlet UILabel *jobTitle;
/// The photo of the staff's member
@property (weak, nonatomic) IBOutlet UIImageView *photo;
/// The biography of the staff's member
@property (weak, nonatomic) IBOutlet UITextView *biography;

@end
