//
//  SaveBookMarkViewController.m
//  ReadBook
//
//  Created by Ibokan on 13-4-18.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "SaveBookMarkViewController.h"
#import "BookmarkViewController.h"
#import "bookSave.h"
@interface SaveBookMarkViewController ()
{
    bookSave * _booksave;
}
@end

@implementation SaveBookMarkViewController
@synthesize urlString,nameString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(_cancel)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(_save)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iPhone5) {
        UITableView * tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-100) style:UITableViewStyleGrouped];
        tableV.delegate = self;
        tableV.dataSource = self;
        [self.view addSubview:tableV];
    }
    else{
        UITableView * tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-100) style:UITableViewStyleGrouped];
        tableV.delegate = self;
        tableV.dataSource = self;
        [self.view addSubview:tableV];
    }
    _booksave  = [[bookSave alloc]init];
    _booksave.name = self.nameString;
//    NSLog(@"你大爷%@",_booksave.name);
    _booksave.urlString = self.urlString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell = @"cell";
    UITableViewCell * _cell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (_cell == nil) {
        _cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell]autorelease];
    }
       if (indexPath.row == 0) {
        _cell.textLabel.text = self.nameString;
    
    }
    else
    {
        _cell.textLabel.text = self.urlString;
    }
    return _cell;
}
- (void)_cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)_save
{
    BookmarkViewController * bookMark = [[BookmarkViewController alloc]init];
    
   
    NSString * homeStrng = NSHomeDirectory();
    NSString * filePath = [homeStrng stringByAppendingFormat:@"webbook1.archiver"];
  NSMutableArray *array = [NSMutableArray arrayWithArray:  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath]];
    [array addObject:_booksave];
   
    [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    [self.navigationController popViewControllerAnimated:YES];
    [bookMark release],bookMark = nil;
}
@end
