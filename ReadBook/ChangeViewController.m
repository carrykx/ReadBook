//
//  ChangeViewController.m
//  ReadBook
//
//  Created by houshangyong on 13-4-20.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "ChangeViewController.h"

@interface ChangeViewController ()
{
    UIButton * colorButton;
    UIImageView * imageBUtton;
    UIButton * colorButton1;
    UIImageView * imageBUtton1;
    BOOL _first;
    BOOL _first1;
    UIButton * redButton1 ;
    UIButton * redButton;
    UIView * view1;
    UIView * view2;
    UIView * view3;
    UIScrollView * scrollV;
}
@end

@implementation ChangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _first = YES;
        _first1 = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.ibu
    
    scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
    scrollV.backgroundColor = [UIColor brownColor];
    scrollV.scrollEnabled = YES;
    scrollV.contentSize = CGSizeMake(320, 900);
    [self.view addSubview:scrollV];
   
   redButton = [UIButton buttonWithType:UIButtonTypeCustom];
    redButton.frame = CGRectMake(0, 0, 320, 30);
    redButton.backgroundColor = [UIColor grayColor];
    [redButton setTitle:@"改变阅读器字体颜色" forState:UIControlStateNormal];
    [redButton addTarget:self action:@selector(_no) forControlEvents:UIControlEventTouchUpInside];
    [scrollV addSubview:redButton];
 redButton1  = [UIButton buttonWithType:UIButtonTypeCustom];
    redButton1.frame = CGRectMake(0, 31, 320, 30);
    redButton1.backgroundColor = [UIColor grayColor];
    [redButton1 setTitle:@"改变阅读器背景颜色" forState:UIControlStateNormal];
    [redButton1 addTarget:self action:@selector(_no1) forControlEvents:UIControlEventTouchUpInside];
    [scrollV addSubview:redButton1];
     
  }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)_no
{
    NSLog(@"1111111");
    NSArray * arr = [[NSArray alloc]initWithObjects:@"红",@"绿",@"黑",@"白",@"紫",@"蓝",@"粉", nil];
    if (_first == YES)
    {
        if (_first1 == NO) {
            redButton1.frame = CGRectMake(0, 250, 320, 30);
            view2.frame = CGRectMake(0, 280, 320, 210);
            view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 30, 320, 210)];
            view1.backgroundColor = [UIColor clearColor];
        }
        else{
            redButton1.frame = CGRectMake(0, 250, 320, 30);

        view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 30, 320, 210)];
        }
    for (int i= 0 ; i<7; i++)
    {
        colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        colorButton.frame = CGRectMake(0, 30*i, 290, 30);
        colorButton.backgroundColor = [UIColor brownColor];
        colorButton.tag = i;
        [colorButton setTitle:[NSString stringWithFormat:@"%@色背景",[arr objectAtIndex:colorButton.tag]] forState:UIControlStateNormal];
        [colorButton addTarget:self action:@selector(_change:) forControlEvents:UIControlEventTouchUpInside];
        imageBUtton = [[UIImageView alloc]init];;
        imageBUtton.tag = i;
        imageBUtton.frame = CGRectMake(0, 30*i, 30, 30);
        imageBUtton.backgroundColor = [UIColor brownColor];
        [view1 addSubview:imageBUtton];
        [view1 addSubview:colorButton];
        [scrollV addSubview:view1];

        
    }
    
        _first = NO;

    }
    
    
    else
    {
        if (_first1 ==YES) {
            [view1 removeFromSuperview];
            redButton1.frame = CGRectMake(0, 31, 320, 30);
            _first = YES;
        }
        
        if (_first1 == NO) {
             [view1 removeFromSuperview];
            redButton1.frame = CGRectMake(0, 31, 320, 30);
            view2.frame = CGRectMake(0, 61, 320, 210);
            _first = YES;

        }
    }
    
}
- (void)_change:(id)sender
{
    UIButton * button = (UIButton *)sender;
    if (button.tag == 0||button.tag == 1||button.tag == 2||button.tag == 3||button.tag == 4||button.tag == 5||button.tag == 6) {
           imageBUtton.frame = CGRectMake(290, 30*button.tag, 30, 30);
        imageBUtton.image = [UIImage imageNamed:[NSString stringWithFormat:@"imgOn1.png"]] ;
    }
         NSArray * array = [[NSArray alloc]initWithObjects:[UIColor redColor],[UIColor greenColor],[UIColor blackColor],[UIColor whiteColor],[UIColor purpleColor],[UIColor blueColor],[UIColor magentaColor], nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:KNSNotificationChangeTextColor object:[array objectAtIndex:button.tag]];
  


}
- (void)_no1
{
    NSArray * arr1 = [[NSArray alloc]initWithObjects:@"红",@"绿",@"黑",@"白",@"紫",@"蓝",@"粉", nil];
 
    if (_first1 == YES) {
        if (_first == YES) {
            view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 61, 320, 210)];
            view2.backgroundColor = [UIColor clearColor];
        }
        else{
    view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 280, 320, 210)];
            view2.backgroundColor = [UIColor clearColor];
        }
        for (int i= 0 ; i<7; i++) {
            colorButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
            colorButton1.frame = CGRectMake(0, 30*i, 290, 30);
            colorButton1.backgroundColor = [UIColor brownColor];
            colorButton1.tag = i;
            [colorButton1 setTitle:[NSString stringWithFormat:@"%@色背景",[arr1 objectAtIndex:colorButton1.tag]] forState:UIControlStateNormal];
            [colorButton1 addTarget:self action:@selector(_change1:) forControlEvents:UIControlEventTouchUpInside];
            imageBUtton1 = [[UIImageView alloc]init];;
            imageBUtton1.tag = i;
            imageBUtton1.frame = CGRectMake(0, 30*i, 30, 30);
            imageBUtton1.backgroundColor = [UIColor brownColor];
            [view2 addSubview:imageBUtton1];
            [view2 addSubview:colorButton1];
            [scrollV addSubview:view2];
      }
    
         _first1 = NO;
    }else{
        if (_first ==YES) {
            [view2 removeFromSuperview];
           
            _first1 = YES;
        }
        
        if (_first == NO) {
            [view2 removeFromSuperview];
            
            _first1 = YES;
            
        }
    }

    
}
- (void)_change1:(id)sender
{
    UIButton * button = (UIButton *)sender;
    if (button.tag == 0||button.tag == 1||button.tag == 2||button.tag == 3||button.tag == 4||button.tag == 5||button.tag == 6) {
        imageBUtton1.frame = CGRectMake(290, 30*button.tag, 30, 30);
        imageBUtton1.image = [UIImage imageNamed:[NSString stringWithFormat:@"imgOn1.png"]] ;
    }
    NSArray * array = [[NSArray alloc]initWithObjects:[UIColor redColor],[UIColor greenColor],[UIColor blackColor],[UIColor whiteColor],[UIColor purpleColor],[UIColor blueColor],[UIColor magentaColor], nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:KNSNotificationChangebackgroundColor object:[array objectAtIndex:button.tag]];
    
    
    
}

@end
