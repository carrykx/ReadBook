//
//  SelectResultsViewController.m
//  ReadBook
//
//  Created by ibokan on 13-4-19.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "SelectResultsViewController.h"
#import "UIImageView+WebCache.h"
#import "RecommendBookDetilViewController.h"
#import "CustomTableViewCell.h"
@interface SelectResultsViewController ()

@end

@implementation SelectResultsViewController
@synthesize FIRSTArray = _FIRSTArray;
-(void)dealloc{
    [_FIRSTArray release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.backgroundColor = [UIColor brownColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationItem.title = @"搜索结果";
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.FIRSTArray count];
}
//通过自定义创建的表格将搜索到的数据显示出来
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier=@"selectresultcell";
    CustomTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:indentifier];
   if (!cell) {
        cell=[[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier]autorelease];
    }
    //通过name关键字从数据字典里获取搜索到的小说名字
    cell.boardNameLable.text = [[self.FIRSTArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    //通过提供的图片地址获取图片
    NSString *str = [[self.FIRSTArray objectAtIndex:indexPath.row]objectForKey:@"thumb"];
    NSURL *url = [NSString stringWithFormat:@"http://a.cdn123.net/img/r/%@",str];
    [cell.customImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Default.png"]];
    //获取作者信息
   
    cell.boardIntroLable.text = [[self.FIRSTArray objectAtIndex:indexPath.row]objectForKey:@"author"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//通过选择书籍跳转到书籍具体信息界面，包括阅读和下载功能
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendBookDetilViewController * _detail = [[RecommendBookDetilViewController alloc]init];
    NSString *str = [[self.FIRSTArray objectAtIndex:indexPath.row]objectForKey:@"thumb"];
    
    _detail.str = [NSString stringWithFormat:@"http://a.cdn123.net/img/r/%@",str];
    _detail.title = [[self.FIRSTArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    _detail.bookid = [[self.FIRSTArray objectAtIndex:indexPath.row]objectForKey:@"id"];
     
    [self.navigationController pushViewController:_detail animated:YES];
    _detail.label.text = [NSString stringWithFormat:@"作者:%@\n简介:%@",[[self.FIRSTArray objectAtIndex:indexPath.row]objectForKey:@"author"],[[self.FIRSTArray objectAtIndex:indexPath.row]objectForKey:@"intro"]];
    [_detail release], _detail = nil;
}
@end
