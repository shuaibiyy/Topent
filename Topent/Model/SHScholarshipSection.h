//
//  SHScholarshipSection.h
//  Topent
//
//  Created by Shuaib Yunus on 11/02/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SHScholarship;

@interface SHScholarshipSection : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) SHScholarship *scholarship;

@end
