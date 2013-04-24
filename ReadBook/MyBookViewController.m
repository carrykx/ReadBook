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
#import "UIButton+WebCache.h"
#import "ReadNativeBookViewController.h"

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
        UWCollectionViewLayout *_layout = [[UWCollectionViewLayout alloc] init];
        _layout.itemSize = CGSizeMake(105, 138);
        _layout.minimumInteritemSpacing = 0.0f;
        _layout.minimumLineSpacing = 0.0f;
        _layout.sectionInset = UIEdgeInsetsMake(2.5f, 2.5f, 0.0f, 0.0f);
        _collectionView = [[UWCollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 468) collectionViewLayout:_layout];
        _collectionView.collectionViewDataSource = self;
        _collectionView.collectionViewDelegate = self;
        [self.view addSubview:_collectionView];
        //    [_collectionView release],_collectionView = nil;
        //    [_layout release],_layout = nil;
        NSString * string1 = NSHomeDirectory();
        NSString * filePath = [string1 stringByAppendingFormat:@"readbook22.txt"];
        self.items = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }else{
    UWCollectionViewLayout *_layout = [[UWCollectionViewLayout alloc] init];
    _layout.itemSize = CGSizeMake(105, 138);
    _layout.minimumInteritemSpacing = 0.0f;
    _layout.minimumLineSpacing = 0.0f;
    _layout.sectionInset = UIEdgeInsetsMake(2.5f, 2.5f, 0.0f, 0.0f);
    _collectionView = [[UWCollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 380) collectionViewLayout:_layout];
    _collectionView.collectionViewDataSource = self;
    _collectionView.collectionViewDelegate = self;
    [self.view addSubview:_collectionView];
    //    [_collectionView release],_collectionView = nil;
    //    [_layout release],_layout = nil;
    NSString * string1 = NSHomeDirectory();
    NSString * filePath = [string1 stringByAppendingFormat:@"readbook22.txt"];
    self.items = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
      }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}
#pragma mark collectionview data source
- (NSInteger)numberOfViewsInCollectionView:(UWCollectionView *)collectionView
{
    return [self.items count];
    
}

- (UWCollectionViewCell *)collectionView:(UWCollectionView *)collectionView viewAtIndex:(NSInteger)index
{
    UWView *_itemCell = (UWView *)[collectionView dequeueReusableView];
    
    if (_itemCell == nil) {
        _itemCell = [[UWView alloc] initWithFrame:CGRectZero];
    }
    ReadBook * read = [self.items objectAtIndex:index];
    _itemCell.button.tag= index;
    [_itemCell.button setBackgroundImageWithURL:[NSURL URLWithString:read.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Default.png"]];
    [_itemCell.button addTarget:self action:@selector(_pus:) forControlEvents:UIControlEventTouchUpInside];
    
    return _itemCell;
}
//去读书
- (void)_pus:(id)sender
{
    // 点击完之后添加一个半透明的背景
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f-88.0f)];
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
    UIButton *button = (UIButton *)sender;
    ReadBook * read = [self.items objectAtIndex:button.tag];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:read forKey:@"read"];
//    [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(pushViewController:) userInfo:read repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(pushViewController:) userInfo:dic repeats:NO];
}

// 
- (void)pushViewController:(NSTimer *)timer
{
//    NSLog(@"///");
    ReadBook *read = [[timer userInfo] objectForKey:@"read"];
    
    ReadNativeBookViewController *native = [[ReadNativeBookViewController alloc] init];
    native.strAll = read.readBook;
    //    NSLog(@"%@",read.readBook);
    native.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:native animated:YES];
    [native release];
    [_promptLabel removeFromSuperview];
    [_backgroundView removeFromSuperview];
    [_act stopAnimating];

}

@end
