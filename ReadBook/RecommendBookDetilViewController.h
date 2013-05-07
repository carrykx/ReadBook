//
//  RecommendBookDetilViewController.h
//  ReadBook
//
//  Created by houshangyong on 13-4-17.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendBookDetilViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
//书网址
@property (nonatomic ,retain)NSString * _urlString;
//书id
@property (nonatomic ,retain)NSString *bookid;
//存放书
@property (nonatomic ,retain)NSMutableArray * arrayTxt;
@property (nonatomic ,retain)NSMutableArray *arrayAra;
//作者以及简介
@property (nonatomic ,retain)UITextView * label;
//图片字符串
@property (nonatomic ,retain)NSMutableString  * str;
@property(nonatomic,retain)UIColor *color;
@property(nonatomic,retain)UIColor *textColor;
@end

