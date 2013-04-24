//
//  ReadNativeBookViewController.h
//  ReadBook
//
//  Created by carry on 13-4-19.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadNativeBookViewController : UIViewController<UIGestureRecognizerDelegate>

@property (retain, nonatomic) NSString *strAll;     // 传进来的字符串,也就是书的所有内容

@end
