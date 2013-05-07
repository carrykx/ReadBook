//
//  MyBookViewController.m
//  ReadBook
//
//  Created by houshangyong on 13-4-20.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "MyBookViewController.h"

#import "UWCollectionViewLayout.h"
#import "UWView.h"

#import "ReadBook.h"
#import "UIImageView+WebCache.h"
#import "ReadNativeBookViewController.h"
#import "CustomTableViewCell.h"
@interface MyBookViewController ()

@end

@implementation MyBookViewController
{
    UWCollectionView *_collectionView;
    UIView *_backgroundView;
    UIActivityIndicatorView *_act;
    UILabel *_promptLabel;
}
@synthesize items;
@synthesize strrr;

- (void)dealloc
{
    [_promptLabel release];
    [_act release];
    [_backgroundView release];
    [_collectionView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的书架";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    if (iPhone5) {
    
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 468)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 80;
        tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tableView];
        [tableView release];
        NSString * string1 = NSHomeDirectory();
        NSString * filePath = [string1 stringByAppendingFormat:@"book.text"];
        self.items = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }else{
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 380)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 80;
        [self.view addSubview:tableView];
        tableView.backgroundColor = [UIColor clearColor];

        [tableView release];

        NSString * string1 = NSHomeDirectory();
    NSString * filePath = [string1 stringByAppendingFormat:@"book.text"];
    self.items = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
      }
    NSLog(@"%@",self.items);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}
#pragma mark tableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.items count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
   static NSString * cell = @"cell";
    CustomTableViewCell * _itemCell = [tableView1 dequeueReusableCellWithIdentifier:cell];
    if (_itemCell == nil) {
        _itemCell = [[[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell]autorelease];
    }
    ReadBook * read = [self.items objectAtIndex:indexPath.row];
    [_itemCell.customImageView setImageWithURL:[NSString stringWithFormat:@"%@",read.image]placeholderImage:[UIImage imageNamed:@"Default.png"]];
    
    return _itemCell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ReadBook * read = [self.items objectAtIndex:indexPath.row];
        [self.items removeObject:read];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    [self save];
}
//去读书
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // 点击完之后添加一个半透明的背景
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.bounds.size.height)];
    _backgroundView.alpha = 0.5;
    _backgroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_backgroundView];
    
    // 在背景上加的等待控件
    _act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140.0f, 145.0f, 40.0f, 40.0f)];
    [_backgroundView addSubview:_act];
    [_act startAnimating];
    
    // 提示
    _promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(130.0f, 185.0f, 70.0f, 30.0f)];
    _promptLabel.font = [UIFont systemFontOfSize:14];
    _promptLabel.backgroundColor = [UIColor clearColor];
    _promptLabel.textColor = [UIColor whiteColor];
    _promptLabel.textAlignment = NSTextAlignmentCenter;
    _promptLabel.text = @"正在载入...";
    [_backgroundView addSubview:_promptLabel];
    
    // 要点击的按钮
    ReadBook * read = [self.items objectAtIndex:indexPath.row];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:read forKey:@"read"];
    //    [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(pushViewController:) userInfo:read repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(pushViewController:) userInfo:dic repeats:NO];

}
- (void)pushViewController:(NSTimer *)timer
{
//    NSLog(@"///");
    ReadBook *read = [[timer userInfo] objectForKey:@"read"];
    
    ReadNativeBookViewController *native = [[ReadNativeBookViewController alloc] init];
    native.strAll = read.readBook;
    //阅读背景色
    native.color = self.color;
    //阅读文字色
    native.textColor = self.textColor;
    //    NSLog(@"%@",read.readBook);
    native.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:native animated:YES];
    [native release];
    [_promptLabel removeFromSuperview];
    [_backgroundView removeFromSuperview];
    [_act stopAnimating];

}
//save
- (void)save
{
    NSString * string1 = NSHomeDirectory();
    NSString * filePath = [string1 stringByAppendingFormat:@"book.text"];
  [NSKeyedArchiver archiveRootObject:self.items toFile:filePath];

}
@end
