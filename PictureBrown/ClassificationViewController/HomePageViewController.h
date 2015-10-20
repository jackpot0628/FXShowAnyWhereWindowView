//
//  HomePageViewController.h
//  PictureBrown
//
//  Created by Jackpot on 14/12/4.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import "BaseViewController.h"
#import "FXBrownCatalogView.h"

@interface HomePageViewController : BaseViewController<FXBrownCatalogViewDelegate>

@property (strong, nonatomic) FXBrownCatalogView * fxBrownCatalogView;

+ (HomePageViewController *)shareInitialize;

@end
