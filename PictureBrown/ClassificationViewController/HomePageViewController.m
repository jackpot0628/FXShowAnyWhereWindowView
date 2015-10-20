//
//  HomePageViewController.m
//  PictureBrown
//
//  Created by Jackpot on 14/12/4.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import "HomePageViewController.h"


static HomePageViewController * _homePageViewCtr = nil;

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];

    [self creatViewControllerTransitioningWithPanGestureRecognizer];
    
    self.fxBrownCatalogView = [FXBrownCatalogView creatFXBrownCatalogViewInFrame:CGRectMake(20, 50, self.view.frame.size.width - 40, 40) withCatalogName:@"测试目录" onView:self.view];
    
    NSMutableArray * tempCatalogLevelArray = [NSMutableArray arrayWithCapacity:1];
    for (int n = 0;n < 5; n++)
    {
        NSMutableArray * tempCatalogTypeArray = [NSMutableArray arrayWithCapacity:1];
        for (int i = 0;i <= n; i++)
        {
            NSMutableArray * tempObjArray = [NSMutableArray arrayWithCapacity:1];
            for (int j = 1; j <= 3; j++)
            {
                FXCatalogObject * fxObj = [FXCatalogObject fxCatalogObjectWithName:[NSString stringWithFormat:@"对象 %d",j] AndWithKey:@"" AndWithValue:@""];
                [tempObjArray addObject:fxObj];
            }
            
            FXCatalogTypeObject * fxTypeObj = [FXCatalogTypeObject fxcatalogTypeObjectWithName:[NSString stringWithFormat:@"分类 %d",i] AndWithCatalogObjectArray:tempObjArray];
            [tempCatalogTypeArray addObject:fxTypeObj];
        }
        
        FXCatalogLevelObject * fxLevelObj = [FXCatalogLevelObject fxCatalogLevelObjectWithName:[NSString stringWithFormat:@"层级 %d",n] AndFXCataLogTypeObjectArray:tempCatalogTypeArray];
        [tempCatalogLevelArray addObject:fxLevelObj];
    }
    
    
    // 创建目录view
    [self.fxBrownCatalogView reCreatCatalogWithCatalogLevelObjectArray:tempCatalogLevelArray];
    
    [tempCatalogLevelArray removeAllObjects];
    
    [self.view addSubview:self.fxBrownCatalogView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (HomePageViewController *)shareInitialize
{
    if (_homePageViewCtr == nil)
    {
        _homePageViewCtr = [[HomePageViewController alloc]initWithNibName:@"HomePageViewController" bundle:nil];
    }
    return _homePageViewCtr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
