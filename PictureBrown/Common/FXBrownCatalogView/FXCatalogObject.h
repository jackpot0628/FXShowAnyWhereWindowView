//
//  FXCatalogObject.h
//  PictureBrown
//
//  Created by Jackpot on 14/12/5.
//  Copyright (c) 2014年 Jackpot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXCatalogObject : NSObject

@property (strong, nonatomic) NSString * objName;

@property (strong, nonatomic) NSString * objKey;

@property (strong, nonatomic) NSString * objValue;

+ (FXCatalogObject *)fxCatalogObjectWithName:(NSString *)objName
                                  AndWithKey:(NSString *)objKey
                                AndWithValue:(NSString *)objValue;

@end
