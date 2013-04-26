//
//  AboutViewController.m
//  ReadBook
//
//  Created by carry on 13-4-18.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "AboutViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface AboutViewController ()

@property (retain,nonatomic) UITableView *tableview;
@property (retain,nonatomic) UIImageView *imageView;
// @property (nonatomic, retain) UIScrollView *scrollView;
@property (retain, nonatomic) NSString *str;
@property (retain, nonatomic) UILabel *firstLabel;
// @property (retain, nonatomic) UILabel *secondLabel;


@end

@implementation AboutViewController

-(void)dealloc
{
    [_str release];
    [_firstLabel release];
    [_tableview release];
    [_imageView release];
    // [_scrollView release];
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
    self.navigationItem.title = @"关于";
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview release];
    
    // UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10.0, 15.0, 300.0, 150.0)];
    
    
    // [self.view addSubview:scrollView];
    // self.scrollView = scrollView;
    // [scrollView release];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    //    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    //    text.backgroundColor = [UIColor clearColor];
    //    text.layer.cornerRadius = 20;
    //    text.keyboardType = UIKeyboardTypeDefault;
    //    [cell.contentView addSubview:text];
    //
    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"0.jpg"]];
    //    imageView.frame = CGRectMake(0, 0, 300, 100);
    //    self.imageView = imageView;
    //    self.imageView.layer.cornerRadius = 20;
    //    self.imageView.backgroundColor = [UIColor clearColor];
    //    [text addSubview:self.imageView];
    //
    //    [imageView release];
    ////    [text release];
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 120.0, 285.0, 200.0)];
    self.str = @"   书朋建立于2012年，由几个“以书会友，广朋多智”为信仰的年轻人组成。是一个只专注于网络图书资源的搜索、开发、分享、应用的团队。书朋并不是网络上仅有的小说查找引擎，但却是规划最大和更新最快的。";
    firstLabel.text = self.str;
    firstLabel.numberOfLines = 0;
    firstLabel.font = [UIFont systemFontOfSize:18];
    [cell.contentView addSubview:firstLabel];
    [firstLabel release];
    CGSize labelSize =  [self.str sizeWithFont:firstLabel.font constrainedToSize:CGSizeMake(320.0f, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"%f",labelSize.height);
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"0.jpg"]];
    imageView.frame = CGRectMake(10, 10, 280, 100);
    self.imageView = imageView;
    self.imageView.layer.cornerRadius = 20;
    self.imageView.backgroundColor = [UIColor clearColor];
    [imageView release];
    
    [cell.contentView addSubview:firstLabel];
    [cell.contentView addSubview:self.imageView];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 345.0;
}
@end
