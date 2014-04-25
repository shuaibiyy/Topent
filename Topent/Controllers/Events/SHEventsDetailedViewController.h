//
//  SHEventsDetailedViewController.h
//  Topent
//
//  Created by Shuaib Yunus on 22/03/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SHEventsDetailedViewController : UIViewController

@property (strong, nonatomic) PFObject *event;

@property (weak, nonatomic) IBOutlet UILabel *eventName;

@property (weak, nonatomic) IBOutlet UILabel *eventDescription;

@end
