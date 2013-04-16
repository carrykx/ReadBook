/**
 *
 * WaterFlow CellView
 *
 * Create by GeekDuke 01.15
 *
 */

#import <UIKit/UIKit.h>

@interface UWCollectionViewCell : UIView

@property (nonatomic, retain) id object;
@property (nonatomic, retain) NSIndexPath *indexPath;

/**
 *	@brief	Ready to reuse method
 */
- (void)prepareToReuse;

- (void)fillViewWithObject:(id)_object;

@end
