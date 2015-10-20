//
//  FXBrownCatalogView.m
//  PictureBrown
//
//  Created by Jackpot on 14/12/4.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import "FXBrownCatalogView.h"
#import "FXCatalogTable.h"

#define FXLEVEL_BUTTOM_TITLE_COLOR [UIColor blackColor]
#define FXLEVEL_BUTTON_TITLE_FONT [UIFont systemFontOfSize:15]

#define MAX_OF_BUTTON_WIDTH 160

static FXBrownCatalogView * _fxbrownCatalogView = nil;

@implementation FXBrownCatalogView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (FXBrownCatalogView *)shareInitialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _fxbrownCatalogView = [[self alloc]init];
        _fxbrownCatalogView.levelBtnArray = [NSMutableArray arrayWithCapacity:3];
        _fxbrownCatalogView.catalogTable = [FXCatalogTable sharedInitialize];
        _fxbrownCatalogView.catalogTable.fxCataLogTabelDelegate = _fxbrownCatalogView;
    });
    return _fxbrownCatalogView;
}

+ (FXBrownCatalogView *)creatFXBrownCatalogViewInFrame:(CGRect)frame withCatalogName:(NSString *)catalogName onView:(UIView *)view
{
    FXBrownCatalogView * fxbcv = [self shareInitialize];
    
    [fxbcv setFrame:frame];
    
    // 将catalogTable添加到所需要显示的view上
    [view addSubview:fxbcv.catalogTable];
    
    // 获得按钮标题长度
    if (catalogName == nil)
    {
        catalogName = @"";
    }
    
    CGSize titleFontSize = [catalogName boundingRectWithSize:CGSizeMake(MAX_OF_BUTTON_WIDTH, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FXLEVEL_BUTTON_TITLE_FONT} context:nil].size;
    
    // 创建目录标题
    if (fxbcv.catalogNameLabel == nil)
    {
        fxbcv.catalogNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleFontSize.width, frame.size.height)];
        
        [fxbcv.catalogNameLabel setFont:FXLEVEL_BUTTON_TITLE_FONT];
        
        [fxbcv addSubview:fxbcv.catalogNameLabel];
    }
    else
    {
        [fxbcv.catalogNameLabel setFrame:CGRectMake(10, 0, titleFontSize.width, frame.size.height)];
    }
    
    [fxbcv.catalogNameLabel setAttributedText:[[NSAttributedString alloc]initWithString:catalogName]];
    
    return fxbcv;
}

/**
 *	@brief	创建目录按钮
 *
 *	@param 	btnTitle 	目录按钮标题
 *	@param 	titleColor 	按钮标题
 *
 *	@return	创建的按钮
 */
- (UIButton *)creatLevelBtnWithTitle:(NSString *)btnTitle WithTitleColor:(UIColor *)titleColor AndWithFont:(UIFont *)textFont

{
    FXBrownCatalogView * fxbcv = [FXBrownCatalogView shareInitialize];
    
    UIButton * nowCreatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [nowCreatBtn.titleLabel setFont:textFont];
    
    [nowCreatBtn setBackgroundColor:[UIColor clearColor]];
    
    [nowCreatBtn addTarget:self action:@selector(showLevelList:) forControlEvents:UIControlEventTouchUpInside];
    
    if (btnTitle == nil)
    {
        btnTitle = [NSString stringWithFormat:@"标题 %d",[fxbcv.levelBtnArray count]];
    }

    [nowCreatBtn setTitle:btnTitle forState:UIControlStateNormal];
    
    [nowCreatBtn setTag:[fxbcv.levelBtnArray count]]; // levelButtonTag = 目录层级
    
    [nowCreatBtn setTitleColor:titleColor forState:UIControlStateNormal];
    
    // 获得按钮标题长度
    CGSize titleFontSize = [btnTitle boundingRectWithSize:CGSizeMake(MAX_OF_BUTTON_WIDTH, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size;
    
    if ([fxbcv.levelBtnArray count] == 0)
    {
        [nowCreatBtn setFrame:CGRectMake(self.catalogNameLabel.frame.origin.x + self.catalogNameLabel.frame.size.width + 30, 0, titleFontSize.width, fxbcv.frame.size.height)];
    }
    else
    {
        UIButton * lastLevelBtn = [fxbcv.levelBtnArray objectAtIndex:[fxbcv.levelBtnArray count] - 1];
        
        [nowCreatBtn setFrame:CGRectMake(lastLevelBtn.frame.origin.x + lastLevelBtn.frame.size.width + 30, 0, titleFontSize.width, fxbcv.frame.size.height)];
    }
    
    [self addSubview:nowCreatBtn];
    
    return nowCreatBtn;
}

- (void)showLevelList:(UIButton *)levelBtn
{
    self.nowSelectedLevel = levelBtn.tag; // 记录现在选择的层级
    
    // 准备相应列表
    FXCatalogLevelObject * catalogLevelObj = [self.cataLogLevelArray objectAtIndex:self.nowSelectedLevel];
    
    // 这里设置的listInPoint是相对于FXBrownCatalogView在其父View上的位置，因为table需要显示在其父View上
    self.catalogTable = [FXCatalogTable readyListInPoint:CGPointMake(self.frame.origin.x + levelBtn.center.x - self.catalogTable.frame.size.width / 2, self.frame.origin.x + self.frame.size.height + levelBtn.frame.origin.y + levelBtn.frame.size.height + 20) WithCatalogTypeObjectArray:catalogLevelObj.catalogTypeObjectArray];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(fxBrownCatalogView:didSelectLevel:)])
    {
        // 返回所选择的目录层级
        [self.delegate fxBrownCatalogView:self didSelectLevel:self.nowSelectedLevel];
    }
    
    [self.catalogTable doShowTableList];
}

- (void)reCreatCatalogWithCatalogLevelObjectArray:(NSArray *)catalogLevelObjectArray
{
    // 记录新的FXCatalogLevelObjectArray数组
    self.cataLogLevelArray = [NSMutableArray arrayWithArray:catalogLevelObjectArray];
    // 清空当前的目录
    [self.levelBtnArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.levelBtnArray removeAllObjects];
    
    for (FXCatalogLevelObject * fxcllo in self.cataLogLevelArray)
    {
        [self.levelBtnArray addObject:[self creatLevelBtnWithTitle:fxcllo.levelName WithTitleColor:FXLEVEL_BUTTOM_TITLE_COLOR AndWithFont:FXLEVEL_BUTTON_TITLE_FONT]]; // 加入数组 方便管理
        ;
    }
}

- (void)addLevelBtnWithFXCatalogLevelObj:(FXCatalogLevelObject *)catalogLevelObj witchLevel:(NSInteger)levelNum
{
    if (self.cataLogLevelArray.count > levelNum + 1)
    {
        // 去掉所要添加按钮level之后的所有levelbtn
        NSRange needRemoveRange = NSMakeRange(levelNum + 1, self.cataLogLevelArray.count - levelNum - 1);
        
        [self.cataLogLevelArray removeObjectsInRange:needRemoveRange];
    }
    
    [self.cataLogLevelArray addObject:catalogLevelObj];
    
    [self.levelBtnArray addObject:[self creatLevelBtnWithTitle:catalogLevelObj.levelName WithTitleColor:FXLEVEL_BUTTOM_TITLE_COLOR AndWithFont:FXLEVEL_BUTTON_TITLE_FONT]];
}

- (void)reloadLevelBtnTitleWithString:(NSString *)title WitchLevel:(NSInteger)levelNum
{
    if (self.cataLogLevelArray.count > levelNum + 1)
    {
        // 去掉所要添加按钮level之后的所有levelbtn
        NSRange needRemoveRange = NSMakeRange(levelNum + 1, self.cataLogLevelArray.count - levelNum - 1);
        
        [self.cataLogLevelArray removeObjectsInRange:needRemoveRange];
        
        [self reCreatCatalogWithCatalogLevelObjectArray:self.cataLogLevelArray];
    }
    
    UIButton * levelBtn = [self.levelBtnArray objectAtIndex:levelNum];
    [levelBtn setTitle:title forState:UIControlStateNormal];
}

#pragma mark - FXCatalogTableDelegate

- (void)fxcatalogTable:(FXCatalogTable *)fxcatalogTable didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择了 Level = %d,Section = %d,Row = %d",self.nowSelectedLevel,indexPath.section,indexPath.row);
    
    FXCatalogLevelObject * levelObj = [self.cataLogLevelArray objectAtIndex:self.nowSelectedLevel];
    
    FXCatalogTypeObject * typeObj = [levelObj.catalogTypeObjectArray objectAtIndex:indexPath.section];
    
    FXCatalogObject * catalogObj = [typeObj.catalogObjectArray objectAtIndex:indexPath.row];
    
    [self reloadLevelBtnTitleWithString:catalogObj.objName WitchLevel:self.nowSelectedLevel];
    
    [self.delegate fxBrownCatalogView:self didSelectObject:catalogObj];
}

@end
