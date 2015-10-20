//
//  ViewController.m
//  PictureBrown
//
//  Created by Jackpot on 14/12/4.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import "ViewController.h"
#import "HomePageViewController.h"

static ViewController * _viewController = nil;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (ViewController *)shareInitialize
{
    if (_viewController == nil)
    {
        _viewController = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    }
    return _viewController;
}

- (IBAction)enterAction:(id)sender
{
    HomePageViewController * homePageViewCtr = [HomePageViewController shareInitialize];
    [self.navigationController pushViewController:homePageViewCtr animated:YES];
}
@end
