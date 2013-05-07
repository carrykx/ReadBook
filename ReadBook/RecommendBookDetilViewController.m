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
#import "MyBookViewController.h"
#import "AuthorViewController.h"
#import "CategoryViewController.h"
@interface RecommendBookDetilViewController ()
{
    UITableView * tableV;
    NSString * readUrl;
    ReadBookViewController * _readBook;
    NSDictionary  * json ;
}
- (void)creatView;

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
      
         _readBook = [[ReadBookViewController alloc]init];
      
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"我的书架" style:UIBarButtonSystemItemAction target:self action:@selector(_readBookMark)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor brownColor];
    //创建view
    [self creatView];
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatView
{
    if (iPhone5) {
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
        readButton.frame = CGRectMake(10, 190, 100, 30);
        readButton.backgroundColor = [UIColor redColor];
        [readButton setTitle:@"马上阅读" forState:UIControlStateNormal];
        [readButton addTarget:self action:@selector(_read) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:readButton];
        //下载阅读
        UIButton * downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        downloadButton.frame = CGRectMake(10, 250, 100, 30);
        [downloadButton setTitle:@"下载阅读" forState:UIControlStateNormal];
        [downloadButton addTarget:self action:@selector(_down) forControlEvents:UIControlEventTouchUpInside];
        downloadButton.backgroundColor = [UIColor redColor];
        [self.view addSubview:downloadButton];
        //同作者
        UIButton * authorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        authorButton.frame = CGRectMake(10, 310, 100, 30);
        [authorButton setTitle:@"同作者" forState:UIControlStateNormal];
        [authorButton addTarget:self action:@selector(_author) forControlEvents:UIControlEventTouchUpInside];
        authorButton.backgroundColor = [UIColor redColor];
        [self.view addSubview:authorButton];
        //同类别
        UIButton * aboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aboutButton.frame = CGRectMake(10, 370, 100, 30);
        [aboutButton setTitle:@"同类别" forState:UIControlStateNormal];
        [aboutButton addTarget:self action:@selector(_about) forControlEvents:UIControlEventTouchUpInside];
        aboutButton.backgroundColor = [UIColor redColor];
        [self.view addSubview:aboutButton];
        tableV = [[UITableView alloc]initWithFrame:CGRectMake(125, 180, 182, 275) style:UITableViewStylePlain];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.backgroundColor = [UIColor clearColor];
        tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else{
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
        downloadButton.frame = CGRectMake(10, 210, 100, 30);
        [downloadButton setTitle:@"下载阅读" forState:UIControlStateNormal];
        [downloadButton addTarget:self action:@selector(_down) forControlEvents:UIControlEventTouchUpInside];
        downloadButton.backgroundColor = [UIColor redColor];
        [self.view addSubview:downloadButton];
        //同作者
        UIButton * authorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        authorButton.frame = CGRectMake(10, 250, 100, 30);
        [authorButton setTitle:@"同作者" forState:UIControlStateNormal];
        [authorButton addTarget:self action:@selector(_author) forControlEvents:UIControlEventTouchUpInside];
        authorButton.backgroundColor = [UIColor redColor];
        [self.view addSubview:authorButton];
        //同类别
        UIButton * aboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aboutButton.frame = CGRectMake(10, 290, 100, 30);
        [aboutButton setTitle:@"同类别" forState:UIControlStateNormal];
        [aboutButton addTarget:self action:@selector(_about) forControlEvents:UIControlEventTouchUpInside];
        aboutButton.backgroundColor = [UIColor redColor];
        [self.view addSubview:aboutButton];
        
        tableV = [[UITableView alloc]initWithFrame:CGRectMake(125, 150, 182, 210) style:UITableViewStylePlain];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.backgroundColor = [UIColor clearColor];
        tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
}
//下载
- (void)_down
{
    [self.view addSubview:tableV];
     [self _request:[NSString stringWithFormat:@"%@",bookid]];
    [tableV reloadData];
}
//同类别书籍
- (void)_about
{
       CategoryViewController * category = [[CategoryViewController alloc]init];
    category.string = bookid;//bookid
    [self.navigationController pushViewController:category animated:YES];
    [category release];
}
//同作者书籍
- (void)_author
{
       AuthorViewController * author = [[AuthorViewController alloc]init];
    author.string = bookid;//bookid
    [self.navigationController pushViewController:author animated:YES];
    [author release];
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
 json = [_content JSONValue];
    [_content release];
   self.arrayAra = [[[json objectForKey:@"result"]objectForKey:@"links"]objectForKey:@"rar"];//获取rar格式书
   self.arrayTxt = [[[json objectForKey:@"result"]objectForKey:@"links"]objectForKey:@"txt"];//获取txt格式书
    //如果两个数组都为空则不能下载阅读
    if ([self.arrayAra count]== 0 &&[self.arrayTxt count] == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"不能下载阅读" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];

    }
    //在线阅读地址
   readUrl =  [[NSString alloc]initWithFormat:@"%@",[[json objectForKey:@"result"]objectForKey:@"read_url"]];
    _readBook.title = [[json objectForKey:@"result"]objectForKey:@"name"];
    _readBook._readUrl = readUrl;
       
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
    //rar格式
    if (indexPath.section == 0) {
        _cell.textLabel.text = [NSString stringWithFormat:@"格式:%@",[[self.arrayAra objectAtIndex:indexPath.row]objectForKey:@"format"]];//获取书籍格式
        _cell.detailTextLabel.text = [[self.arrayAra objectAtIndex:indexPath.row]objectForKey:@"size"];//获取书籍大小
    }
    else{
        //text格式
     _cell.textLabel.text = [NSString stringWithFormat:@"格式:%@",[[self.arrayTxt objectAtIndex:indexPath.row]objectForKey:@"format"]];//获取书籍格式
    _cell.detailTextLabel.text = [[self.arrayTxt objectAtIndex:indexPath.row]objectForKey:@"size"];//获取书籍大小
    }
//
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     DownLoadReadViewController * _downBook = [[DownLoadReadViewController alloc]init];
    _downBook.imageString = self.str;

    if (indexPath.section == 0) {
       //ara 格式
        _downBook.downUrlString = [[self.arrayAra objectAtIndex:indexPath.row]objectForKey:@"url"]; //下载地址
         _downBook.str = [[self.arrayAra objectAtIndex:indexPath.row]objectForKey:@"size"]; //下载size
        [self.navigationController pushViewController:_downBook animated:YES];
    }
    else{
        //txt 格式  //下载地址
        _downBook.downUrlString = [[self.arrayTxt objectAtIndex:indexPath.row]objectForKey:@"url"];  //下载地址
        _downBook.str = [[self.arrayTxt objectAtIndex:indexPath.row]objectForKey:@"size"]; //下载size
        [self.navigationController pushViewController:_downBook animated:YES];
    }
    _downBook.title = self.title;//书名
    [_downBook release],_downBook = nil;
}
//在线阅读
- (void)_read
{
    //read_url
     [self _request:[NSString stringWithFormat:@"%@",bookid]];//网络请求
    //如果[json objectForKey:@"result"]objectForKey:@"online"] 为0不能在线阅读
    if ([[[json objectForKey:@"result"]objectForKey:@"online"] isEqual:@"0"]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"不能在线阅读" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    }
    //如果[json objectForKey:@"result"]objectForKey:@"online"] 为1能在线阅读
    else{
        [self.navigationController pushViewController:_readBook animated:YES];//push去在线阅读页面
    }

}
//去本地书架
- (void)_readBookMark
{
    MyBookViewController * _myBook = [[MyBookViewController alloc]init];
    _myBook.strrr = self.str;//书图片
    _myBook.textColor = self.textColor;
    _myBook.color = self.color;
    [self.navigationController pushViewController:_myBook animated:YES];//push去MyBookViewController
    [_myBook release];
   }

- (void)dealloc
{
    [readUrl release];
    [_readBook release], _readBook = nil;
    [tableV release];
    [label release];
    [super dealloc];
}
@end
