//
//  ReadBookViewController.m
//  ReadBook
//
//  Created by houshangyong on 13-4-17.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "ReadBookViewController.h"

@interface ReadBookViewController ()

@end

@implementation ReadBookViewController
@synthesize _readUrl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//document.URL
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    UIWebView * _webRead = [[UIWebView alloc]initWithFrame:CGRectMake(0, -80, 320, 450)];
    _webRead.scalesPageToFit = YES;
    [_webRead loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_readUrl]]];
    [self.view addSubview:_webRead];
    NSLog(@"ffff%@",self._readUrl);
    //获取当前网页标题
    self.title = [_webRead stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",[_webRead stringByEvaluatingJavaScriptFromString:@"document.title"]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
