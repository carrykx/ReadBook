//
//  RankViewController.m
//  ReadBook
//
//  Created by houshangyong on 13-4-27.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "RankViewController.h"
#import "JSON.h"
#import "CustomTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RecommendBookDetilViewController.h"
#import "RankBookViewController.h"
@interface RankViewController ()
{
    NSInteger sectionCount;
}
@property (nonatomic , retain) NSMutableArray * array0;
@property (nonatomic , retain) NSMutableArray * array1;
@property (nonatomic , retain) NSMutableArray * array2;
@property (nonatomic , retain) NSMutableArray * array3;
@property (nonatomic , retain) NSMutableArray * array4;
@property (nonatomic , retain) NSMutableArray * array5;
@property (nonatomic , retain) NSMutableArray * array6;
@property (nonatomic , retain) NSMutableArray * array7;
@property (nonatomic , retain) NSMutableArray * array8;
@property (nonatomic , retain) NSMutableArray * array9;
@property (nonatomic , retain) NSMutableArray * array10;
@property (nonatomic , retain) NSMutableArray * array11;
@end

@implementation RankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        sectionCount = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor brownColor];
    UITableView * table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height- 20-44-60-60) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:table];
    [self request];
    [table release];
}
- (void)request
{
    NSString * appkey  = @"df6df696f6339c461cccd5ca357c7172";//appkey
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.shupeng.com/top"]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:appkey forHTTPHeaderField:@"User-Agent"];//用appk代替User-Agent
    
    NSData * data =   [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *_content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //json解析
    NSDictionary  * json = [_content JSONValue];
    [_content release];
    NSLog(@"%@",json);
    NSArray * array = [json objectForKey:@"result"];
    
    if ([array count] == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"没有同作者书籍" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    }
    else{
        
        self.array10 = [array valueForKey:@"name"];
        NSLog(@"%@",self.array10);
        
        self.array0 = [[array objectAtIndex:0]valueForKey:@"toplist"];
        self.array1 = [[array objectAtIndex:1]valueForKey:@"toplist"];
        self.array2 = [[array objectAtIndex:2]valueForKey:@"toplist"];
        self.array3 = [[array objectAtIndex:3]valueForKey:@"toplist"];
        self.array4 = [[array objectAtIndex:4]valueForKey:@"toplist"];
        self.array5 = [[array objectAtIndex:5]valueForKey:@"toplist"];
        self.array6 = [[array objectAtIndex:6]valueForKey:@"toplist"];
        self.array7 = [[array objectAtIndex:7]valueForKey:@"toplist"];
        self.array8 = [[array objectAtIndex:8]valueForKey:@"toplist"];
        self.array9 = [[array objectAtIndex:9]valueForKey:@"toplist"];
        self.array11 = [NSMutableArray arrayWithObjects:self.array0,self.array1,self.array2,self.array3,self.array4,self.array5,self.array6,self.array7,self.array8,self.array9, nil];
           }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma mark tableView dataSource delegate motheds
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [[self.array11 objectAtIndex:section]count];
    }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell = @"cell";
    UITableViewCell * _cell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (_cell == nil) {
        _cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell]autorelease];
        _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
   
        _cell.textLabel.text = [[[self.array11 objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"name"] ;

  

    return _cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [self.array10 count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.array10 objectAtIndex:section];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
         RankBookViewController * rank = [[RankBookViewController alloc]init];
    //传BookId
   rank.bookId = [[[self.array11 objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"id"];
 rank.rankType = [[[self.array11 objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"name"] ;
    rank.title = [self.array10 objectAtIndex:indexPath.section];
         [self.navigationController pushViewController:rank animated:YES];
          [rank release];

   
}


@end
