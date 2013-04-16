/**
 *
 * UWCollection View
 *
 * Create by GeekDuke 01.15
 *
 */

#import <UIKit/UIKit.h>
#import "UWCollectionViewLayout.h"

@class UWCollectionViewCell;

@protocol UWCollectionViewDelegate, UWCollectionViewDataSource;


@interface UWCollectionView : UIScrollView

@property (nonatomic, assign) id <UWCollectionViewDelegate> collectionViewDelegate;
@property (nonatomic, assign) id <UWCollectionViewDataSource> collectionViewDataSource;


@property (nonatomic ,retain) UWCollectionViewLayout *collectionViewLayout;
#pragma mark - Public Methods

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UWCollectionViewLayout *)layout;

/**
 Reloads the collection view
 This is similar to UITableView reloadData)
 */
- (void)reloadData;

/**
 Dequeues a reusable view that was previously initialized
 This is similar to UITableView dequeueReusableCellWithIdentifier
 */
- (UWCollectionViewCell *)dequeueReusableView;

@end

#pragma mark - Delegate

@protocol UWCollectionViewDelegate <NSObject>

@optional

- (void)collectionView:(UWCollectionView *)collectionView didSelectView:(UWCollectionViewCell *)view atIndex:(NSInteger)index;

@end

#pragma mark - DataSource

@protocol UWCollectionViewDataSource <NSObject>

@required
- (NSInteger)numberOfViewsInCollectionView:(UWCollectionView *)collectionView;

- (UWCollectionViewCell *)collectionView:(UWCollectionView *)collectionView viewAtIndex:(NSInteger)index;

@end
