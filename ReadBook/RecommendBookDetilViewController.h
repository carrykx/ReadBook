//
//  RecommendBookDetilViewController.h
//  ReadBook
//
//  Created by houshangyong on 13-4-17.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Book;
@interface RecommendBookDetilViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,retain)NSString * _urlString;
@property (nonatomic ,retain)Book *book;
@property (nonatomic ,retain)NSMutableArray * arrayTxt;
@property (nonatomic ,retain)NSMutableArray *arrayAra;
@end
