//
//  BookmarkViewController.m
//  ReadBook
//
//  Created by carry on 13-4-15.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "BookmarkViewController.h"
#import "ReadNativeBookViewController.h"

@interface BookmarkViewController ()
@property(nonatomic,retain)UITableView *tableView;
@end

@implementation BookmarkViewController
@synthesize saveArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"书签";
        self.saveArray = [NSMutableArray array];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(_edit)];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(50, 50, 50, 50);
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString * homeStrng = NSHomeDirectory();
    NSString * filePath = [homeStrng stringByAppendingFormat:@"webbook1.archiver"];
    self.saveArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    [self.tableView reloadData];
    
    NSLog(@"%@",self.saveArray);
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testAction
{
    ReadNativeBookViewController *read = [[ReadNativeBookViewController alloc] init];
    read.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:read animated:YES];
    [read release];
}

@end
