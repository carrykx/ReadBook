//
//  BookmarkViewController.m
//  ReadBook
//
//  Created by carry on 13-4-15.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "BookmarkViewController.h"
#import "bookSave.h"
#import "ReadBookViewController.h"

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
    UITableView * tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 370) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = [UIColor brownColor];
    self.tableView = tableV;
    [self.view addSubview:tableV];
    [tableV release];
    
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
#pragma mark
#pragma mark tableView datasource delegate motheds
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
}
@end
