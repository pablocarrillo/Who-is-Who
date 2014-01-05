//
//  WIWWebToStaff.m
//  Who is Who
//
//  Created by Pablo Isidoro Carrillo Alvarez on 05/01/2014.
//  Copyright (c) 2014 Pablo Isidoro Carrillo Alvarez. All rights reserved.
//

#import "WIWWebToStaff.h"
#import "WIWStaff.h"
#import <hpple/TFHpple.h>

@implementation WIWWebToStaff

+(NSMutableArray*)loadStaffWithData:(NSData*) staffData{
    NSMutableArray* newMembers=[NSMutableArray new];
    TFHpple *staffParser = [TFHpple hppleWithHTMLData:staffData];
    NSString *staffXpathQueryString = @"//div[@class='col col2']";
    NSArray *staffNodes = [staffParser searchWithXPathQuery:staffXpathQueryString];
    for (TFHppleElement *element in staffNodes) {
        WIWStaff *member = [WIWStaff new];
        [newMembers addObject:member];
        
        for (TFHppleElement *child in element.children) {
            if ([child.tagName isEqualToString:@"div"]) {
                if ([[child.attributes valueForKey:@"class"] isEqualToString:@"title"]) {
                    for (TFHppleElement* grandchild in child.children) {
                        if ([grandchild.tagName isEqualToString:@"img"]) {
                              member.photoURL = [grandchild objectForKey:@"src"];
                        }
                    }
                }
            } else if ([child.tagName isEqualToString:@"h3"]) {
                member.name = [[child firstChild] content];
            }
            else if ([child.tagName isEqualToString:@"p"]) {
                if ([[child.attributes valueForKey:@"class"] isEqualToString:@"user-description"])
                    member.biography = [[child firstChild] content];
                else
                member.jobTitle = [[child firstChild] content];
            }
           
        }
        
    }
    return newMembers;
}

@end
