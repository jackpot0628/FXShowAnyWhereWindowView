//
//  FXShowAnyWhereWindowView.h
//  HairStylist
//
//  Created by Jackpot on 14/12/17.
//  Copyright (c) 2015年 付祥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^completeBlock) (void);

@interface FXShowAnyWhereWindowView : UIWindow<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView * backgroundView;

@property (nonatomic) BOOL isShown; // 判断是否已经显示

@property (strong, nonatomic) UITapGestureRecognizer * tapGR; // background以外的地方，可以使window消失


+ (void)showFxViewInCenter:(CGPoint)point WithView:(UIView *)needShowView whenShow:(completeBlock)showBlock;

+ (void)dismissFxAnyWhereViewWhenDismiss:(completeBlock)whenDismissBlock;

@end
