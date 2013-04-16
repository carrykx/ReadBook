//
//  UWCollectionViewLayout.h
//  UnderWear
//
//  Created by 肖 浩 on 13-1-17.
//  Copyright (c) 2013年 Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UWCollectionView;

@interface UWCollectionViewLayoutAttributes : NSObject

@property (nonatomic ,assign) CGRect frame;
@property (nonatomic ,assign) CGSize size;
@property (nonatomic ,assign) CGPoint center;

@end

@interface UWCollectionViewLayout : NSObject

@property (nonatomic ,assign) UWCollectionView * collectionView;
//单元格的大小
@property (nonatomic ,assign) CGSize itemSize;
//最小的单元格行间距
@property (nonatomic) CGFloat minimumLineSpacing;
//最小的单元格间距
@property (nonatomic) CGFloat minimumInteritemSpacing;
//
@property (nonatomic) UIEdgeInsets sectionInset;

- (UWCollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
