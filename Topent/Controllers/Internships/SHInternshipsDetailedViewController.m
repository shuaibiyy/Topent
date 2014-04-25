//
//  SHInternshipsDetailedViewController.m
//  Topent
//
//  Created by Shuaib Yunus on 22/03/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import "SHInternshipsDetailedViewController.h"

@implementation SHInternshipsDetailedViewController

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
    
    self.title = [_internship objectForKey:@"companyName"];
    
    _companyName.text = [_internship objectForKey:@"companyName"];
    _position.text = [_internship objectForKey:@"position"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end