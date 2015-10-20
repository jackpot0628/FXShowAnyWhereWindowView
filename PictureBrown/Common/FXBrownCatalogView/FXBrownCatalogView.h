//
//  FXBrownCatalogView.h
//  PictureBrown
//
//  Created by Jackpot on 14/12/4.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXCatalogLevelObject.h"

@class FXBrownCatalogView;
@class FXCatalogTable;

@protocol FXBrownCatalogViewDelegate <NSObject>

- (void)fxBrownCatalogView:(FXBrownCatalogView *)fxBrownCatalogView didSelectObject:(FXCatalogObject *)fxCatalogObj;

@optional

- (void)fxBrownCatalogView:(FXBrownCatalogView *)fxBrownCatalogView didSelectLevel:(NSInteger)level;

@end

@interface FXBrownCatalogView : UIView

@property (weak, nonatomic) id<FXBrownCatalogViewDelegate> delegate;

@property (nonatomic) NSInteger nowSelectedLevel; // 现在所选择的目录层级

@property (strong, nonatomic) NSMutableArray * levelBtnArray; // 用来存放和管理目录按钮

@property (strong, nonatomic) NSMutableArray * cataLogLevelArray; // 目录对象数组

@property (strong, nonatomic) UILabel * catalogNameLabel;

@property (strong, nonatomic) FXCatalogTable * catalogTable; // 目录列表


+ (FXBrownCatalogView *)creatFXBrownCatalogViewInFrame:(CGRect)frame withCatalogName:(NSString *)catalogName onView:(UIView *)view;

- (void)reCreatCatalogWithCatalogLevelObjectArray:(NSArray *)catalogLevelObjectArray;

- (void)addLevelBtnWithFXCatalogLevelObj:(FXCatalogLevelObject *)catalogLevelObj witchLevel:(NSInteger)level;

- (void)reloadLevelBtnTitleWithString:(NSString *)title WitchLevel:(NSInteger)levelNum;

@end
