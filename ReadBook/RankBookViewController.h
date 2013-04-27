//
//  RankBookViewController.h
//  ReadBook
//
//  Created by houshangyong on 13-4-27.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankBookViewController : UIViewController <UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic , retain) NSString * bookId;
@property (nonatomic , retain) NSString * rankType;
@end
