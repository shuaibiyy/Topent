//
//  SHScholarshipsDetailedViewController.m
//  Topent
//
//  Created by Shuaib Yunus on 15/02/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import "SHScholarshipsDetailedViewController.h"

@implementation SHScholarshipsDetailedViewController

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
    
    self.title = [_scholarship objectForKey:@"name"];
    
    _scholarshipTitle.text = [_scholarship objectForKey:@"name"];
    _scholarshipSummary.text = [_scholarship objectForKey:@"summary"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
