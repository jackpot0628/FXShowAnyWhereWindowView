//
//  FXShowAnyWhereWindowView.m
//  HairStylist
//
//  Created by Jackpot on 14/12/17.
//  Copyright (c) 2014年 SookinMac04. All rights reserved.
//

#import "FXShowAnyWhereWindowView.h"



@interface FXShowAnyWhereWindowView () {
    
}

@property (strong, nonatomic) completeBlock whenShowBlock;

@property (strong, nonatomic) completeBlock whenDismissBlock;

@end

#define FXSHOWANYWHERE_ANIMATIONDURATION 0.3
static FXShowAnyWhereWindowView * _fxShowAnyWhere = nil;

@implementation FXShowAnyWhereWindowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (FXShowAnyWhereWindowView *)shareInitialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _fxShowAnyWhere = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _fxShowAnyWhere.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _fxShowAnyWhere.userInteractionEnabled = YES;
        
        // 创建一个触摸事件，用于点击关闭Nav
        _fxShowAnyWhere.tapGR = [[UITapGestureRecognizer alloc]initWithTarget:_fxShowAnyWhere action:@selector(tapClose)];
        [_fxShowAnyWhere addGestureRecognizer:_fxShowAnyWhere.tapGR];
        _fxShowAnyWhere.tapGR.delegate = _fxShowAnyWhere;
        
        _fxShowAnyWhere.isShown = NO;
    });
    return _fxShowAnyWhere;
}

+ (void)showFxViewInCenter:(CGPoint)point WithView:(UIView *)needShowView whenShow:(completeBlock)showBlock {
    
    FXShowAnyWhereWindowView * fxAnyWhereView = [self shareInitialize];
    
    __weak typeof(FXShowAnyWhereWindowView) *weakFxAnyWhereView = fxAnyWhereView;
    weakFxAnyWhereView.whenShowBlock = ^() {
        if (showBlock) {
            showBlock();
        }
    };
    
    
    if (fxAnyWhereView.isShown)
    {
        return;
    }
    
    if (fxAnyWhereView.backgroundView != nil)
    {
        // 先清除上一次的view
        [fxAnyWhereView.backgroundView removeFromSuperview];
    }
    fxAnyWhereView.backgroundView = needShowView;
    [fxAnyWhereView.backgroundView setAlpha:0.0];
    [fxAnyWhereView addSubview:fxAnyWhereView.backgroundView];
    [fxAnyWhereView.backgroundView setCenter:point];
    
    [fxAnyWhereView makeKeyAndVisible]; //显示window
    
    [UIView animateWithDuration:FXSHOWANYWHERE_ANIMATIONDURATION animations:^{
        fxAnyWhereView.whenShowBlock();
        [fxAnyWhereView.backgroundView setAlpha:1.0];
    }completion:^(BOOL finished) {
        
    }];
    
}

+ (void)dismissFxAnyWhereViewWhenDismiss:(completeBlock)whenDismissBlock {
    
    FXShowAnyWhereWindowView * fxAnyWhereView = [self shareInitialize];
    
    __weak typeof(FXShowAnyWhereWindowView) *weakFxAnyWhereView = fxAnyWhereView;
    weakFxAnyWhereView.whenDismissBlock = ^() {
        if (whenDismissBlock) {
            whenDismissBlock();
        }
    };
    
    fxAnyWhereView.whenDismissBlock();
    
    [UIView animateWithDuration:FXSHOWANYWHERE_ANIMATIONDURATION animations:^{
        [fxAnyWhereView.backgroundView setAlpha:0.0];
        
    }completion:^(BOOL finished) {
        
        NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
        [windows removeObject:fxAnyWhereView];
        
        [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
            if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
                [window makeKeyAndVisible];
                *stop = YES;
            }
        
        }];
        
        fxAnyWhereView.isShown = NO;
    }];
}

- (void)tapClose
{
    [FXShowAnyWhereWindowView dismissFxAnyWhereViewWhenDismiss:self.whenDismissBlock];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"%@",NSStringFromClass([touch.view class]));
    
    if (gestureRecognizer == self.tapGR)
    {
        if ([NSStringFromClass([touch.view class]) isEqualToString:@"FXShowAnyWhereWindowView"])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}


@end
