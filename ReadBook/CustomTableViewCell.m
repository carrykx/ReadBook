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
    [_customImageView release];
    [_boardIntroLable release];
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
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableCellBackgournd.png"]];
    self.customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 5.0f, 60.0f/430*300.0f, 60.0f)];
    [self.contentView addSubview:self.customImageView];
    
    self.boardNameLable = [[UILabel alloc] initWithFrame:CGRectMake(56.0f, 5.0f, 240.0f, 25.0f)];
    self.boardNameLable.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.boardNameLable];
    
    self.boardIntroLable = [[UILabel alloc] initWithFrame:CGRectMake(56.0f, 30.0f, 240.0f, 35)];
    self.boardIntroLable.backgroundColor = [UIColor clearColor];

    [self.contentView addSubview:self.boardIntroLable];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}
@end
