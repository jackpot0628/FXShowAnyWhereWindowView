//
//  FXCatalogTypeObject.m
//  PictureBrown
//
//  Created by Jackpot on 14/12/9.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import "FXCatalogTypeObject.h"

@implementation FXCatalogTypeObject

+ (FXCatalogTypeObject *)fxcatalogTypeObjectWithName:(NSString *)typeName
                           AndWithCatalogObjectArray:(NSArray *)catalogObjArray
{
    FXCatalogTypeObject * fxcto = [[FXCatalogTypeObject alloc]init];
    fxcto.typeName = [NSString stringWithString:typeName];
    fxcto.catalogObjectArray = [NSArray arrayWithArray:catalogObjArray];
    
    return fxcto;
}

@end
