//
//  SHScholarship.h
//  Topent
//
//  Created by Shuaib Yunus on 11/02/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SHScholarshipSection;

@interface SHScholarship : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * end;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * start;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSSet *sections;
@end

@interface SHScholarship (CoreDataGeneratedAccessors)

- (void)addSectionsObject:(SHScholarshipSection *)value;
- (void)removeSectionsObject:(SHScholarshipSection *)value;
- (void)addSections:(NSSet *)values;
- (void)removeSections:(NSSet *)values;

@end
