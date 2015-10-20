//
//  FXCatalogLevelObject.m
//  PictureBrown
//
//  Created by Jackpot on 14/12/6.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import "FXCatalogLevelObject.h"

@implementation FXCatalogLevelObject

+ (FXCatalogLevelObject *)fxCatalogLevelObjectWithName:(NSString *)levelName
                           AndFXCataLogTypeObjectArray:(NSArray *)array
{
    FXCatalogLevelObject * fxcatalogLevelObj = [[FXCatalogLevelObject alloc]init];
    fxcatalogLevelObj.levelName = [NSString stringWithString:levelName];
    fxcatalogLevelObj.catalogTypeObjectArray = [NSArray arrayWithArray:array];
    
    return fxcatalogLevelObj;
}

@end
