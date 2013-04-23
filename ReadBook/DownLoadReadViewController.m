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
@interface DownLoadReadViewController ()
{
    NSTimer * _progressTimer;
    UIView * view;
    UILabel * label;
    ReadBook * read;
    UITextView * text;
    int i;
    NSInteger page;
}
@end

@implementation DownLoadReadViewController
@synthesize downUrlString;
@synthesize str;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         i = 1;
        page = 1;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonSystemItemAction target:self action:@selector(_next)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    text = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 350)];
    
    text.font = [UIFont systemFontOfSize:10.0];
    text.autoresizingMask = YES;
    text.editable = NO;
    text.pagingEnabled = YES;
    text.scrollEnabled = NO;
    [self.view addSubview:text];
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 45, 80, 1)];
    _progressView.backgroundColor = [UIColor blueColor];
    _progressView.progressTintColor = [UIColor purpleColor];
    
  
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
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(_changeProgressValue) userInfo:nil repeats:YES];
    NSURL * url = [NSURL URLWithString:downUrlString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *rrr, NSData *data, NSError *ffff) {
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);

        NSString * string = [[NSString alloc]initWithData:data encoding:encoding];
          text.text = [NSString stringWithFormat:@"%@",string ];
        read  = [[[ReadBook alloc]init]autorelease];
        read.readBook = [NSString stringWithFormat:@"%@",string];
        NSLog(@"%@",string);
        NSString * string1 = NSHomeDirectory();
        NSString * filePath = [string1 stringByAppendingFormat:@"readbook.txt"];
        [NSKeyedArchiver archiveRootObject:read toFile:filePath];
    }];
   

}
- (void)_next
{
    page = page + 1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [text setContentOffset:CGPointMake(0, (page - 1) * 430) animated:YES];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    [UIView commitAnimations];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)_changeProgressValue
{
        float progressValue = _progressView.progress;
    
    progressValue       += [self.str floatValue]/1000.0f ;
    NSLog(@"%f",progressValue);
    if (progressValue > 1.0 )
    {
        
        progressValue = 0.0;
        [_progressTimer invalidate];
        [_progressActive stopAnimating];
        [view removeFromSuperview];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示:" message:@"下载成功" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"去我的书架", nil];
        [alert show];

        

    }
     [_progressLabel setText:[NSString stringWithFormat:@"%.0f%%", progressValue *100.0 ]];
    [_progressView setProgress:progressValue];

}
@end
