//
//  FXCustomFunction.h
//  PictureBrown
//
//  Created by Jackpot on 15/1/1.
//  Copyright (c) 2015年 Jackpot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FXCustomFunction : NSObject

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
+ (NSURL *)applicationDocumentsDirectory;

#pragma mark - 关于NSDate相关方法

/**
 *	@brief	获取时间NSString
 *
 *	@param 	cDate 	NSDate
 *	@param 	formatterStr 	传入nil 默认为@"yyyy-MM-dd HH:mm:ss"
 *
 *	@return	以NSString返回时间
 */
+ (NSString *)getDateNowWithNSDate:(NSDate *)cDate
               AndWithFormatterStr:(NSString *)formatterStr;

/**
 *	@brief	由NSString根据格式返回NSDate对象
 *
 *	@param 	dateStr 	时间NSString
 *	@param 	formatterStr 	时间格式 传入nil默认为@"yyyy-MM-dd HH:mm:ss"
 *
 *	@return	NSDate
 */
+ (NSDate *)getDateWithDateString:(NSString *)dateStr
              AndWithFormatterStr:(NSString *)formatterStr;

/**
 *	@brief	返回两个NSDate时间间隔多少秒
 *
 *	@param 	startDate 	开始时间NSDate
 *	@param 	endDate 	结束时间NSDate
 *
 *	@return	NSInteger   秒
 */
+ (NSInteger)returnIntervalSecondBetweenStartDate:(NSDate *)startDate withEndDate:(NSDate *)endDate;

/**
 *	@brief	判断指定的date是否在两个date之间
 *
 *	@param 	date 	需要判断的date
 *	@param 	beginDate 	开始时间date
 *	@param 	endDate 	结束时间date
 *
 *	@return	YesOrNo
 */
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;

/**
 *	@brief	通过传入时\分\秒，拼接成相应完整的date
 *
 *	@param 	hour 	NSInteger
 *	@param 	minute 	NSInteger
 *	@param 	second 	NSInteger
 *
 *	@return	NSDate
 */
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour Minute:(NSInteger)minute Second:(NSInteger)second;

#pragma mark - 加密相关

// MD5加密
+(NSString *)md5: (NSString *) inPutText;

#pragma mark - 关于安装和获取相应的ADID (将生成的ADID存放到keyChain，达到除了重置手机，其他都能保证ADID不变化)

// 安装用户标示
+ (void)setupUserADIDIdentifier;

// 读取用户标示
+ (NSString *)readUserADIDIdentifier;

#pragma mark - 关于保持后台连接

+ (void)keepBackgroundLive;

#pragma mark - 去掉包含html描述中的html标签

/**
 *	@brief	将包含html的描述中的html标签去掉
 *
 *	@param 	content 	包含html的描述
 *
 *	@return	去掉标签后的描述
 */
+ (NSString *)removeHtmlStrInContent:(NSString *)content;

#pragma mark - 根据照片拍摄方向，纠正照片方向
/**
 *	@brief	纠正照片方向
 *
 *	@param 	srcImg 	传入照片
 *
 *	@return	输出纠正后的照片
 */
+ (UIImage *)fixOrientation:(UIImage *)srcImg;

/**
 *	@brief	将图片分辨率最大一边改为指定的大小
 *
 *	@param 	sourceImage 	传入需要处理的UIImage
 *	@param 	defineWidth 	最大分辨率
 *
 *	@return	处理后的UIImage
 */
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

#pragma mark - 文件操作相关

/**
 *	@brief	获取文件完整的DocumentFilePath
 *
 *	@param 	filePath 	文件FilePath
 *
 *	@return	完整的DocumentFilePath
 */
+ (NSString *)returnDocumentFilePathWithFilePath:(NSString *)filePath;

/**
 *	@brief	根据二进制 文件类型 文件路径 文件名称 创建文件
 *
 *	@param 	data 	二进制 NSData
 *	@param 	typeStr 	文件类型
 *	@param 	filePath 	文件路径
 *	@param 	fileName 	文件名称
 *  @param  yesOrNo     是否允许覆盖，如果目录已存在
 *
 *	@return	创建文件是否成功 YesOrNo
 */
+ (BOOL)creatFileWithData:(NSData *)data WitchFileType:(NSString *)typeStr InPath:(NSString *)filePath WithFileName:(NSString *)fileName AndIsNeedIntermediateDirectories:(BOOL)yesOrNo;

/**
 *	@brief	删除传入的FilePath文件
 *
 *	@param 	filePath 	文件FilePath
 *
 *	@return	是否删除成功 YesOrNo
 */
+ (BOOL)deleteFileWithFilePath:(NSString *)filePath;


/**
 *	@brief	获取沙盒URL
 *
 *	@param 	filePath 	文件filePath
 *
 *	@return	沙盒URL+文件filePath
 */
+ (NSURL *)returnDocumentFilePathURLWithFilePath:(NSString *)filePath;


@end
