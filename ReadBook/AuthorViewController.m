//
//  AuthorViewController.m
//  ReadBook
//
//  Created by houshangyong on 13-4-27.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "AuthorViewController.h"
#import "JSON.h"
#import "CustomTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RecommendBookDetilViewController.h"
@interface AuthorViewController ()
@property (nonatomic ,retain) NSMutableArray * array;
@end

@implementation AuthorViewController
@synthesize string;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"同作者书籍";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor brownColor];
    NSLog(@"%@",string);
    UITableView * table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height- 20-44-60) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:table];
    [self request];
    [table release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark request motheds
- (void)request
{
    NSString * appkey  = @"df6df696f6339c461cccd5ca357c7172";//appkey
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.shupeng.com/rec/author?bookid=%@",string]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:appkey forHTTPHeaderField:@"User-Agent"];//用appk代替User-Agent

    NSData * data =   [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *_content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //json解析
    NSDictionary  * json = [_content JSONValue];
    [_content release];
    NSLog(@"%@",json);
    self.array = [json objectForKey:@"result"];
    //如果array为空就没有相关作者书籍
    if ([self.array count] == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"没有同作者书籍" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    NSLog(@"%@",self.array);
}
#pragma mark
#pragma mark tableView dataSource delegate motheds
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell = @"cell";
    CustomTableViewCell * _cell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (_cell == nil) {
        _cell = [[[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell]autorelease];
        _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    _cell.boardNameLable.text = [[self.array objectAtIndex:indexPath.row]objectForKey:@"name"];
    _cell.boardIntroLable.text = [[self.array objectAtIndex:indexPath.row]objectForKey:@"author"];
    NSMutableString * str = [NSMutableString stringWithFormat:@"http://a.cdn123.net/img/r/%@",[[self.array objectAtIndex:indexPath.row]objectForKey:@"thumb"]];
    //    NSLog(@"%@",str);
    NSURL * url = [NSURL URLWithString:str];
    //异步加载图片
    [_cell.customImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Default.png"]];
    return _cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendBookDetilViewController * recommend = [[RecommendBookDetilViewController alloc]init];
    recommend.title = [[self.array objectAtIndex:indexPath.row]objectForKey:@"name"];//书名字
    recommend.bookid = [[self.array objectAtIndex:indexPath.row]objectForKey:@"id"];//书id
     NSMutableString * str = [NSMutableString stringWithFormat:@"http://a.cdn123.net/img/r/%@",[[self.array objectAtIndex:indexPath.row]objectForKey:@"thumb"]];//书图片地址
    recommend.str = str;
    [self.navigationController pushViewController:recommend animated:YES];
    recommend.label.text = [NSString stringWithFormat:@"作者:%@\n简介:无",[[self.array objectAtIndex:indexPath.row]objectForKey:@"author"]];
    [recommend release];
}
@end
