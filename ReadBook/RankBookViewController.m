//
//  RankBookViewController.m
//  ReadBook
//
//  Created by houshangyong on 13-4-27.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "RankBookViewController.h"
#import "JSON.h"
#import "CustomTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RecommendBookDetilViewController.h"
@interface RankBookViewController ()
@property (nonatomic , retain) NSMutableArray * array;
- (void)request;
@end

@implementation RankBookViewController
@synthesize bookId,rankType;
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
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor brownColor];
    //创建列表视图
    UITableView * table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height- 20-44-60) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:table];
    //请求网络根据BookId
    [self request];
    [table release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//网络获取
- (void)request
{
    NSString * appkey  = @"df6df696f6339c461cccd5ca357c7172";//appkey
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.shupeng.com/top?topid=%@",bookId]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:appkey forHTTPHeaderField:@"User-Agent"];//用appk代替User-Agent
    
    NSData * data =   [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *_content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //json解析
    NSDictionary  * json = [_content JSONValue];
    [_content release];
 
    self.array = [[json objectForKey:@"result"]objectForKey:@"booklist"];
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
    //获取名字
    _cell.boardNameLable.text = [[self.array objectAtIndex:indexPath.row]objectForKey:@"name"] ;
    //获取简介
    _cell.boardIntroLable.text = [[self.array objectAtIndex:indexPath.row]objectForKey:@"intro"];
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return rankType;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //push 去详情
    RecommendBookDetilViewController * recommend = [[RecommendBookDetilViewController alloc]init];
    
            recommend.title = [[self.array objectAtIndex:indexPath.row]objectForKey:@"name"];//书名字
        recommend.bookid = [[self.array objectAtIndex:indexPath.row]objectForKey:@"id"];//书id
        NSMutableString * str = [NSMutableString stringWithFormat:@"http://a.cdn123.net/img/r/%@",[[self.array objectAtIndex:indexPath.row]objectForKey:@"thumb"]];//书图片地址
        recommend.str = str;
        [self.navigationController pushViewController:recommend animated:YES];
        recommend.label.text = [NSString stringWithFormat:@"作者:%@\n简介:%@",[[self.array objectAtIndex:indexPath.row]objectForKey:@"author"],[[self.array objectAtIndex:indexPath.row]objectForKey:@"intro"]];
        
   
    [recommend release];

    
}

@end
