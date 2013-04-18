//
//  UWView.m
//  CollectionView
//
//  Created by 肖 浩 on 13-2-28.
//  Copyright (c) 2013年 肖 浩. All rights reserved.
//

#import "UWView.h"
#import <QuartzCore/QuartzCore.h>
@implementation UWView
@synthesize content = _content;
@synthesize button;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelfCell.png"]];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 100, 40)];
        
        _label.backgroundColor = [UIColor clearColor];
        //        _label.layer.cornerRadius = 5.0f;
        //        _label.layer.borderColor = [[UIColor redColor] CGColor];
        //        _label.layer.borderWidth = 4.0f;
        _label.textColor = [UIColor blueColor];
        _label.textAlignment = NSTextAlignmentCenter;
        
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        button.layer.cornerRadius = 5;
        //        button.layer.borderWidth = 4;
        //        button.layer.borderColor = [[UIColor redColor]CGColor];
        button.frame = self.bounds;
        [self addSubview:button];
        [button addSubview:_label];
    }
    return self;
}


//当改变视图的大小时，会自动调用该方法layoutSubViews,重新布局子视图
- (void)layoutSubviews
{
    [super layoutSubviews];
    //    _label.frame = self.bounds;
    button.frame = CGRectMake(20, 5, 80, 100);
}


//当改变视图显示的文字时，刷新label显示的内容
- (void)setContent:(NSString *)content
{
    //当新内容与旧内容相同时，直接返回
    if ([_content isEqualToString:content]) {
        return;
    }
    
    //否则的话，显示文字
    
    _label.text = content;
    
    //内存管理
    [_content release];
    _content = [content retain];
}
//- (void)setbutton:(UIImage *)image
//{
//    if ([_image1 isEqual:image]) {
//        return;
//    }
//    button.image = image;
//
//
//   }
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
