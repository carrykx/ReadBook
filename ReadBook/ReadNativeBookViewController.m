//
//  ReadNativeBookViewController.m
//  ReadBook
//
//  Created by carry on 13-4-19.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "ReadNativeBookViewController.h"

@interface ReadNativeBookViewController ()

@property (retain, nonatomic) NSString *str;
@property (retain, nonatomic) UILabel *firstLabel;
@property (retain, nonatomic) UILabel *secondLabel;

@end

@implementation ReadNativeBookViewController

- (void)dealloc
{
    [_str release];
    [_firstLabel release];
    [_secondLabel release];
    [super dealloc];
}

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
    
    self.str = @"d\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\ndn\n\nddd\ndn\nd\ndn\\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\nd\ndddddddddddddddddn\nd\nd\ndn\n\ndn\nddddddddddddddddddd";
    [self creatLabel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatLabel
{
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height)];
    firstLabel.text = self.str;
    firstLabel.numberOfLines = 0;
    firstLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:firstLabel];
    [firstLabel release];
    CGSize labelSize =  [self.str sizeWithFont:firstLabel.font constrainedToSize:CGSizeMake(320.0f, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"%f",labelSize.height);

    
}

@end
