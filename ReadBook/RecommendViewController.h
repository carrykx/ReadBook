//
//  RecommendViewController.h
//  ReadBook
//
//  Created by carry on 13-4-15.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UControllerView.h"

@interface RecommendViewController : UIViewController<UWCollectionViewDataSource,UWCollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NSMutableArray * items;

@end
