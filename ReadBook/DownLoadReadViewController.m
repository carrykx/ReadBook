//
//  DownLoadReadViewController.m
//  ReadBook
//
//  Created by Ibokan on 13-4-18.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "DownLoadReadViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface DownLoadReadViewController ()
{
    UIWebView *_downWebView;
    NSTimer * _progressTimer;
    UIView * view;
    UILabel * label;
}
@end

@implementation DownLoadReadViewController
@synthesize downUrlString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 45, 80, 1)];
    _progressView.backgroundColor = [UIColor blueColor];
    _progressView.progressTintColor = [UIColor purpleColor];
    
  
//    _downWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 380)];
//    _downWebView.delegate = self;
//    [_downWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:downUrlString]]];
//    NSLog(@"ddd%@",downUrlString);
//    [self.view addSubview:_downWebView];
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
        NSString * string = [[NSString alloc]initWithData:data encoding:NSUTF32LittleEndianStringEncoding];
        NSLog(@"%@",string);
    }];
   

}
- (void)_request
{
    
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark webView delegate motheds
- (void)webViewDidStartLoad:(UIWebView *)webView
{
   
   }
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    float progressValue = _progressView.progress;
//    progressValue = 0.0;
//    [_progressTimer invalidate];
//    [_progressActive stopAnimating];
//    [view removeFromSuperview];
//}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
- (void)_changeProgressValue
{
    float progressValue = _progressView.progress;
    
    progressValue       += 0.01f;
    if (progressValue > 1.0)
    {
       
        progressValue = 0.0;
        [_progressTimer invalidate];
        [_progressActive stopAnimating];
        [view removeFromSuperview];
              

    }
     [_progressLabel setText:[NSString stringWithFormat:@"%.0f%%", (progressValue * 100)]];
    [_progressView setProgress:progressValue];

}
@end
