//
//  FXCatalogObject.m
//  PictureBrown
//
//  Created by Jackpot on 14/12/5.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import "FXCatalogObject.h"

@implementation FXCatalogObject

+ (FXCatalogObject *)fxCatalogObjectWithName:(NSString *)objName
                                  AndWithKey:(NSString *)objKey
                                AndWithValue:(NSString *)objValue
{
    FXCatalogObject * fxcatalogObject = [[FXCatalogObject alloc]init];
    fxcatalogObject.objName = [NSString stringWithString:objName];
    fxcatalogObject.objKey = [NSString stringWithString:objKey];
    fxcatalogObject.objValue = [NSString stringWithString:objValue];
    return fxcatalogObject;
}

@end
