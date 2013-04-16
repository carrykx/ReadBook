//
//  UWCollectionView.m
//  UnderWear
//
//  Created by Duke Douglas on 13-1-15.
//  Copyright (c) 2013年 Lewis. All rights reserved.
//

#import "UControllerView.h"
#import "UWCollectionViewCell.h"

#pragma mark - Gesture Recognizer

// This is just so we know that we sent this tap gesture recognizer in the delegate
@interface UWCollectionViewTapGestureRecognizer : UITapGestureRecognizer
@end

@implementation UWCollectionViewTapGestureRecognizer
@end


@interface UWCollectionView () <UIGestureRecognizerDelegate>

@property (nonatomic, retain) NSMutableSet *reuseableViews;
@property (nonatomic, retain) NSMutableDictionary *visibleViews;


- (BOOL)_isVisibleViewAtIndexPath:(NSIndexPath *)indexPath;
- (void)_setReuseViewAtIndexPath:(NSIndexPath *)indexPath attribute:(UWCollectionViewLayoutAttributes *)attributes;
- (void)_removeReuseViewAtIndexPath:(NSIndexPath *)indexPath;

- (void)_clean;

@end

@implementation UWCollectionView
{
    //offset位置所占的第一个路径
    NSInteger start;
    //每一页最大占有的单元格的个数
    NSInteger maxCount;
}
// Public
@synthesize
collectionViewDelegate = _collectionViewDelegate,
collectionViewDataSource = _collectionViewDataSource;

// Private
@synthesize
reuseableViews = _reuseableViews,
visibleViews = _visibleViews;

@synthesize collectionViewLayout = _collectionViewLayout;

#pragma mark - Init/Memory

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UWCollectionViewLayout *)layout {
    self = [super initWithFrame:frame];
    if (self) {
        self.alwaysBounceVertical = YES;
        self.collectionViewLayout = layout;
        layout.collectionView = self;
        //指定布局后就可以获取，每一页最大能够占有的单元格的个数
        maxCount = ceil(CGRectGetWidth(self.frame) / layout.itemSize.width) * ceil(CGRectGetHeight(self.frame) / layout.itemSize.height);
        
        self.reuseableViews = [NSMutableSet set];
        self.visibleViews = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc {
    // clear delegates
    self.delegate = nil;
    self.collectionViewDataSource = nil;
    self.collectionViewDelegate = nil;
    
    self.reuseableViews = nil;
    self.visibleViews = nil;
    
    [super dealloc];
}

#pragma mark - DataSource

- (void)reloadData {
    //reload data之前清空reusable views和 visible views
    [self _clean];
    [self setNeedsLayout];
}

#pragma mark - View
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = [self.collectionViewDataSource numberOfViewsInCollectionView:self];
    //最后一个单元格的路径的下标值应该减一
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:count - 1 inSection:0];
    //获取最后一个单元格所在的位置
    UWCollectionViewLayoutAttributes *attributes = [self.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    //设置滚动视图的内容区域的大小
    self.contentSize = CGSizeMake(CGRectGetWidth(self.frame),CGRectGetMaxY(attributes.frame));
    
    //计算offset位置的单元格所占的路径的行数
    start = floor(self.contentOffset.y / (self.collectionViewLayout.itemSize.height + self.collectionViewLayout.minimumLineSpacing)) * 3;
    if (start < 0) {
        start = 0;
    }
    //将前边的视图移到重用区
    for (int i = 0; i < start; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self _removeReuseViewAtIndexPath:indexPath];
    }
    //设置将要显示的视图
    for (int i = 0; i < maxCount; i++)
    {
        NSInteger index = i + start;
        if (index >= count) {
            break;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i+start inSection:0];
        UWCollectionViewLayoutAttributes *attributes = [self.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
        //如果当前路径的视图是在显示区域的话就继续执行
        if ([self _isVisibleViewAtIndexPath:indexPath]) {
            continue;
        }
        //设置当前路径的视图
        [self _setReuseViewAtIndexPath:indexPath attribute:attributes];
    }
}

#pragma mark - private methods
- (void)_setReuseViewAtIndexPath:(NSIndexPath *)indexPath attribute:(UWCollectionViewLayoutAttributes *)attributes
{
    UWCollectionViewCell *_newView = [self.collectionViewDataSource collectionView:self viewAtIndex:indexPath.row];
    _newView.frame = attributes.frame;
    _newView.indexPath = indexPath;
    [self addSubview:_newView];
    
    //    // Setup gesture recognizer
    //    if ([_newView.gestureRecognizers count] == 0)
    //    {
    //        UWCollectionViewTapGestureRecognizer *gr = [[[UWCollectionViewTapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectView:)] autorelease];
    //        gr.delegate = self;
    //        [_newView addGestureRecognizer:gr];
    //        _newView.userInteractionEnabled = YES;
    //    }
    //
    //设置当前视图在显示区
    [self.visibleViews setObject:_newView forKey:indexPath];
}
- (BOOL)_isVisibleViewAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.visibleViews objectForKey:indexPath] ? YES: NO;
}
- (void)_removeReuseViewAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [self.visibleViews objectForKey:indexPath];
    if (view == nil) {
        return;
    }
    //先添加到重用区，否则内存就先释放掉了
    [self.reuseableViews addObject:view];
    //在显示区中移除掉
    [self.visibleViews removeObjectForKey:indexPath];
    //在父视图上删除已经不显示的视图
    [view removeFromSuperview];
}

#pragma mark - Reusing Views

- (UWCollectionViewCell *)dequeueReusableView {
    UWCollectionViewCell *view = [self.reuseableViews anyObject];
    if (view) {
        // Found a reusable view, remove it from the set
        [view retain];
        [self.reuseableViews removeObject:view];
        [view autorelease];
    }
    
    return view;
}

#pragma mark - Gesture Recognizer

- (void)didSelectView:(UITapGestureRecognizer *)gestureRecognizer {
    UWCollectionViewCell *cell = (UWCollectionViewCell *)gestureRecognizer.view;
    
    if ([self.collectionViewDelegate respondsToSelector:@selector(collectionView:didSelectView:atIndex:)]) {
        [self.collectionViewDelegate collectionView:self didSelectView:(UWCollectionViewCell *)gestureRecognizer.view atIndex:cell.indexPath.row];
    }
}

#pragma mark - Clean all the data
- (void)_clean
{
    [_reuseableViews removeAllObjects];
    [_visibleViews removeAllObjects];
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

@end
