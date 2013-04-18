//
//  OneBoardListViewController.m
//  ReadBook
//
//  Created by carry on 13-4-17.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "OneBoardListViewController.h"
#import "CustomTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RecommendBookDetilViewController.h"

@interface OneBoardListViewController ()

@property (retain, nonatomic) UITableView *oneBoardListTable;
@property (retain, nonatomic) NSMutableData *oneBoardListData;
@property (retain, nonatomic) NSMutableArray *booklist;

@end

@implementation OneBoardListViewController

- (void)dealloc
{
    [_boardname release];
    [_intro release];
    [_booklist release];
    [_oneBoardListData release];
    [_boardid release];
    [_oneBoardListTable release];
    [super dealloc];
}

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
    self.navigationItem.title = self.boardname;
    [self creatTableView];
    [self netRequestData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 创建TableView
- (void)creatTableView
{
    self.oneBoardListTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - 90) style:UITableViewStylePlain];
    [self.view addSubview:self.oneBoardListTable];
    self.oneBoardListTable.delegate = self;
    self.oneBoardListTable.dataSource = self;
    self.oneBoardListTable.backgroundColor = [UIColor brownColor];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.f, 125.0f)];
//    tableHeaderView.backgroundColor
    UIImageView *headerbackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BookShelfCell.png"]];
    headerbackground.frame = CGRectMake(0.0f, 0.0f, 320.f, 125.0f);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f, 20.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = @"专辑介绍";
    [headerbackground addSubview:label];
    
    UILabel *intro = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 45.0f, 280.0f, 60.0f)];
    intro.backgroundColor = [UIColor clearColor];
    intro.font = [UIFont boldSystemFontOfSize:12];
    intro.textColor = [UIColor darkGrayColor];
    intro.numberOfLines = 0;
    intro.text = [NSString stringWithFormat:@"     %@",self.intro];
    [headerbackground addSubview:intro];
    
    [tableHeaderView addSubview:headerbackground];
    self.oneBoardListTable.tableHeaderView = tableHeaderView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.booklist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"oneBoard";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    NSString *url = [NSString stringWithFormat:@"http://a.cdn123.net/img/r/%@",[[self.booklist objectAtIndex:indexPath.row] objectForKey:@"thumb"]];
    [cell.customImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
    
    cell.boardNameLable.text = [[self.booklist objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.boardNameLable.font = [UIFont boldSystemFontOfSize:14];
    
    NSString *intro = [NSString stringWithFormat:@"作者:%@ \n简介:%@",[[self.booklist objectAtIndex:indexPath.row] objectForKey:@"author"],[[self.booklist objectAtIndex:indexPath.row] objectForKey:@"intro"]];
    cell.boardIntroLable.text = intro;
    cell.boardIntroLable.font = [UIFont systemFontOfSize:12];
    cell.boardIntroLable.textColor = [UIColor darkGrayColor];
    cell.boardIntroLable.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

#pragma mark -
#pragma mark - netRquestData

// 网络数据请求
- (void)netRequestData
{
    NSString *appkey = @"46e2849ff2129d6f7379e8ca0ee3a3a9";
    NSString *url = [NSString stringWithFormat:@"http://api.shupeng.com/board?boardid=%@",self.boardid];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setValue:appkey forHTTPHeaderField:@"User-Agent"];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.oneBoardListData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.oneBoardListData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    NSString *str = [[NSString alloc] initWithData:self.oneBoardListData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str);
//    [str release];
    NSDictionary *boardDic = [NSJSONSerialization JSONObjectWithData:self.oneBoardListData options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *result = [boardDic objectForKey:@"result"];
    
    self.booklist = [result objectForKey:@"booklist"];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RecommendBookDetilViewController *detil = [[RecommendBookDetilViewController alloc] init];
    NSString *urlstring = [NSString stringWithFormat:@"http://www.shupeng.com/book/%@",[[self.booklist objectAtIndex:indexPath.row] objectForKey:@"id"]];
    detil._urlString = urlstring;
    [self.navigationController pushViewController:detil animated:YES];
    [detil release];
}

@end










