//
//  WIWConnections.m
//  Who is Who
//
//  Created by Pablo Isidoro Carrillo Alvarez on 05/01/2014.
//  Copyright (c) 2014 Pablo Isidoro Carrillo Alvarez. All rights reserved.
//

#import "WIWConnections.h"
#import "WIWWebToStaff.h"
#import "WIWStaff.h"


static WIWConnections *_singleton;

@implementation WIWConnections

#pragma mark - Singleton
+(WIWConnections *)sharedInstance{
    if (!_singleton)
        _singleton = [[self alloc] init];
    return _singleton;
}

-(id)init{
    self = [super init];
    if (!self)  return nil;
    [self configureManager];
    return self;
}

/*!
 *\brief Configure the manager
 * This method configure the response serializer to adccept text/html and use \c AFXMLParserResponseSerialiezer instead of \c AFJSONResponseSerializer
 *\return void
*/
-(void)configureManager{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer=[AFXMLParserResponseSerializer new];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/xml",@"text/xml",@"text/html"]];
   // NSLog(@"accepted content types: %@," ,self.manager.responseSerializer.acceptableContentTypes);
}
#pragma mark - Call to the server
-(void)connectToServerWithSuccessBlock:(void(^)(NSMutableArray* array))successBlock andErrorBlock:(void(^)(NSError* error))errorBlock{
   
    [self.manager GET:@"http://www.theappbusiness.com/our-team/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData* responseData=[operation responseData];

        successBlock([WIWWebToStaff loadStaffWithData:responseData]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        errorBlock(error);
    }];
}
@end
