//
//  DownLoadReadViewController.h
//  ReadBook
//
//  Created by Ibokan on 13-4-18.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownLoadReadViewController : UIViewController <UIWebViewDelegate>
{
    UIProgressView * _progressView;
    UILabel * _progressLabel;
    UIActivityIndicatorView * _progressActive;
}
//下载地址
@property (nonatomic , retain) NSString * downUrlString;
@end
