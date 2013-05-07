//
//  MoreViewController.m
//  ReadBook
//
//  Created by carry on 13-4-15.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "MoreViewController.h"
#import "AboutViewController.h"
#import "SuggestViewController.h"
#import "MyBookViewController.h"
#import "ChangeViewController.h"
#import "RankViewController.h"
@interface MoreViewController ()

@property (retain, nonatomic) UITableView *contentTable;
@property(nonatomic,retain)UIColor *color;
@property(nonatomic,retain)UIColor *textColor;
@end

@implementation MoreViewController

- (void)dealloc
{
    [_contentTable release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"更多";
      

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    [self creatTable];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_changetextColor:) name:KNSNotificationChangeTextColor object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_changebackgroundColor:) name:KNSNotificationChangebackgroundColor object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatTable
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - 90.0f) style:UITableViewStyleGrouped];
    self.contentTable = tableview;
    [tableview release];
    
    self.contentTable.separatorColor = [UIColor brownColor];
    self.contentTable.backgroundView = nil;
    self.contentTable.backgroundColor = [UIColor clearColor];
    self.contentTable.backgroundColor = [UIColor clearColor];
    self.contentTable.delegate = self;
    self.contentTable.dataSource = self;
    
    [self.view addSubview:self.contentTable];
    
}
-(void)_changebackgroundColor:(NSNotification *)notification
{
    self.color=[notification object];
}
-(void)_changetextColor:(NSNotification *)notification
{
    self.textColor = [notification object];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1)
    {
        return 1;
    }else
    {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 5.0f, 250.0f, 25.0f)];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = [UIColor brownColor];
    label.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:label];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            label.text = @"我的书架";
        }else if (indexPath.row == 1)
        {
            label.text = @"排行";
        }

    }else if (indexPath.section == 1)
    {
       
            label.text = @"软件设置";
            }else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            label.text = @"意见反馈";
        }else if (indexPath.row == 1)
        {
            label.text = @"关于我们";
        }
    }
    [label release];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40.0f;
    }else
    {
    return 10.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MyBookViewController * _readd = [[MyBookViewController alloc]init];
            _readd.color = self.color;
            _readd.textColor = self.textColor;
            [self.navigationController pushViewController:_readd animated:YES];
            
            [_readd release];
        }
    else if (indexPath.row == 1)
    {
        RankViewController * rank = [[RankViewController alloc]init];
        [self.navigationController pushViewController:rank animated:YES];
        [rank release];
    }

    }else if (indexPath.section == 1)
    {
        
            ChangeViewController * change = [[ChangeViewController alloc]init];
            [self.navigationController pushViewController:change animated:YES];
            [change release];
    }else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            
            SuggestViewController *sug = [[SuggestViewController alloc] init];
            [self.navigationController pushViewController:sug animated:YES];
            [sug release];

        }else if (indexPath.row == 1)
        {        
       
            AboutViewController *about = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:about animated:YES];
            [about release];
        }
    }

}
@end








