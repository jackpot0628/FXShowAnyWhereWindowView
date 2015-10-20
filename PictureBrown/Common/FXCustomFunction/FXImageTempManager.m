//
//  FXImageTempManager.m
//  PictureBrown
//
//  Created by Jackpot on 15/2/9.
//  Copyright (c) 2015年 Jackpot. All rights reserved.
//

#import "FXImageTempManager.h"

static FXImageTempManager * _fxImageTempManager = nil;

@implementation FXImageTempManager

/**
 *	@brief	判断图片是否已经请求过，请求过返回Yes,没有返回No
 *
 *	@param 	imageName 	图片名
 *
 *	@return	yesOrNo
 */
+ (BOOL)scanTempArrayWithImageName:(NSString *)imageName
{
    if (_fxImageTempManager == nil)
    {
        _fxImageTempManager = [[FXImageTempManager alloc]init];
        _fxImageTempManager.tempArr = [[NSMutableArray alloc] initWithCapacity:3];
    }
    
    for (NSString * tempImageName in _fxImageTempManager.tempArr)
    {
        if ([tempImageName isEqualToString:imageName])
        {
            // 如果数组中，存在这个图片请求，则直接返回Yes
            return YES;
        }
    }
    // 此图片没有请求过，返回No
    return NO;
}

/**
 *	@brief	将这次请求imageName放入数组
 *
 *	@param 	imageName 	图片名
 */
+ (void)addImageNameToTempArrayWithImageName:(NSString *)imageName
{
    if (_fxImageTempManager == nil)
    {
        _fxImageTempManager = [[FXImageTempManager alloc]init];
        _fxImageTempManager.tempArr = [[NSMutableArray alloc] initWithCapacity:3];
    }
    if ([_fxImageTempManager.tempArr indexOfObject:imageName] == NSNotFound)
    {
        // 如果数组中没有此广告，则将此imageName放入数组
        [_fxImageTempManager.tempArr addObject:imageName];
    }
}

/**
 *	@brief	检查相应的imageName图片是否已经下载完成
 *
 *	@param 	imageName 	图片名
 *
 *	@return	yesOrNo
 */
+ (BOOL)checkOutImgTheDownloadWithImageName:(NSString *)imageName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectroy = [paths lastObject];
    // 图片名
    NSString *filename = imageName;
    // 图片路径
    NSString *filePath = [documentsDirectroy stringByAppendingPathComponent:filename];
    
    NSFileManager * fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:filePath])
    {
        return YES;
    }
    
    return NO;
}

/**
 *	@brief	用来判断图片是否已经全部下载完成
 *
 *	@return	yesOrNo
 */
+ (BOOL)checkOutImgDownLoadAllHaveDone
{
    if (_fxImageTempManager == nil)
    {
        _fxImageTempManager = [[FXImageTempManager alloc]init];
        _fxImageTempManager.tempArr = [[NSMutableArray alloc] initWithCapacity:3];
    }
    
    if ([_fxImageTempManager.tempArr count] == 0 || _fxImageTempManager.tempArr == nil)
    {
        return NO;
    }
    
    for (NSString * adImageName in _fxImageTempManager.tempArr)
    {
        if (![FXImageTempManager checkOutImgTheDownloadWithImageName:adImageName])
        {
            // 存在没有下载完成的图片，则返回No
            return NO;
        }
    }
    
    return YES;
}

/**
 *	@brief	通过传入请求文件的url，获得该文件的文件名
 *
 *	@param 	fileUrl 	请求文件的url NSString
 *
 *	@return	该文件的文件名 NSString
 */
+ (NSString *)getFileNameWithFileUrlStr:(NSString *)fileUrlStr
{
    NSArray * stringArray = [fileUrlStr componentsSeparatedByString:@"/"];
    return [stringArray lastObject];
}

@end
