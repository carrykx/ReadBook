//
//  bookSave.h
//  ReadBook
//
//  Created by Ibokan on 13-4-18.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bookSave : NSObject<NSCoding>
{
    NSString * name;
    NSString *urlString;
}
@property (nonatomic , retain) NSString * name;
@property (nonatomic , retain) NSString *urlString;
@end
