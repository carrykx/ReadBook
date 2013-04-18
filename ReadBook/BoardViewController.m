//
//  BoardViewController.m
//  ReadBook
//
//  Created by carry on 13-4-15.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "BoardViewController.h"
#import "OneBoardListViewController.h"
#import "CustomTableViewCell.h"

@interface BoardViewController ()

@property (retain, nonatomic) NSMutableData *boardData;
@property (retain, nonatomic) NSMutableArray *boardList;
@property (retain, nonatomic) NSTimer *time;
@property (retain, nonatomic) NSMutableArray *imageviews;

@end

@implementation BoardViewController

{
    UITableView *_tableView;
    UIView *_headerView;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    NSURLConnection *_connection;
}


- (void)dealloc
{
    [_imageviews release];
    [_time release];
    [_boardList release];
    [_boardData release];
    [_pageControl release];
    [_scrollView release];
    [_headerView release];
    [_tableView release];
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
     
   
    [self creatView];
    [self netRequestData];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark - creatView

- (void)creatView
{
    // 初始化所有要滚动的ImageView
    self.imageviews = [NSMutableArray arrayWithObjects:[[UIImageView alloc] init],[[UIImageView alloc] init],[[UIImageView alloc] init],[[UIImageView alloc] init],[[UIImageView alloc] init],[[UIImageView alloc] init],[[UIImageView alloc] init], nil];

    // 创建uitableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    // tableviewHeader
    _headerView = [[UIView alloc] init];
    _headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 115);
    
    // 创建要滚动的scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 115)];
    _scrollView.pagingEnabled = YES;
    
    UIImageView *imageFake1 = [self.imageviews objectAtIndex:5];
//    NSLog(@"%d",[self.imageviews count]);
    imageFake1.image = [UIImage imageNamed:@"jiazai.png"];
    imageFake1.frame = CGRectMake(320 * 6, 0, 320, 115);
    [_scrollView addSubview:imageFake1];
    
    UIImageView *imageFake5 = [self.imageviews objectAtIndex:6];
    imageFake5.image = [UIImage imageNamed:@"jiazai.png"];
    imageFake5.frame = CGRectMake(0, 0, 320, 115);
    [_scrollView addSubview:imageFake5];
    
    
    for (int i = 0 ; i < 5; i++) {
        UIImageView *imageView = [self.imageviews objectAtIndex:i];
        imageView.image = [UIImage imageNamed:@"jiazai.png"];
        imageView.frame = CGRectMake(320 * i + 320, 0, 320 , 115);
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(320 * 7, 115);
    [_headerView addSubview:_scrollView];
    [_scrollView scrollRectToVisible:CGRectMake(320, 0, 320, 115) animated:NO];
    
    [_scrollView release];
    _scrollView.delegate = self;
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(110, 80, 100, 28)];
    _pageControl.numberOfPages = 5;
    _pageControl.currentPage = 0;
    [_headerView addSubview:_pageControl];
    
    // 自动滚动图片时间
    if (self.time == nil) {
        self.time = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timer1) userInfo:nil repeats:YES];
    }
    
    _tableView.tableHeaderView = _headerView;
}

#pragma mark -
#pragma mark - tableviewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.boardList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"boardcell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.contentView.backgroundColor = [UIColor brownColor];
    NSString *str = [NSString stringWithFormat:@"%@(%@)",[[self.boardList objectAtIndex:indexPath.row] objectForKey:@"name"],[[self.boardList objectAtIndex:indexPath.row] objectForKey:@"count"]];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 50)];
//    label.font = [UIFont boldSystemFontOfSize:16];
//    label.backgroundColor = [UIColor clearColor];
//    label.text = str;
//    [cell.contentView addSubview:label];
//    [label release];
    
    cell.boardNameLable.text = str;
    cell.boardNameLable.backgroundColor = [UIColor clearColor];
    cell.boardIntroLable.backgroundColor = [UIColor clearColor];
    cell.customImageView.backgroundColor = [UIColor blackColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

// tableviewHeader的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}


- (void)timer1
{
    CGFloat imageViewX = _scrollView.contentOffset.x;
    int i = imageViewX  / 320 ;
    if (i == 6 ) {
        i = 1;
    }
    [_scrollView scrollRectToVisible:CGRectMake(i*320 +320, 0, 320, 140) animated:YES];
//    NSLog(@"%d",i);
}

// scrollview回调方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView)
    {
        CGFloat imageViewX = scrollView.contentOffset.x;
        int i = (imageViewX + 160) / 320 ;
        if (i == 0 || i == 5) {
            _pageControl.currentPage = 4;
        }else if (i == 1 || i == 5)
        {
            _pageControl.currentPage = 0;
        }else if (i == 2)
        {
            _pageControl.currentPage = 1;
        }else if (i == 3)
        {
            _pageControl.currentPage = 2;
        }else if (i == 4)
        {
            _pageControl.currentPage = 3;
        }
        //            NSLog(@"%f",imageViewX);
        if (imageViewX >= 320 * 6 ) {
            scrollView.contentOffset = CGPointMake(320, 0);
        }else if (imageViewX < 0)
        {
            scrollView.contentOffset = CGPointMake(320 * 5 , 0);
        }
    }
}

// 网络数据请求
- (void)netRequestData
{
    NSString *appkey = @"46e2849ff2129d6f7379e8ca0ee3a3a9";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.shupeng.com/board"]];
    [request setValue:appkey forHTTPHeaderField:@"User-Agent"];
    _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [_connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == _connection) {
        self.boardData = [NSMutableData data];

    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == _connection) {
        [self.boardData appendData:data];

    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == _connection) {
//        NSString *str = [[NSString alloc] initWithData:self.boardData encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",str);
//        NSString *str1 = @"http:\/\/a.cdn123.net\/img\/r\/5751f8e592f7aaac21f4e92fcab35dd5.jpeg";
//        NSLog(@"%@",str1);
//        [str release];
        
        NSDictionary *boardDic = [NSJSONSerialization JSONObjectWithData:self.boardData options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *result = [boardDic objectForKey:@"result"];

        self.boardList = [result objectForKey:@"boardlist"];
        
        for (int i = 0; i < 5; i++) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self loadingPrictureForUrl:[[self.boardList objectAtIndex:i] objectForKey:@"banner"] AtBoardListIndex:i];
                dispatch_async(dispatch_get_main_queue(), ^{
                });
            });
//            NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadingPrictureForUrl:) object:[[self.boardList objectAtIndex:i] objectForKey:@"banner"]];
//            [thread start];
//            [thread release];


        }


    }
    [_tableView reloadData];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)loadingPrictureForUrl:(NSString *)url AtBoardListIndex:(int)i
{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    if (i == 0)
    {
        UIImageView *imageview1 = [self.imageviews objectAtIndex:0];
        imageview1.image = image;
        UIImageView *imageview6 = [self.imageviews objectAtIndex:5];
        imageview6.image = image;

    }else if (i == 1)
    {
        UIImageView *imageview2 = [self.imageviews objectAtIndex:1];
        imageview2.image = image;
    }else if (i == 2)
    {
        UIImageView *imageview3 = [self.imageviews objectAtIndex:2];
        imageview3.image = image;
       
    }else if (i == 3)
    {
        UIImageView *imageview4 = [self.imageviews objectAtIndex:3];
        imageview4.image = image;
        
    }else if (i == 4)
    {
        UIImageView *imageview5 = [self.imageviews objectAtIndex:4];
        imageview5.image = image;
        UIImageView *imageview7 = [self.imageviews objectAtIndex:6];
        imageview7.image = image;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OneBoardListViewController *oneBoard = [[OneBoardListViewController alloc] init];
    oneBoard.boardid = [[self.boardList objectAtIndex:indexPath.row] objectForKey:@"id"];
    [self.navigationController pushViewController:oneBoard animated:YES];
    [oneBoard release];
}


@end











