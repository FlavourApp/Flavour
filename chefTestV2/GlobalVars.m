//
//  GlobalVars.m
//  chefTestV2
//
//  Created by Demian Schkolnik on 9/27/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "GlobalVars.h"

@implementation GlobalVars

@synthesize chefs = _chefs;
@synthesize userID = _userID;

+ (GlobalVars *)sharedInstance {
    static dispatch_once_t onceToken;
    static GlobalVars *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalVars alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _chefs = [[NSDictionary alloc] init];
        // Note these aren't allocated as [[NSString alloc] init] doesn't provide a useful object
        _userID = nil;
    }
    return self;
}
@end
