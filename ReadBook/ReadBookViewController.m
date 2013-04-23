//
//  ReadBookViewController.m
//  ReadBook
//
//  Created by houshangyong on 13-4-17.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "ReadBookViewController.h"
#import "SaveBookMarkViewController.h"
@interface ReadBookViewController ()
{
    UIWebView * _webRead;
}
@end

@implementation ReadBookViewController
@synthesize _readUrl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(_bookmark)];
    }
    return self;
}
//document.URL
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

     _webRead = [[UIWebView alloc]initWithFrame:CGRectMake(0, -100, 320, 470)];
    _webRead.scalesPageToFit = YES;
    [_webRead loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_readUrl]]];
    [self.view addSubview:_webRead];
    NSLog(@"ffff%@",self._readUrl);
    //获取当前网页标题
//    self.title = [_webRead stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",[_webRead stringByEvaluatingJavaScriptFromString:@"document.title"]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)_bookmark
{
//    NSString * bookmark = 
    UIActionSheet * sheetBookmark = [[UIActionSheet alloc]initWithTitle:@"添加书签" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"add BookMark", nil];
    [sheetBookmark showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    
    if (buttonIndex == 0) {
        SaveBookMarkViewController * saveBookMark = [[SaveBookMarkViewController alloc]init];
        saveBookMark.nameString = self.title;
        saveBookMark.urlString = [_webRead stringByEvaluatingJavaScriptFromString:@"document.URL"];
        [self.navigationController pushViewController:saveBookMark animated:YES];
        [saveBookMark release], saveBookMark = nil;
    }
    else
    {
        return;
    }
    
}
@end
