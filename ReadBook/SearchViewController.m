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
#import "JSON.h"
@interface SearchViewController ()
@property(nonatomic,retain)NSMutableArray *beforeArray;
@property(nonatomic,retain)NSMutableArray *Firstarray;
@property(nonatomic,retain)UISearchBar *searchBar;

-(void)getRequeset:(NSString*) searchText;
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
    //创建搜索栏
    UISearchBar *searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0,40.0)];
    searchbar.placeholder = @"请输入你想找的书籍名称";
    searchbar.delegate =self;
    searchbar.tintColor = [UIColor brownColor];
    self.searchBar = searchbar;
    [searchbar release];
    //通过网络请求获取热门搜索词相关信息
    NSString *urlStr=[NSString stringWithFormat:@"http://api.shupeng.com/hotword?p=1&psize=10"];
    NSString *appkey = @"df6df696f6339c461cccd5ca357c7172";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setValue:appkey forHTTPHeaderField:@"User-Agent"];
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
    
   //将数据转化成json数据存放再字典里
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    //将获取的热门搜索书籍相关数据存放到数组里
    self.beforeArray = [[dic objectForKey:@"result"]objectForKey:@"list"];
    [self.tableView reloadData];

}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
//seachbar键盘search键点击根据输入关键字获取网络信息并将试图切换到搜索结果显示界面
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self getRequeset:self.searchBar.text];
    //按搜索键时关闭键盘
    [searchBar resignFirstResponder];
    SelectResultsViewController *secondView = [[SelectResultsViewController alloc]initWithStyle:UITableViewStylePlain];
    secondView.FIRSTArray = self.Firstarray;

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
    
    
    return [self.beforeArray count];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indentifier=@"beforecell";
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier]autorelease];
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.text = [[self.beforeArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
    
}
//将选择的热门关键词传递给searchBar.text并显示出来，打开searchBar键盘
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.searchBar.text = [[self.beforeArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    NSLog(@"%@",self.searchBar.text);
    [self.searchBar becomeFirstResponder];
}
//将搜索栏和热门搜索词标题添加到SectionHeaderView中，始终显示给用户
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 70.0)];
    sectionView.backgroundColor = [UIColor brownColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100.0, 40.0, 120.0,30.0)];
    label.text = @"热门搜索词";
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor yellowColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:20];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 70.0, 320.0, 1.0)];
    label1.backgroundColor = [UIColor underPageBackgroundColor];
    [sectionView addSubview:label];
    [sectionView addSubview:label1];
    [label release];
    [label1 release];
    [sectionView addSubview:self.searchBar];
    return [sectionView autorelease];;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 71.0;
}
//通过点击search键获取的网络请求
-(void)getRequeset:(NSString*)searchText
{
    NSString *urlStr=[NSString stringWithFormat:@"http://api.shupeng.com/search?q=%@&p=1&psize=10",[self.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *appkey = @"df6df696f6339c461cccd5ca357c7172";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setValue:appkey forHTTPHeaderField:@"User-Agent"];
   
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *stringValue = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSDictionary *dic =[stringValue JSONValue];
        
    self.Firstarray = [[dic objectForKey:@"result" ] objectForKey:@"matches"];
}
   



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
