//
//  RecommendBookDetilViewController.m
//  ReadBook
//
//  Created by houshangyong on 13-4-17.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "RecommendBookDetilViewController.h"
#import "Book.h"
#import "UIImageView+WebCache.h"
#import "JSON.h"
#import "ReadBookViewController.h"
#import "DownLoadReadViewController.h"
@interface RecommendBookDetilViewController ()
{
    UITableView * tableV;
    NSString * readUrl;
    ReadBookViewController * _readBook;
}
@end

@implementation RecommendBookDetilViewController
@synthesize _urlString;
@synthesize bookid;
@synthesize arrayAra;
@synthesize arrayTxt,label,str;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.arrayAra = [[NSMutableArray alloc]init];
         _readBook = [[ReadBookViewController alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor brownColor];
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 138)];
 
    NSURL *url = [NSURL URLWithString:self.str];
    [imageV setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Default.png"]];
    [self.view addSubview:imageV];
    [imageV release];
  label = [[UITextView alloc]initWithFrame:CGRectMake(125, 10, 182, 138)];
    label.font = [UIFont systemFontOfSize:15.0];
    label.autoresizingMask = YES;
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    //在线阅读
        UIButton *readButton = [UIButton buttonWithType:UIButtonTypeCustom];
    readButton.frame = CGRectMake(10, 170, 100, 30);
    readButton.backgroundColor = [UIColor redColor];
    [readButton setTitle:@"马上阅读" forState:UIControlStateNormal];
    [readButton addTarget:self action:@selector(_read) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:readButton];
    //下载阅读
    UIButton * downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadButton.frame = CGRectMake(10, 230, 100, 30);
    [downloadButton setTitle:@"下载阅读" forState:UIControlStateNormal];
    [downloadButton addTarget:self action:@selector(_down) forControlEvents:UIControlEventTouchUpInside];
    downloadButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:downloadButton];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(125, 150, 182, 210) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = [UIColor clearColor];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)_down
{
    [self.view addSubview:tableV];
     [self _request:[NSString stringWithFormat:@"%@",bookid]];
    [tableV reloadData];
}
//根据书的id获取书的详情
- (void)_request:(NSString *)str1
{
    NSString * strin  = @"df6df696f6339c461cccd5ca357c7172";
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.shupeng.com/book?id=%@",str1]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:strin forHTTPHeaderField:@"User-Agent"];
    
    NSData * data =   [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *_content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //json解析
 NSDictionary  * json = [_content JSONValue];
    NSLog(@"_+_+_+_+_+__+_+_+_+_+_++_+_+_+_+%@",json);
   self.arrayAra = [[[json objectForKey:@"result"]objectForKey:@"links"]objectForKey:@"rar"];
   self.arrayTxt = [[[json objectForKey:@"result"]objectForKey:@"links"]objectForKey:@"txt"];
   readUrl =  [[NSString alloc]initWithFormat:@"%@",[[json objectForKey:@"result"]objectForKey:@"read_url"]];
    _readBook.title = [[json objectForKey:@"result"]objectForKey:@"name"];
    _readBook._readUrl = readUrl;
     NSLog(@"%@",readUrl);
     NSLog(@"%@",_readBook._readUrl);
}
#pragma mark
#pragma mark datasource deledate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.arrayAra count];
    }
    else{
        return [self.arrayTxt count];
    }
  }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString * cell = @"downloadList";
    UITableViewCell * _cell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (_cell == nil) {
        _cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell]autorelease];
        _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0) {
        _cell.textLabel.text = [NSString stringWithFormat:@"格式:%@",[[self.arrayAra objectAtIndex:indexPath.row]objectForKey:@"format"]];
        _cell.detailTextLabel.text = [[self.arrayAra objectAtIndex:indexPath.row]objectForKey:@"size"];
    }
    else{
     _cell.textLabel.text = [NSString stringWithFormat:@"格式:%@",[[self.arrayTxt objectAtIndex:indexPath.row]objectForKey:@"format"]];
    _cell.detailTextLabel.text = [[self.arrayTxt objectAtIndex:indexPath.row]objectForKey:@"size"];
    }
    return _cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return @"rar格式";
        
    }
    else{
        return @"txt格式";
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     DownLoadReadViewController * _downBook = [[DownLoadReadViewController alloc]init];
    if (indexPath.section == 0) {
       
        _downBook.downUrlString = [[self.arrayAra objectAtIndex:indexPath.row]objectForKey:@"url"];
        [self.navigationController pushViewController:_downBook animated:YES];
    }
    else{
       
        _downBook.downUrlString = [[self.arrayTxt objectAtIndex:indexPath.row]objectForKey:@"url"];
        [self.navigationController pushViewController:_downBook animated:YES];
    }
    
    [_downBook release],_downBook = nil;
}
//在线阅读
- (void)_read
{
    //read_url
    
    [self _request:[NSString stringWithFormat:@"%@",bookid]];

    
    NSLog(@"00000000%@",readUrl);
    [self.navigationController pushViewController:_readBook animated:YES];
    [_readBook release], _readBook = nil;
}
- (void)dealloc
{
    [tableV release];
    [label release];
    [super dealloc];
}
@end
