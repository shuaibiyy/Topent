//
//  SHInternshipsDetailedViewController.h
//  Topent
//
//  Created by Shuaib Yunus on 22/03/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SHInternshipsDetailedViewController : UIViewController

@property (strong, nonatomic) PFObject *internship;

@property (weak, nonatomic) IBOutlet UILabel *companyName;

@property (weak, nonatomic) IBOutlet UILabel *position;

@end
