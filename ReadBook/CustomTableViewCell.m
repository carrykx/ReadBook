//
//  CustomTableViewCell.m
//  ReadBook
//
//  Created by carry on 13-4-17.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell


- (void)dealloc
{
    [_boardNameLable release];
    [_image release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self creatContentView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)creatContentView
{
    UIView *customContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 320.0, 320.0f/730*140);
    [customContentView addSubview:imageView];
    self.image = imageView;
    [imageView release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,  320.0f/730*140, self.frame.size.width - 20, self.frame.size.height -320.0f/730*140)];
    [customContentView addSubview:label];
    self.boardNameLable = label;
    [label release];
    [self.contentView addSubview:customContentView];
    [customContentView release];
}

@end
