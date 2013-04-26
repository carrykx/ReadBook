//
//  SuggestViewController.m
//  ReadBook
//
//  Created by carry on 13-4-18.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "SuggestViewController.h"

@interface SuggestViewController ()

@property (retain, nonatomic) UITableView *tableview;
@property (retain, nonatomic) UITextField *messageTitle;
@property (retain, nonatomic) UITextView *messageContent;

@end

@implementation SuggestViewController

- (void)dealloc
{
    [_messageTitle release];
    [_messageContent release];
    [_tableview release];
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
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor brownColor];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview release];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.section == 0) {
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 280, 20)];
        field.backgroundColor = [UIColor clearColor];
        field.autocapitalizationType = UITextAutocapitalizationTypeNone;
        field.autocorrectionType = UITextAutocorrectionTypeNo;
        field.spellCheckingType = UITextSpellCheckingTypeNo;
        [cell.contentView addSubview:field];
        self.messageTitle = field;
        [field release];
    }else
    {
        UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(5, 10, 290, 150)];
        text.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:text];
        self.messageContent = text;
        [text release];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30.0f;
    }else
        return 30.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"标题";
    }else
        return @"内容";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 30;
    }else
        return 250;
}


- (void)saveAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
