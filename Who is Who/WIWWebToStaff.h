//
//  WIWWebToStaff.h
//  Who is Who
//
//  Created by Pablo Isidoro Carrillo Alvarez on 05/01/2014.
//  Copyright (c) 2014 Pablo Isidoro Carrillo Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WIWWebToStaff : NSObject
/*!
 *\brief this method return a \c NSMutableArray with the staff info from the data on HTML format
 *
 \param staffData a NSData element with the html from the web
 *\return A NSMutableArray filled with staff elements
*/
+(NSMutableArray*)loadStaffWithData:(NSData*) staffData;

@end
