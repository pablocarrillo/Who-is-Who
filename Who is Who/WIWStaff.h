//
//  WIWStaff.h
//  Who is Who
//
//  Created by Pablo Isidoro Carrillo Alvarez on 05/01/2014.
//  Copyright (c) 2014 Pablo Isidoro Carrillo Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WIWStaff : NSObject

/// the name of the staff member
@property (strong, nonatomic) NSString* name;
/// the job title of the staff member
@property (strong, nonatomic) NSString* jobTitle;
/// the biography of the staff member
@property (strong, nonatomic) NSString* biography;
/// the url of the staff member's image
@property (strong, nonatomic) NSString* photoURL;

@end
