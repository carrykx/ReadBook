//
//  CustomTabbarViewController.m
//  ReadBook
//
//  Created by carry on 13-4-15.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "CustomTabbarViewController.h"
#import "RecommendViewController.h"
#import "BoardViewController.h"
#import "SearchViewController.h"
#import "BookmarkViewController.h"
#import "MoreViewController.h"

@interface CustomTabbarViewController ()

@end

@implementation CustomTabbarViewController

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
    
    // 推荐
    RecommendViewController *rec = [[RecommendViewController alloc] init];
    UINavigationController *recNav = [[UINavigationController alloc] initWithRootViewController:rec];
    [rec release];
    
    // 精选
    BoardViewController *boa = [[BoardViewController alloc] init];
    UINavigationController *boaNav = [[UINavigationController alloc] initWithRootViewController:boa];
    [boa release];
    
    // 搜索
    SearchViewController *sea = [[SearchViewController alloc] init];
    UINavigationController *seaNav = [[UINavigationController alloc] initWithRootViewController:sea];
    [sea release];
    
    // 书签
    BookmarkViewController *book = [[BookmarkViewController alloc] init];
    UINavigationController *bookNav = [[UINavigationController alloc] initWithRootViewController:book];
    [book release];
    
    // 更多
    MoreViewController *mor = [[MoreViewController alloc] init];
    UINavigationController *morNav = [[UINavigationController alloc] initWithRootViewController:mor];
    [mor release];
    
    self.viewControllers = [NSArray arrayWithObjects:recNav,boaNav,seaNav,bookNav,morNav, nil];
    [recNav release];
    [boaNav release];
    [seaNav release];
    [bookNav release];
    [morNav release];
    
    self.selectedIndex = 1;
    [(UITabBarItem*)[self.tabBar.items objectAtIndex:0] setTitle:@"推荐"];
    [(UITabBarItem*)[self.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"tabbar_home.png"]];
    [(UITabBarItem*)[self.tabBar.items objectAtIndex:1] setTitle:@"精选"];
    [(UITabBarItem*)[self.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"tabbar_rec.png"]];
    [(UITabBarItem*)[self.tabBar.items objectAtIndex:2] setTitle:@"搜索"];
    [(UITabBarItem*)[self.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"3.png"]];
    [(UITabBarItem*)[self.tabBar.items objectAtIndex:3] setTitle:@"书签"];
    [(UITabBarItem*)[self.tabBar.items objectAtIndex:3] setImage:[UIImage imageNamed:@"tabbar_mark.png"]];
    [(UITabBarItem*)[self.tabBar.items objectAtIndex:4] setTitle:@"更多"];
    [(UITabBarItem*)[self.tabBar.items objectAtIndex:4] setImage:[UIImage imageNamed:@"3.png"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end






