//
//  UWView.h
//  CollectionView
//
//  Created by 肖 浩 on 13-2-28.
//  Copyright (c) 2013年 肖 浩. All rights reserved.
//

#import "UWCollectionViewCell.h"

@interface UWView : UWCollectionViewCell
{
    UILabel *_label;
    UIButton * button;
}

//视图上显示的文字
@property (nonatomic ,retain) NSString *content;
@property (nonatomic,retain)UIButton * button;
@end
