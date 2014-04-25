//
//  SHEventsDetailedViewController.m
//  Topent
//
//  Created by Shuaib Yunus on 22/03/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import "SHEventsDetailedViewController.h"

@interface SHEventsDetailedViewController ()

@end

@implementation SHEventsDetailedViewController

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
    
    self.title = [_event objectForKey:@"name"];
    
    _eventName.text = [_event objectForKey:@"name"];
    _eventDescription.text = [_event objectForKey:@"summary"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
