//
//  OneBoardListViewController.h
//  ReadBook
//
//  Created by carry on 13-4-17.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneBoardListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>

@property (retain, nonatomic) NSString *boardid;
@property (retain, nonatomic) NSString *boardname;
@property (retain, nonatomic) NSString *intro;

@end
