//
//  bookSave.m
//  ReadBook
//
//  Created by Ibokan on 13-4-18.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "bookSave.h"

@implementation bookSave
@synthesize name;
@synthesize urlString;
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:urlString forKey:@"urlString"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
       self.name =  [aDecoder decodeObjectForKey:@"name"];
      self.urlString =  [aDecoder decodeObjectForKey:@"urlString"];
    }
    return self;
}
@end
