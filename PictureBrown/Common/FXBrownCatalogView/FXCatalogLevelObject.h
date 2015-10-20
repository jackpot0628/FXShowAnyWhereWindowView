//
//  FXCatalogLevelObject.h
//  PictureBrown
//
//  Created by Jackpot on 14/12/6.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXCatalogTypeObject.h"

@interface FXCatalogLevelObject : NSObject

@property (strong, nonatomic) NSString * levelName;

@property (strong, nonatomic) NSArray * catalogTypeObjectArray;

+ (FXCatalogLevelObject *)fxCatalogLevelObjectWithName:(NSString *)levelName
                           AndFXCataLogTypeObjectArray:(NSArray *)array;

@end
