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
    if (iPhone5) {
        UITableView * tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-110) style:UITableViewStylePlain];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.backgroundColor = [UIColor brownColor];
        self.tableView = tableV;
        [self.view addSubview:tableV];
        [tableV release];

    }else{
        UITableView * tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 370) style:UITableViewStylePlain];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.backgroundColor = [UIColor brownColor];
        self.tableView = tableV;
        [self.view addSubview:tableV];
        [tableV release];

    }
      
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString * homeStrng = NSHomeDirectory();
    NSString * filePath = [homeStrng stringByAppendingFormat:@"webbook1.archiver"];
    self.saveArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    [self.tableView reloadData];
    
//    NSLog(@"%@",self.saveArray);
    
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
    return [self.saveArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell  = @"cell";
    UITableViewCell * _cell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (_cell == nil) {
        _cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell]autorelease];
        _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //设置单元格的内容
    _cell.selectionStyle = UITableViewCellSelectionStyleGray;
    bookSave * _bookSave = [self.saveArray objectAtIndex:indexPath.row] ;
    _cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    _cell.textLabel.text = _bookSave.name;
    _cell.imageView.image = [UIImage imageNamed:@"bookMark.png"];

    return _cell;
}
//tableView 移动
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    bookSave * _bookSave = [self.saveArray objectAtIndex:sourceIndexPath.row];
    [self.saveArray removeObjectAtIndex:sourceIndexPath.row];
    [self.saveArray insertObject:_bookSave atIndex:destinationIndexPath.row];
    
    [self _saveBookMark];
}
//tableView 可移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//tableView 可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//删除某一行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        bookSave * _bookSave = [self.saveArray objectAtIndex:indexPath.row];
        [self.saveArray removeObject:_bookSave];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self _saveBookMark];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ReadBookViewController * _readBook = [[ReadBookViewController alloc]init];
    bookSave * _bookSave = [self.saveArray objectAtIndex:indexPath.row];
    _readBook._readUrl = _bookSave.urlString;
    _readBook.title = _bookSave.name;
    [self.navigationController pushViewController:_readBook animated:YES];
    [_readBook release];
}
#pragma mark
#pragma mark public motheds
//归档
- (void)_saveBookMark
{
    NSString * homeStrng = NSHomeDirectory();
    NSString * filePath = [homeStrng stringByAppendingFormat:@"webbook1.archiver"];
    [NSKeyedArchiver archiveRootObject:self.saveArray toFile:filePath];
}
//tableView 可编辑
- (void)_edit
{
    [self.tableView setEditing:YES animated:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_done)];
    
}
//tableView 不可编辑
- (void)_done
{
    [self.tableView setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(_edit)];
}
- (void)dealloc
{
    [saveArray release];
    [super dealloc];
}
@end