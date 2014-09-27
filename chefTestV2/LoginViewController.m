//
//  LoginViewController.m
//  chefTestV2
//
//  Created by Demian Schkolnik on 9/15/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "LoginViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

static NSString * const kClientId = @"702054953699-80394k46m4g9i4eh4d78fd2pev4pmsha.apps.googleusercontent.com";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///////////////////
    //FACEBOOK BUTTON//
    //////////////////
    FBLoginView *loginView =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends"]];
    loginView.delegate = self;
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), self.view.center.y);
    [self.view addSubview:loginView];
    
    
    
    ///////////////
    //G+ BUTTON////
    //////////////
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    //signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    //signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    
    [signIn trySilentAuthentication];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////
//FACEBOOK METHODS//
///////////////////

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    GlobalVars *globals = [GlobalVars sharedInstance];
    globals.userID = user.objectID;
    NSLog(@"userId:%@",globals.userID);
    [self performSegueWithIdentifier:@"loginSuccess" sender:self];
    
}


//////////////////
//G+ METHODS//////
/////////////////

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
     [self performSegueWithIdentifier:@"loginSuccess" sender:self];
}

- (void)presentSignInViewController:(UIViewController *)viewController {
    // This is an example of how you can implement it if your app is navigation-based.
    [[self navigationController] pushViewController:viewController animated:YES];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"loginSuccess"]) {
        TableViewController *tableViewcontroller = [segue destinationViewController];
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
