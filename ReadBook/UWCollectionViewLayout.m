//
//  UWCollectionViewLayout.m
//  UnderWear
//
//  Created by 肖 浩 on 13-1-17.
//  Copyright (c) 2013年 Lewis. All rights reserved.
//

#import "UWCollectionViewLayout.h"


@implementation UWCollectionViewLayoutAttributes
@synthesize frame = _frame;
@synthesize size = _size;
@synthesize center = _center;

@end

@implementation UWCollectionViewLayout
{
    NSMutableDictionary *_attributeDictionary;
}
@synthesize itemSize = _itemSize;
@synthesize minimumInteritemSpacing = _minimumInteritemSpacing;
@synthesize minimumLineSpacing = _minimumLineSpacing;
@synthesize sectionInset = _sectionInset;
@synthesize collectionView = _collectionView;

- (id)init
{
    self = [super init];
    if (self) {
        _attributeDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (void)dealloc
{
    self.collectionView = nil;
    [_attributeDictionary release],_attributeDictionary = nil;
    [super dealloc];
}
- (void)setCollectionView:(UWCollectionView *)collectionView
{
    if ([_collectionView isEqual:collectionView]) {
        return;
    }
    _collectionView = nil;
    _collectionView = collectionView;
}



- (UWCollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UWCollectionViewLayoutAttributes *_attributes = [_attributeDictionary objectForKey:indexPath];
    if (_attributes) {
        return _attributes;
    }
    _attributes = [[UWCollectionViewLayoutAttributes alloc] init];
    _attributes.size = self.itemSize;
    
    //获取当前indexPath路径应该在的行数
    NSInteger row = indexPath.row / 3;//3是每行3个
    //获取当前indexPath路径应该在的列数
    NSInteger column = indexPath.row % 3;//3也是每行3个
    //计算中心点的x坐标
    CGFloat x = column * (self.itemSize.width + self.minimumInteritemSpacing) + self.sectionInset.left + (self.itemSize.width / 2.0f);
    //计算中心点的y坐标
    CGFloat y = row * (self.itemSize.height + self.minimumLineSpacing) + self.sectionInset.top + (self.itemSize.height / 2.0f);
    _attributes.center = CGPointMake(x, y);
    //计算当前路径应该使用的布局位置
    _attributes.frame = CGRectMake(x - self.itemSize.width / 2.0f, y - self.itemSize.height / 2.0f, self.itemSize.width, self.itemSize.height);
    
    [_attributeDictionary setObject:_attributes forKey:indexPath];
    return [_attributes autorelease];
}
@end
