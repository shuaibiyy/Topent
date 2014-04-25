//
//  SHLoginViewController.m
//  Topent
//
//  Created by Shuaib Yunus on 26/01/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import "SHLoginViewController.h"
#import <Parse/Parse.h>

@interface SHLoginViewController ()

@end

@implementation SHLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // PFLogInViewController *login = [[PFLogInViewController alloc] init];
    // [self presentViewController:login animated:YES completion:nil];
    
    self.delegate = self;
    self.signUpController.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *) user {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleSignUp:(NSNumber *)result error:(NSError *)error {
    if (!error) {
        // Hooray! Let them use the app now.
    } else {
        NSString *errorString = [error userInfo][@"error"];
        NSLog(@"Error occurred while attempting to sign up: %@", errorString);
    }
}

- (void)signUpViewController:(PFLogInViewController *)signUpController didSignUpUser:(PFUser *) user {
    
//        user.username = @"my name";
//        user.password = @"my pass";
//        user.email = @"email@example.com";
        
//        [user signUpInBackgroundWithTarget:self
//                                  selector:@selector(handleSignUp:error:)];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signUpViewControllerDidCancelLogIn:(PFLogInViewController *)signUpController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (IBAction)signin:(UIButton *)sender {
//}
//
//- (IBAction)signup:(UIButton *)sender {
//}

@end
