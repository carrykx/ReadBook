//
//  Book.h
//  ReadBook
//
//  Created by houshangyong on 13-4-17.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSNumber * iD;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * thumb;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * intro;
@property (nonatomic, retain) NSString * nick;

@end
