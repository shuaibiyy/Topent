//
//  SHScholarshipsDetailedViewController.h
//  Topent
//
//  Created by Shuaib Yunus on 15/02/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SHScholarshipsDetailedViewController : UIViewController

@property (strong, nonatomic) PFObject *scholarship;

@property (weak, nonatomic) IBOutlet UILabel *scholarshipTitle;

@property (weak, nonatomic) IBOutlet UILabel *scholarshipSummary;

@end
