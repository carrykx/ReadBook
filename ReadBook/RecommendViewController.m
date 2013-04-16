//
//  RecommendViewController.m
//  ReadBook
//
//  Created by carry on 13-4-15.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "RecommendViewController.h"
#import "UWCollectionViewLayout.h"
#import "UWView.h"

@interface RecommendViewController ()

@end

@implementation RecommendViewController

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
    self.view.backgroundColor = [UIColor blackColor];
    UISegmentedControl * _segmentControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    _segmentControl.momentary = NO;
    [_segmentControl insertSegmentWithTitle:@"" atIndex:0 animated:YES];
    [self.view addSubview:_segmentControl];
    UWCollectionViewLayout *_layout = [[UWCollectionViewLayout alloc] init];
    _layout.itemSize = CGSizeMake(100, 138);
    _layout.minimumInteritemSpacing = 5.0f;
    _layout.minimumLineSpacing = 5.0f;
    _layout.sectionInset = UIEdgeInsetsMake(5.0f, 5.0f, 0.0f, 0.0f);
    UWCollectionView *_collectionView = [[UWCollectionView alloc] initWithFrame:CGRectMake(0, 40, 320, 416) collectionViewLayout:_layout];
    _collectionView.collectionViewDataSource = self;
    _collectionView.collectionViewDelegate = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView release],_collectionView = nil;
    [_layout release],_layout = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark collectionview data source
- (NSInteger)numberOfViewsInCollectionView:(UWCollectionView *)collectionView
{
    //    return [self.items count];
    return 30;
}

- (UWCollectionViewCell *)collectionView:(UWCollectionView *)collectionView viewAtIndex:(NSInteger)index
{
    UWView *_itemCell = (UWView *)[collectionView dequeueReusableView];
    
    if (_itemCell == nil) {
        _itemCell = [[UWView alloc] initWithFrame:CGRectZero];
    }
    
    
    
    _itemCell.content = @"ffffff";
    
    return _itemCell;
}
- (void)collectionView:(UWCollectionView *)collectionView didSelectView:(UWCollectionViewCell *)view atIndex:(NSInteger)index;
{
    NSLog(@"%d",index);
}

@end
