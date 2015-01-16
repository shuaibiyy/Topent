//
//  SHAppDelegate.h
//  Topent
//
//  Created by Shuaib Yunus on 11/01/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SHAppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;
@property(atomic) BOOL isScholarshipSubscriber;

@end
