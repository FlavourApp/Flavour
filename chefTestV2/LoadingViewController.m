//
//  LoadingViewController.m
//  chefTestV2
//
//  Created by Demian Schkolnik on 9/22/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "LoadingViewController.h"
#import "TableViewController.h"

@interface LoadingViewController ()

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation LoadingViewController

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
    self.Title = [[NSMutableArray alloc] init];
    self.Description = [[NSMutableArray alloc] init];
    self.Images = [[NSMutableArray alloc] init];
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://192.168.1.42:8000/flavour/chefs"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"PREPARING SEGUE");
    
    if ([[segue identifier] isEqualToString:@"loadingSuccess"]) {
        UINavigationController *nav = segue.destinationViewController;
        TableViewController *tableViewController = (TableViewController *)nav.topViewController;
        tableViewController.Title = [NSMutableArray arrayWithArray: _Title];
        tableViewController.Description = [NSMutableArray arrayWithArray: _Description];
        tableViewController.Images = [NSMutableArray arrayWithArray:_Images];
    }
}


//Conection methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert from JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        NSString *keyAsString = (NSString *)key;
        
        if([keyAsString  isEqual: @"chefs"])
        {
            NSArray *chefArray = (NSArray *)value;
            
            for (NSDictionary *chef in chefArray) {
                NSString *name = [chef objectForKey:@"name"];
                NSString *lastname = [chef objectForKey:@"lastname"];
                NSString *fullName = [[name stringByAppendingString:@" "] stringByAppendingString:lastname];
                NSLog(@"%@",fullName);
                [self.Title addObject:fullName];
                NSLog(@"Title sizeA: %d", self.Title.count);
                
                [self.Description addObject:[chef objectForKey:@"description"]];
                NSLog(@"%@",[chef objectForKey:@"description"]);
                [self.Images addObject:[chef objectForKey:@"pictureUrl"]];
                NSLog(@"%@",[chef objectForKey:@"pictureUrl"]);
                
            }
        }
        //NSLog(@"value: %@", valueAsArray);
    }
    
    // extract specific value...
    //NSArray *results = [res objectForKey:@"results"];
    /*
     for (NSDictionary *result in results) {
     NSString *icon = [result objectForKey:@"icon"];
     NSLog(@"icon: %@", icon);
     }
     */
    [self performSegueWithIdentifier:@"loadingSuccess" sender:self];
}

@end
