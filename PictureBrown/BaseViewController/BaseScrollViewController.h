//
//  BaseScrollViewController.h
//  PictureBrown
//
//  Created by Jackpot on 14/12/16.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseScrollViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
