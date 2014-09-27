//
//  GlobalVars.h
//  chefTestV2
//
//  Created by Demian Schkolnik on 9/27/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVars : NSObject
{
    NSDictionary *_chefs;
    NSString *_userID;
}

+ (GlobalVars *)sharedInstance;

@property (strong, nonatomic, readwrite) NSDictionary *chefs;
@property(strong, nonatomic, readwrite) NSString *userID;

@end
