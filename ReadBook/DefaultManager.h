//
//  DefaultManager.h
//  ReadBook
//
//  Created by Ibokan on 13-4-16.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;

@interface DefaultManager : NSObject
//数据管理者
+ (DefaultManager*)defaultManager;
//获取一个book对象
- (Book*)book;
//获取book列表
- (NSMutableArray *)bookList;


@end
