//
//  FXCatalogTable.h
//  PictureBrown
//
//  Created by Jackpot on 14/12/10.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXCatalogLevelObject.h"

#define FXTABLE_MAX_WIDTH             200
#define FXTABLE_MAX_HEIGHT            440
#define FXTABLE_ROW_HEIGHT            48
#define FXTABLE_SECTION_HEIGHT        20
#define FXTABLE_ANIMATION_DURATION    0.3
#define FXTABLE_TABLE_BACKGROUNCOLOR  [UIColor blackColor]
#define FXTABLE_CELL_TEXT_COLOR       [UIColor whiteColor]
#define FXTABLE_TEXTLABEL_FONT [UIFont systemFontOfSize:17]

@class FXCatalogTable;

@protocol FXCatalogTableDelegate <NSObject>

- (void)fxcatalogTable:(FXCatalogTable *)fxcatalogTable didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FXCatalogTable : UIView<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) id<FXCatalogTableDelegate> fxCataLogTabelDelegate;

@property (strong, nonatomic) UIImageView * tableBackgroundImageView;

@property (strong, nonatomic) UITableView * catalogTableView;

@property (strong, nonatomic) NSMutableArray * catalogListArray; // 存放FXCatalogTypeObject对象的数组，每个对象表示table中的一个sectioin

@property (nonatomic) CGRect targetRect; // 记录这次需要显示的Rect
@property (nonatomic) CGRect lastTimeRect; // 记录最后一次显示的Rect

+ (FXCatalogTable *)sharedInitialize;

+ (FXCatalogTable * )readyListInPoint:(CGPoint)point WithCatalogTypeObjectArray:(NSArray *)catalogTypeObjectArray;

- (void)doShowTableList;

- (void)doDismissTableList;

@end
