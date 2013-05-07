//
//  MyBookViewController.h
//  ReadBook
//
//  Created by houshangyong on 13-4-20.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UControllerView.h"
@interface MyBookViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UIColor *color;
@property(nonatomic,retain)UIColor *textColor;

@property (nonatomic,retain) NSMutableArray * items;
@property (nonatomic ,retain) NSString * strrr;
@end
