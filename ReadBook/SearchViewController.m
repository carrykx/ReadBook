//
//  SearchViewController.m
//  ReadBook
//
//  Created by carry on 13-4-15.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "SearchViewController.h"
#import "ReadBookViewController.h"
#import "SelectResultsViewController.h"
@interface SearchViewController ()
@property(nonatomic,retain)NSMutableArray *beforeArray;
@property(nonatomic,retain)NSMutableArray *Firstarray;
@property(nonatomic,retain)UISearchBar *searchBar;
-(void)getRequeset:(NSString*)searchText p:(NSInteger) p psize:(NSInteger)psize;
@end

@implementation SearchViewController
-(void)dealloc{
    [_searchBar release];
    [_Firstarray release];
    [_beforeArray release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableView.backgroundColor = [UIColor brownColor];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //在TableView HeaderView中添加SearchBar
    [super viewDidLoad];
    self.navigationItem.title = @"书籍搜索";
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.backBarButtonItem = backbutton;
    [backbutton release];
    UISearchBar *searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0,50.0)];
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 60.0)];
    searchbar.placeholder = @"请输入你想找的书籍名称";
    searchbar.delegate =self;
    searchbar.tintColor = [UIColor brownColor];
    
    self.searchBar = searchbar;
    [headerView addSubview:searchbar];
    [searchbar release];
    self.tableView.tableHeaderView = headerView;
    [headerView release];
    //通过网络请求获取热门搜索词相关信息
    NSString *urlStr=[NSString stringWithFormat:@"http://api.shupeng.com/hotword?p=1&psize=10"];
    NSString *appkey = @"79d44eca5e871396bafa661b211400a6";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setValue:appkey forHTTPHeaderField:@"User-Agent"];
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
    //    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    //    NSLog(@"%@",[[NSString  alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    //将获取的热门搜索书籍相关数据存放到数组里
    self.beforeArray = [[dic objectForKey:@"result"]objectForKey:@"list"];
    //    NSLog(@"%@",[[self.beforeArray objectAtIndex:0]objectForKey:@"name"]);
    [self.tableView reloadData];

}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
//seachbar键盘search键点击根据输入关键字获取网络信息
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //[self.Firstarray removeAllObjects];
    [self getRequeset:self.searchBar.text p:1 psize:10];
    
    [searchBar resignFirstResponder];
    SelectResultsViewController *secondView = [[SelectResultsViewController alloc]initWithStyle:UITableViewStylePlain];
    secondView.FIRSTArray = self.Firstarray;
    NSLog(@"%@",self.Firstarray);
    [self.navigationController pushViewController:secondView animated:YES];
    [secondView release],secondView = nil;
}
//searchbar删除按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    //判断是否时当前单元格，是显示当前获取热门搜索词的数据，不是则显示通过搜索获取的数据
    
    return [self.beforeArray count];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //通过判断设置单元格高度
    
    return 40.0;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indentifier=@"beforecell";
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier]autorelease];
    }
    cell.textLabel.text = [[self.beforeArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.searchBar.text = [[self.beforeArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    NSLog(@"%@",self.searchBar.text);
    [self.searchBar becomeFirstResponder];
}

-(void)getRequeset:(NSString*)searchText p:(NSInteger)p psize:(NSInteger)psize;
{
    NSString *urlStr=[NSString stringWithFormat:@"http://api.shupeng.com/search?q=%@&p=%d&psize=%d",[self.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],p,psize];
    NSString *appkey = @"79d44eca5e871396bafa661b211400a6";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setValue:appkey forHTTPHeaderField:@"User-Agent"];
   
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *re, NSData *responseData, NSError *error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
        
        self.Firstarray = [[dic objectForKey:@"result" ] objectForKey:@"matches"];
    }];
   
    
   
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
