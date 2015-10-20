//
//  FXCatalogTypeObject.h
//  PictureBrown
//
//  Created by Jackpot on 14/12/9.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXCatalogObject.h"

@interface FXCatalogTypeObject : NSObject

@property (strong, nonatomic) NSString * typeName; // 分类名

@property (strong, nonatomic) NSArray * catalogObjectArray; // 此类下的catalogObject

+ (FXCatalogTypeObject *)fxcatalogTypeObjectWithName:(NSString *)typeName
                           AndWithCatalogObjectArray:(NSArray *)catalogObjArray;

@end
