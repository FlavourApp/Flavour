//
//  LoginViewController.h
//  chefTestV2
//
//  Created by Demian Schkolnik on 9/15/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <GooglePlus/GooglePlus.h>
#import "TableViewController.h"
#import "GlobalVars.h"

@interface LoginViewController : UIViewController <FBLoginViewDelegate, GPPSignInDelegate>

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;

@end

@class GPPSignInButton;
