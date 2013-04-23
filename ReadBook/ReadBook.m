//
//  ReadBook.m
//  ReadBook
//
//  Created by Ibokan on 13-4-22.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "ReadBook.h"

@implementation ReadBook
@synthesize readBook,image;
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:readBook forKey:@"readBook"];
    
    [aCoder encodeObject:image forKey:@"image"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.readBook = [aDecoder decodeObjectForKey:@"readBook"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}
@end
