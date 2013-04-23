//
//  DownLoadReadViewController.h
//  ReadBook
//
//  Created by Ibokan on 13-4-18.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownLoadReadViewController : UIViewController <UITextViewDelegate>
{
    //下载进度
    UIProgressView * _progressView;
    //显示下载百分比
    UILabel * _progressLabel;
    //菊花
    UIActivityIndicatorView * _progressActive;
}
//下载地址
@property (nonatomic , retain) NSString * downUrlString;
//下载内容大小
@property (nonatomic ,retain) NSNumber *str;
@property (nonatomic ,retain) NSString * imageString;

@end
