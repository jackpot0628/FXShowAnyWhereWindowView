//
//  FXCatalogTable.m
//  PictureBrown
//
//  Created by Jackpot on 14/12/10.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import "FXCatalogTable.h"

static FXCatalogTable * _fxcatalogTable = nil;

@implementation FXCatalogTable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.tableBackgroundImageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.catalogTableView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}


+ (FXCatalogTable *)sharedInitialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _fxcatalogTable = [[self alloc]init];
        _fxcatalogTable.catalogTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FXTABLE_MAX_WIDTH, 0) style:UITableViewStylePlain];
        _fxcatalogTable.tableBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FXTABLE_MAX_WIDTH, 0)];
        [_fxcatalogTable.tableBackgroundImageView setAlpha:0.8];
        
        [_fxcatalogTable setFrame:CGRectMake(0, 0, FXTABLE_MAX_WIDTH, 0)];
        [_fxcatalogTable setBackgroundColor:[UIColor clearColor]];
        [_fxcatalogTable.catalogTableView setBackgroundColor:[UIColor clearColor]];
        
        [_fxcatalogTable.tableBackgroundImageView setBackgroundColor:FXTABLE_TABLE_BACKGROUNCOLOR];
        [_fxcatalogTable addSubview:_fxcatalogTable.tableBackgroundImageView];
        [_fxcatalogTable addSubview:_fxcatalogTable.catalogTableView];
        _fxcatalogTable.catalogTableView.delegate = _fxcatalogTable;
        _fxcatalogTable.catalogTableView.dataSource = _fxcatalogTable;
        _fxcatalogTable.catalogTableView.showsHorizontalScrollIndicator = NO;
        _fxcatalogTable.catalogTableView.showsVerticalScrollIndicator = NO;
        
        [_fxcatalogTable setAlpha:0.0];
        [_fxcatalogTable setHidden:YES];
        _fxcatalogTable.layer.cornerRadius = FXTABLE_MAX_WIDTH * 0.02;
        [_fxcatalogTable setClipsToBounds:YES];
    });
    return _fxcatalogTable;
}

+ (FXCatalogTable *)readyListInPoint:(CGPoint)point WithCatalogTypeObjectArray:(NSArray *)catalogTypeObjectArray
{
    FXCatalogTable * tableView = [self sharedInitialize];
    NSInteger numOfRow = 0;
    NSInteger numOfSection = [catalogTypeObjectArray count];
    for (FXCatalogTypeObject * catalogTypeObj in catalogTypeObjectArray)
    {
        numOfRow += [catalogTypeObj.catalogObjectArray count];
    }
    
    CGRect nowTargetRect = CGRectMake(point.x, point.y, FXTABLE_MAX_WIDTH, numOfRow * FXTABLE_ROW_HEIGHT + numOfSection * FXTABLE_SECTION_HEIGHT);
    
    if (nowTargetRect.size.height >= FXTABLE_MAX_HEIGHT)
    {
        nowTargetRect  = CGRectMake(point.x, point.y, FXTABLE_MAX_WIDTH, FXTABLE_MAX_HEIGHT);
    }
    
    [tableView setFrame:nowTargetRect]; // 设置frame
    
    tableView.targetRect = nowTargetRect; // 记录这次需要显示列表的frame
    
    tableView.catalogListArray = [NSMutableArray arrayWithArray:catalogTypeObjectArray];
    
    [tableView.catalogTableView reloadData];
    
    return tableView;
}

- (void)doShowTableList
{
    if (self.lastTimeRect.origin.x <=0 && self.lastTimeRect.origin.x <=0)
    {
        [self setFrame:CGRectMake(self.targetRect.origin.x, self.targetRect.origin.y, self.targetRect.size.width, 0)];
    }
    else
    {
        [self setFrame:CGRectMake(self.lastTimeRect.origin.x, self.lastTimeRect.origin.y, self.lastTimeRect.size.width, self.lastTimeRect.size.height)];
    }
    
    [self setHidden:NO];
    [UIView animateWithDuration:FXTABLE_ANIMATION_DURATION animations:^{
        [self setFrame:CGRectMake(self.targetRect.origin.x, self.targetRect.origin.y, self.targetRect.size.width, self.targetRect.size.height)];
        [self setAlpha:1.0];
    } completion:^(BOOL finished) {
        ;
    }];
    
    self.lastTimeRect = self.targetRect; // 记录为最后一次的Rect
}

- (void)doDismissTableList
{
    [UIView animateWithDuration:FXTABLE_ANIMATION_DURATION animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0)];
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
    }];
    
    self.lastTimeRect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0); // 记录为最后一次的Rect
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.catalogListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FXCatalogTypeObject * fxcto = [self.catalogListArray objectAtIndex:section];
    return fxcto.catalogObjectArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    //    if (self.catalogListArray.count <= 1)
    //    {
    //        return nil;
    //    }
    //    else
    //    {
    FXCatalogTypeObject * fxcto = [self.catalogListArray objectAtIndex:section];
    return fxcto.typeName;
    //    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView numberOfSections] == 1)
    {
        // 如果只有一个section
        return 0;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == [self numberOfSectionsInTableView:tableView] + 1)
    {
        return [UIView new];
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FXCatalogTypeObject * fxcto = [self.catalogListArray objectAtIndex:indexPath.section];
    FXCatalogObject *fxco = [fxcto.catalogObjectArray objectAtIndex:indexPath.row];
    
    static NSString * CellIdentifier = @"CellIdentifer";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [cell.textLabel setTextColor:FXTABLE_CELL_TEXT_COLOR];
    [cell.textLabel setFont:FXTABLE_TEXTLABEL_FONT];
    [cell.textLabel setText:fxco.objName];
    
    //    NSLog(@"----%@---- %@",fxco.objName,cell);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FXCatalogTypeObject * fxcto = [self.catalogListArray objectAtIndex:indexPath.section];
    FXCatalogObject *fxco = [fxcto.catalogObjectArray objectAtIndex:indexPath.row];
    
    NSLog(@"selected : %@",fxco);
    
    [self.fxCataLogTabelDelegate fxcatalogTable:self didSelectRowAtIndexPath:indexPath];
    
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
