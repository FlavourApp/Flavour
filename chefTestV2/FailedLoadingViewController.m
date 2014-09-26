//
//  FailedLoadingViewController.m
//  chefTestV2
//
//  Created by Demian Schkolnik on 9/26/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "FailedLoadingViewController.h"

@interface FailedLoadingViewController ()

@end

@implementation FailedLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)handleRetryButton:(id)sender {
    [self performSegueWithIdentifier:@"retryLoading" sender:self];
}

@end
