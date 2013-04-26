//
//  ReadNativeBookViewController.m
//  ReadBook
//
//  Created by carry on 13-4-19.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "ReadNativeBookViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ReadNativeBookViewController ()

@property (retain, nonatomic) UILabel *firstLabel;
@property (retain, nonatomic) UILabel *secondLabel;
@property (retain, nonatomic) NSMutableArray *everyPageRanges;     // 保存每页显示字符范围的NSRange数组
@property (retain, nonatomic) UIBarButtonItem *showPage;
@property (retain, nonatomic) UIToolbar *toobar;

@end

@implementation ReadNativeBookViewController
{
    NSInteger totalPages;   // 页面总数
    NSInteger currentPage;      // 当前页面
    BOOL setTap;
}

- (void)dealloc
{
    [_everyPageRanges release];
    [_toobar release];
    [_showPage release];
    [_strAll release];
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
    self.view.backgroundColor = self.color;
    currentPage = 1;
    setTap = NO;

    [self creatLabel];
    [self calculateOnePageRangeOnStrAll];
    [self creatToolBar];
    
    [self creatTapForView:self.firstLabel];
    [self creatSwipeOnView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatSwipeOnView:(UIView*)view
{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downPageAction)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [view addGestureRecognizer:swipeLeft];
    [swipeLeft release];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upPageAction)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [view addGestureRecognizer:swipeRight];
    [swipeRight release];
    
}

- (void)creatTapForView:(UIView*)view
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;       // 点击一次触发
    tap.numberOfTouchesRequired = 1;    // 一个手指头
    [view addGestureRecognizer:tap];
    tap.delegate = self;
    [tap release];

}

- (void)creatLabel
{
    UILabel* textLabel1 = [[UILabel alloc] init];
//    if (setTap == NO) {
//        textLabel1.frame = CGRectMake(0, 0, self.view.bounds.size.width, 460.0f-88.0f);
//    }else
//    {
        textLabel1.frame = CGRectMake(0, 0, self.view.bounds.size.width, 460.0f);
//    }
//    [textLabel1 setBackgroundColor:[UIColor grayColor]];
    textLabel1.numberOfLines = 0;
    textLabel1.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textLabel1];
    self.firstLabel = textLabel1;
    self.firstLabel.userInteractionEnabled = YES;
    self.firstLabel.textColor = self.textColor;
    self.firstLabel.backgroundColor  = self.color;
    [textLabel1 release];
   
}

// 计算并保存每一个Label显示的范围
- (void)calculateOnePageRangeOnStrAll
{
    if (self.strAll) {
        CGSize totalSize = [self.strAll sizeWithFont:self.firstLabel.font constrainedToSize:CGSizeMake(self.firstLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        if (totalSize.height <= self.firstLabel.frame.size.height) {
            self.firstLabel.text = self.strAll;
        }else
        {
            // 如果一页显示不下,那么就开始计算页数以及一页的显示范围
            // 先大概估算需要多少页能显示完,只是估算
            NSInteger estimate = totalSize.height/self.firstLabel.frame.size.height + 1;
            // 估算每一页可以容纳多少个字符
            NSInteger onePageInt = self.strAll.length/estimate;
            // 初始化保存每页字符范围的数组
            self.everyPageRanges = [NSMutableArray array];
//            self.everyPageRanges = malloc(estimate * sizeof(NSRange));
//            memset(self.everyPageRanges, 0, estimate * sizeof(NSRange));
            
//            NSRange range = NSMakeRange(0, 1);
//            [NSValue valueWithRange:range] rangeValue

            // 页数
            int page = 0;
            for (int loction = 0; loction < self.strAll.length; ) {
                // 初始化一个范围
                NSRange onePageOnStr = NSMakeRange(loction, onePageInt);
                // 定义一个零时的NSString变量,以便计算每个时候它所占用的高度
                NSString *temporaryStr;
                
                // 用估算出来的范围填充实际laibel,如果小于laibel的高就给它增加一倍,最终使它能超过现有label的高度
                while (onePageOnStr.location + onePageOnStr.length <= self.strAll.length) {
                    temporaryStr = [self.strAll substringWithRange:onePageOnStr];
                    CGSize temporarySize = [temporaryStr sizeWithFont:self.firstLabel.font constrainedToSize:CGSizeMake(self.firstLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
                    if (temporarySize.height < self.firstLabel.frame.size.height) {
                        onePageOnStr.length += onePageInt;
                    }else
                    {
                        break;
                    }
                }
                
                // 当到最后一页时有可能用估算的范围会超出本身实际的NSString的长度,所以要加以处理
                while (onePageOnStr.location + onePageOnStr.length > self.strAll.length) {
                    onePageOnStr.length = self.strAll.length - onePageOnStr.location;
                    break;
                }
                
                // 当超出现有label的临界高度后,再给它本身字符做相减,最终达到字符串的范围正好是laibel的显示字符的数量
                while (onePageOnStr.length > 0) {
                    temporaryStr = [self.strAll substringWithRange:onePageOnStr];
                    CGSize temporarySize = [temporaryStr sizeWithFont:self.firstLabel.font constrainedToSize:CGSizeMake(self.firstLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
                    if (temporarySize.height > self.firstLabel.frame.size.height) {
                        onePageOnStr.length = onePageOnStr.length - 2;
                    }else
                    {
                        break;
                    }
                }
                
                // 保存到NSRange数组中当前页显示的字符串范围
                [self.everyPageRanges addObject:[NSValue valueWithRange:onePageOnStr]];
                page ++;
//                if (page > estimate) {
//                    estimate += 10;
//                    self.everyPageRanges = malloc(estimate * sizeof(NSRange));
//                }else{
//                    self.everyPageRanges[page] = onePageOnStr;
//                    NSLog(@"onePage,loction:%d,length:%d",onePageOnStr.location,onePageOnStr.length);
//                    page ++;
//                }
                
                // 修改loction的值
                loction = onePageOnStr.location + onePageOnStr.length;
            }
            totalPages = page;
        }
        self.firstLabel.text = [self.strAll substringWithRange:[[self.everyPageRanges objectAtIndex:currentPage-1] rangeValue]];
//        NSLog(@"NSRange,loc:%d,len:%d",[[self.everyPageRanges objectAtIndex:currentPage] rangeValue].location,[[self.everyPageRanges objectAtIndex:currentPage] rangeValue].length);
//        NSLog(@"%@",[self.strAll substringWithRange:self.everyPageRanges[currentPage-1]]);
    }
}

- (void)creatToolBar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 460.0f-88.0f, self.view.frame.size.width,  44.0f)];
    [self.view addSubview:toolbar];
    self.toobar = toolbar;
    toolbar.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem *upPage = [[UIBarButtonItem alloc] initWithTitle:@"上一页" style:UIBarButtonItemStylePlain target:self action:@selector(upPageAction)];
    UIBarButtonItem *downPage = [[UIBarButtonItem alloc] initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(downPageAction)];
    UIBarButtonItem *showPage = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%d/%d",currentPage,totalPages] style:UIBarButtonItemStylePlain target:self action:nil];
    self.showPage = showPage;

    UIBarButtonItem *flexible = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]autorelease];

    NSArray *toobarArray = [NSArray arrayWithObjects:flexible,upPage,flexible,downPage,flexible,showPage,flexible, nil];
    [toolbar setItems:toobarArray animated:YES];
    [toolbar release];
    [upPage release];
    [downPage release];
    [showPage release];
}


- (void)downPageAction
{
    if (currentPage < totalPages) {
        // 最终让显示的页面假装翻过去,然后让隐藏的界面显现出来
        if (self.secondLabel) {
            self.firstLabel = self.secondLabel;
//            [self creatTap];
//            self.firstLabel.userInteractionEnabled = YES;
            [self.secondLabel removeFromSuperview];
        }
        
        UILabel* textLabel2 = [[UILabel alloc] init];
        textLabel2.font = [UIFont systemFontOfSize:14];
        textLabel2.textColor = self.textColor;
        textLabel2.backgroundColor = self.color;
        if (setTap == NO) {
            textLabel2.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 460.0f - 88.0f);
        }else
        {
            textLabel2.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 460.0f);
        }
        textLabel2.numberOfLines = 0;
        [self.view addSubview:textLabel2];
        textLabel2.userInteractionEnabled = YES;
        [self creatTapForView:textLabel2];
        self.secondLabel = textLabel2;
        [textLabel2 addSubview:self.firstLabel];

//        if (currentPage == totalPages - 1) {
//            UILabel *label = [[UILabel alloc] init];
//            NSString *str = [self.strAll substringWithRange:self.everyPageRanges[currentPage]];
//            CGSize size = [str sizeWithFont:textLabel2.font constrainedToSize:CGSizeMake(self.firstLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//            label.frame = CGRectMake(0.0f, 0.0f, textLabel2.frame.size.width, size.height);
//            label.font = [UIFont systemFontOfSize:14];
//            label.backgroundColor = [UIColor clearColor];
//            [textLabel2 addSubview:label];
//            label.text = [self.strAll substringWithRange:self.everyPageRanges[currentPage]];
//            [label release];
//        }else
//        {

//        }
        [textLabel2 release];
//        self.secondLabel.userInteractionEnabled = YES;
        
        self.firstLabel.layer.hidden = YES;
        self.secondLabel.text = [self.strAll substringWithRange:[[self.everyPageRanges objectAtIndex:currentPage] rangeValue]];

        // 显示完之后显示第二页;
        currentPage = currentPage + 1;
        CATransition *animation = [CATransition animation];
        [animation setDuration:1.0];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [animation setType:@"pageCurl"];
        [animation setSubtype:kCATransitionFromRight];
        [self.firstLabel.layer addAnimation:animation forKey:@"downPage"];
        [self.secondLabel.layer addAnimation:animation forKey:@"downPage"];
        [self.showPage setTitle:[NSString stringWithFormat:@"%d/%d",currentPage,totalPages]];

    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经看到了最后一页" delegate:nil
        cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [self.view addSubview:alertView];
        [alertView show];
        
        [alertView release];
    }

}

- (void)upPageAction
{
    if (currentPage >= 2) {
        currentPage = currentPage - 1;

        self.firstLabel.layer.hidden = NO;
        self.firstLabel.text = [self.strAll substringWithRange:[[self.everyPageRanges objectAtIndex:currentPage-1] rangeValue]];


        CATransition *animation = [CATransition animation];
        [animation setDuration:1.0];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [animation setType:@"pageUnCurl"];
        [animation setSubtype:kCATransitionFromRight];
        [self.firstLabel.layer addAnimation:animation forKey:@"upPage"];
        [self.secondLabel.layer addAnimation:animation forKey:@"upPage"];
        [self.showPage setTitle:[NSString stringWithFormat:@"%d/%d",currentPage,totalPages]];


    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"本页是首页" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [self.view addSubview:alertView];
        [alertView show];
        
        [alertView release];
       
    }

}

// 点击屏幕执行
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    CGPoint tapPoint = [sender locationInView:self.firstLabel];
//    NSLog(@"%f",tapPoint.y);
    if (tapPoint.y > 50.0f && tapPoint.y < 360.0f) {
        if (setTap == NO) {
            [UIView beginAnimations:@"toobar" context:NULL];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.3];
            self.toobar.frame = CGRectMake(0.0f, self.navigationController.view.frame.size.height, self.view.frame.size.width, 44);
            [UIView commitAnimations];
            //       [self.toobar setHidden:YES];
            
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            
//            [self creatLabel];
//            [self calculateOnePageRangeOnStrAll];
            
            [self creatTapForView:self.firstLabel];
            self.secondLabel.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 460.0f);
            self.firstLabel.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 460.0f);

            
//            [self setWantsFullScreenLayout:YES];
            setTap = YES;


        }else
        {
//            [self creatLabel];
//            [self calculateOnePageRangeOnStrAll];
            [self creatTapForView:self.firstLabel];
            if (currentPage == totalPages-1) {
                self.secondLabel.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 460.0f - 88.0f);
                
            }else{
            self.secondLabel.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 460.0f - 88.0f);
            self.firstLabel.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 460.0f - 88.0f);
            }
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            [UIView beginAnimations:@"toobar" context:NULL];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDuration:0.3];
            self.toobar.frame = CGRectMake(0.0f, self.navigationController.view.frame.size.height-108, self.view.frame.size.width, 44);
            [UIView commitAnimations];
            setTap = NO;
            
            //        [self.toobar setHidden:NO];
        }

    }
    
}


@end







