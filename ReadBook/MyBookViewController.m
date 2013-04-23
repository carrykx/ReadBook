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
@interface MyBookViewController ()

@end

@implementation MyBookViewController
@synthesize items;
@synthesize strrr;
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
        UWCollectionView *_collectionView = [[UWCollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 468) collectionViewLayout:_layout];
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
    UWCollectionView *_collectionView = [[UWCollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 380) collectionViewLayout:_layout];
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
    //    NSLog(@"%@",sender);
//    UIButton *button = (UIButton *)sender;
////    MyReadBookViewController * _readd = [[MyReadBookViewController alloc]init];
//    ReadBook * read = [self.items objectAtIndex:button.tag];
//    //阅读背景色
//    _readd.color = self.color;
//    //阅读文字色
//    _readd.textColor = self.textColor;
//    [self.navigationController pushViewController:_readd animated:YES];
////    _readd.textRead.text = [NSString stringWithFormat:@"%@",read.readBook];
   
}

@end
