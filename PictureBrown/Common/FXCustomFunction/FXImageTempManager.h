//
//  FXImageTempManager.h
//  PictureBrown
//
//  Created by Jackpot on 15/2/9.
//  Copyright (c) 2015年 Jackpot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXImageTempManager : NSObject

@property (strong, nonatomic) NSMutableArray * tempArr; // 用来记录已经请求的图片名称


/**
 *	@brief	判断图片是否已经请求过，请求过返回Yes,没有返回No
 *
 *	@param 	imageName 	图片名
 *
 *	@return	yesOrNo
 */
+ (BOOL)scanTempArrayWithImageName:(NSString *)imageName;

/**
 *	@brief	将这次请求imageName放入数组
 *
 *	@param 	imageName 	图片名
 */
+ (void)addImageNameToTempArrayWithImageName:(NSString *)imageName;

/**
 *	@brief	检查相应的imageName图片是否已经下载完成
 *
 *	@param 	imageName 	图片名
 *
 *	@return	yesOrNo
 */
+ (BOOL)checkOutImgTheDownloadWithImageName:(NSString *)imageName;

/**
 *	@brief	用来判断图片是否已经全部下载完成
 *
 *	@return	yesOrNo
 */
+ (BOOL)checkOutImgDownLoadAllHaveDone;

/**
 *	@brief	通过传入请求文件的url，获得该文件的文件名
 *
 *	@param 	fileUrl 	请求文件的url NSString
 *
 *	@return	该文件的文件名 NSString
 */
+ (NSString *)getFileNameWithFileUrlStr:(NSString *)fileUrlStr;

@end
