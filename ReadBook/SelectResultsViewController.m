//
//  SelectResultsViewController.m
//  ReadBook
//
//  Created by ibokan on 13-4-19.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "SelectResultsViewController.h"

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
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier=@"selectresultcell";
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:indentifier];
   if (!cell) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier]autorelease];
    }
    //通过name关键字从数据字典里获取搜索到的小说名字
    cell.textLabel.text = [[self.FIRSTArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    //通过提供的图片地址获取图片
    NSString *str = [[self.FIRSTArray objectAtIndex:indexPath.row]objectForKey:@"thumb"];
    NSString *ImageStr = [NSString stringWithFormat:@"http://a.cdn123.net/img/r/%@",str];
    NSData *ImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageStr]];
    UIImage *image = [UIImage imageWithData:ImageData];
    if (image) {
        cell.imageView.image = image;
    }
    //获取作者信息
    NSString *author = [[self.FIRSTArray objectAtIndex:indexPath.row]objectForKey:@"author"];
    cell.detailTextLabel.text = author;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
