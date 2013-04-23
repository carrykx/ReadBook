//
//  SaveBookMarkViewController.h
//  ReadBook
//
//  Created by Ibokan on 13-4-18.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveBookMarkViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,retain)NSString * nameString;
@property (nonatomic ,retain)NSString * urlString;

@end
