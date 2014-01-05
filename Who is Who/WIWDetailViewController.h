//
//  WIWDetailViewController.h
//  Who is Who
//
//  Created by Pablo Isidoro Carrillo Alvarez on 05/01/2014.
//  Copyright (c) 2014 Pablo Isidoro Carrillo Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WIWDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
