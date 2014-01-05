//
//  WIWConnections.h
//  Who is Who
//
//  Created by Pablo Isidoro Carrillo Alvarez on 05/01/2014.
//  Copyright (c) 2014 Pablo Isidoro Carrillo Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface WIWConnections : NSObject
@property (nonatomic, strong) AFHTTPRequestOperationManager* manager;
/*! \brief the singleton
 * Class method to obatain the singleton
 * \return a shared instance of WIWConnections
 */
+(WIWConnections *)sharedInstance;
/*!
 *\brief Connect to the URL and load the web
 *
 \param successBlock block to be executed if the web is reachable and the mapping is a success
 \param errorBlock block to be executed if an error happen
 *\return void
*/
-(void)connectToServerWithSuccessBlock:(void(^)(NSMutableArray* array))successBlock andErrorBlock:(void(^)(NSError* error))errorBlock;
@end
