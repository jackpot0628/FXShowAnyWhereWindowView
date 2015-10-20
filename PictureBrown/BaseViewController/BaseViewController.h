//
//  BaseViewController.h
//  PictureBrown
//
//  Created by Jackpot on 14/12/4.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>

#pragma mark - 创建viewController交互手势

- (void)creatViewControllerTransitioningWithPanGestureRecognizer;

#pragma mark - Navigation设置相关

/**
 *	@brief	设置显示在navigation上的标题
 *
 *	@param 	title 	标题NSString
 */
- (void)setNavigationTitle:(NSString *)title;

/**
 *	@brief	显示navigationBar
 *
 *	@param 	yesOrNo 	是否动画
 */
- (void)showNavigationWithAnimation:(BOOL)yesOrNo;

/**
 *	@brief	隐藏navigationBar
 *
 *	@param 	yesOrNo 	是否动画
 */
- (void)dismissNavigationWithAnimation:(BOOL)yesOrNo;
@end
