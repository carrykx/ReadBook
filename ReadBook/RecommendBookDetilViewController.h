//
//  RecommendBookDetilViewController.h
//  ReadBook
//
//  Created by houshangyong on 13-4-17.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendBookDetilViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,retain)NSString * _urlString;
@property (nonatomic ,retain)NSString *bookid;
@property (nonatomic ,retain)NSMutableArray * arrayTxt;
@property (nonatomic ,retain)NSMutableArray *arrayAra;
@property (nonatomic ,retain)UITextView * label;
@property (nonatomic ,retain)NSMutableString  * str;
@end
