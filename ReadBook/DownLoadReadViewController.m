//
//  DownLoadReadViewController.m
//  ReadBook
//
//  Created by Ibokan on 13-4-18.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "DownLoadReadViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ReadBook.h"
#import "MyBookViewController.h"

@interface DownLoadReadViewController ()
{
    NSTimer * _progressTimer;
    UIView * view;
    UILabel * label;
    ReadBook * read;
    UITextView * text;
    MyBookViewController * _myBook ;
        NSString * string;
//    NSInteger page;
}
@end

@implementation DownLoadReadViewController
@synthesize downUrlString;
@synthesize str;
@synthesize imageString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        page = 1;
         _myBook  = [[MyBookViewController alloc]init];
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    //进度条
       _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 45, 80, 1)];
    _progressView.backgroundColor = [UIColor blueColor];
    _progressView.progressTintColor = [UIColor purpleColor];
    //菊花
      _progressActive = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _progressActive.color = [UIColor whiteColor];
    view = [[UIView alloc]initWithFrame:CGRectMake(130, 130, 80, 80)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.8;
    view.layer.cornerRadius = 10;
    _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 40, 40)];
    _progressLabel.textColor = [UIColor whiteColor];
    _progressLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    [view addSubview:_progressLabel];
    [view addSubview:_progressActive];
    [view addSubview:_progressView];
    label = [[UILabel alloc]initWithFrame:CGRectMake(130, 130, 80, 80)];
    
    [_progressActive startAnimating];
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(_changeProgressValue) userInfo:nil repeats:YES];
    

    NSURL * url = [NSURL URLWithString:downUrlString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *rrr, NSData *data, NSError *ffff) {
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);

        string = [[NSString alloc]initWithData:data encoding:encoding];
             
        read  = [[ReadBook alloc]init];//readBook类实例化
        read.readBook = [NSString stringWithFormat:@"%@",string];//获取书内容
        read.image = self.imageString;//获取图片地址
        if (string == nil||[string hasSuffix:@"The service is unavailable"]) {
           
            return ;
            
        }
        else{
            //归档
            NSString * string1 = NSHomeDirectory();//获取沙盒目录
            NSString * filePath = [string1 stringByAppendingFormat:@"book.text"];//获取沙盒目录路径
            //反序列化
            _myBook.items = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:filePath]];
            [_myBook.items addObject:read];
          
            //序列化
            [NSKeyedArchiver archiveRootObject:_myBook.items toFile:filePath];
              [read release];
        }
    }];
   

}
//- (void)_next
//{
//    page = page + 1;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.1];
//    [text setContentOffset:CGPointMake(0, (page - 1) * 430) animated:YES];
//    [UIView commitAnimations];
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
//    [UIView commitAnimations];
//    
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_changeProgressValue
{
    float progressValue = _progressView.progress;
    //根据书内容计算进度
    progressValue+= [self.str floatValue]/100.0f ;
//    NSLog(@"%f",progressValue);
    if (progressValue > 1.0 )
    {
        progressValue = 0.0;
        [_progressTimer invalidate];//计时器停止
        [_progressActive stopAnimating];//菊花停止
        [view removeFromSuperview];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示:" message:@"下载成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
//    [NSTimer scheduledTimerWithTimeInterval:2.3f target:self selector:@selector(_change) userInfo:nil repeats:NO];
           }
    [_progressLabel setText:[NSString stringWithFormat:@"%.0f%%", progressValue *100.0 ]];
    [_progressView setProgress:progressValue];
}
- (void)_change
{
    if (string == nil||[string hasSuffix:@"The service is unavailable"]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示:" message:@"下载失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示:" message:@"下载成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }

}
#pragma mark UIAlertView delegate motheds
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 0) {
        MyBookViewController * myBook = [[MyBookViewController alloc]init];
        myBook.name = self.title;
        [self.navigationController pushViewController:myBook animated:YES];
        [myBook release];
    }
}
@end
