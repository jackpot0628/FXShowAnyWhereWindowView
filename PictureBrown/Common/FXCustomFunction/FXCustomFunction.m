//
//  FXCustomFunction.m
//  PictureBrown
//
//  Created by Jackpot on 15/1/1.
//  Copyright (c) 2015年 Jackpot. All rights reserved.
//

#import "FXCustomFunction.h"
#import <AdSupport/ASIdentifierManager.h>
#import <CommonCrypto/CommonDigest.h>

#define USERID_KEY @"userId_KeyName"

static BOOL _isStartBackgroundLoop = NO;

@implementation FXCustomFunction

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - 关于NSDate相关方法

/**
 *	@brief	获取时间NSString
 *
 *	@param 	cDate 	NSDate
 *	@param 	formatterStr 	传入nil默认为@"yyyy-MM-dd HH:mm:ss"
 *
 *	@return	以NSString返回时间
 */
+ (NSString *)getDateNowWithNSDate:(NSDate *)cDate
               AndWithFormatterStr:(NSString *)formatterStr

{
    if (formatterStr == nil)
    {
        formatterStr = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatterStr];
    NSString * dateNow = nil;
    
    if (cDate == nil)
    {
        dateNow = [formatter stringFromDate:[NSDate date]];
    }
    else
    {
        dateNow = [formatter stringFromDate:cDate];
    }
    
    return dateNow;
}

/**
 *	@brief	由NSString根据格式返回NSDate对象
 *
 *	@param 	dateStr 	时间NSString
 *	@param 	formatterStr 	时间格式 传入nil默认为@"yyyy-MM-dd HH:mm:ss"
 *
 *	@return	NSDate
 */
+ (NSDate *)getDateWithDateString:(NSString *)dateStr
              AndWithFormatterStr:(NSString *)formatterStr

{
    if (formatterStr == nil)
    {
        formatterStr = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:formatterStr];
    
    NSDate * date = [formatter dateFromString:dateStr];
    
    return date;
}

/**
 *	@brief	返回两个NSDate时间间隔多少秒
 *
 *	@param 	startDate 	开始时间NSDate
 *	@param 	endDate 	结束时间NSDate
 *
 *	@return	NSInteger   秒
 */
+ (NSInteger)returnIntervalSecondBetweenStartDate:(NSDate *)startDate withEndDate:(NSDate *)endDate

{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitSecond
                                               fromDate:startDate
                                                 toDate:endDate
                                                options:0];
    
    return components.second;
}

/**
 *	@brief	判断指定的date是否在两个date之间
 *
 *	@param 	date 	需要判断的date
 *	@param 	beginDate 	开始时间date
 *	@param 	endDate 	结束时间date
 *
 *	@return	YesOrNo
 */
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate

{
    if ([date compare:beginDate] == NSOrderedAscending)
    {
        return NO;
    }
    
    
    if ([date compare:endDate] == NSOrderedDescending)
    {
        return NO;
    }
    
    
    return YES;
}

/**
 *	@brief	通过传入时\分\秒，拼接成相应完整的date
 *
 *	@param 	hour 	NSInteger
 *	@param 	minute 	NSInteger
 *	@param 	second 	NSInteger
 *
 *	@return	NSDate
 */
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour Minute:(NSInteger)minute Second:(NSInteger)second


{
    //获取当前时间
    NSDate *currentDate = [NSDate date];

    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSDateComponents *currentComps = [[NSDateComponents alloc] init];

    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;

    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];

    //设置当天的某个点

    NSDateComponents *resultComps = [[NSDateComponents alloc] init];

    [resultComps setYear:[currentComps year]];

    [resultComps setMonth:[currentComps month]];

    [resultComps setDay:[currentComps day]];

    [resultComps setHour:hour];
    
    [resultComps setMinute:minute];
    
    [resultComps setSecond:second];

    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    return [resultCalendar dateFromComponents:resultComps];

}

+ (NSString *)dayDescriptionWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |NSWeekdayCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    comps = [calendar components:unitFlags fromDate:date];
    
    NSLog(@"-----------weekday is %d",[comps weekday]);//在这里需要注意的是：星期日是数字1，星期一时数字2，以此类推。。。
    NSLog(@"-----------month is %d",[comps month]);
    NSLog(@"-----------day is %d",[comps day]);
    NSLog(@"-----------weekdayOrdinal is %d",[comps weekdayOrdinal]);
    
    return nil;
}

#pragma mark - 加密相关

// MD5加密
+(NSString *)md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

#pragma mark - 关于安装和获取相应的ADID (将生成的ADID存放到keyChain，达到除了重置手机，其他都能保证ADID不变化)

/**
 *	@brief	以appBunldIdentifier作为Key  adid作为Value，创建字典，存放到keyChain
 */
+ (void)setupUserADIDIdentifier

{
    if ([self readUserADIDIdentifier] != nil)
    {
        // 如果已经有了相应的唯一标示，则不用重新生成标示
        return;
    }
    
    NSString * adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    NSLog(@"SETUP adId:%@",adId);
    
    NSString * bunldId =  [[NSBundle mainBundle] bundleIdentifier];
    
    NSDictionary * dataDic = @{USERID_KEY:adId};
    
    [FXCustomFunction save:bunldId data:dataDic];
}

+ (NSString *)readUserADIDIdentifier
{
    NSString * bunldId =  [[NSBundle mainBundle] bundleIdentifier];
    
    NSDictionary * dataDic = (NSDictionary *)[FXCustomFunction load:bunldId];
    
    NSString * userId = [dataDic objectForKey:USERID_KEY];
    
    NSLog(@"READ adId:%@",userId);
    
    return userId;
}

#pragma mark - keyChain相关方法

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}

/**
 *	@brief	将包含html的描述中的html标签去掉
 *
 *	@param 	content 	包含html的描述
 *
 *	@return	去掉标签后的描述
 */
+ (NSString *)removeHtmlStrInContent:(NSString *)content
{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                                                                    options:0
                                                                                      error:nil];
    
    content=[regularExpretion stringByReplacingMatchesInString:content options:NSMatchingReportProgress range:NSMakeRange(0, content.length) withTemplate:@""];//替换所有html和换行匹配元素为" "
    
//    regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"-{1,}" options:0 error:nil] ;
//    content=[regularExpretion stringByReplacingMatchesInString:content options:NSMatchingReportProgress range:NSMakeRange(0, content.length) withTemplate:@" "];//把多个" "匹配为一个" "

//    //根据"-"分割到数组
//    NSArray *arr=[NSArray array];
//    content=[NSString stringWithString:content];
//    arr =  [content componentsSeparatedByString:@"-"];
//    NSMutableArray *marr=[NSMutableArray arrayWithArray:arr];
//    [marr removeObject:@""];
    return  content;
}

#pragma mark - 关于保持后台连接

+ (void)keepBackgroundLive
{
    if (_isStartBackgroundLoop == YES)
    {
        return;
    }
    
    _isStartBackgroundLoop = YES;
    
    __block UIBackgroundTaskIdentifier background_task;
    
    background_task = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^ {
        [[UIApplication sharedApplication] endBackgroundTask: background_task];
        background_task = UIBackgroundTaskInvalid;
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while(TRUE)
        {
            [NSThread sleepForTimeInterval:1];
            
            //编写执行任务代码
            
        }
        
        [[UIApplication sharedApplication] endBackgroundTask: background_task];
        background_task = UIBackgroundTaskInvalid;
    });
}

#pragma mark - 根据照片拍摄方向，纠正照片方向
/**
 *	@brief	纠正照片方向
 *
 *	@param 	srcImg 	传入照片
 *
 *	@return	输出纠正后的照片
 */
+ (UIImage *)fixOrientation:(UIImage *)srcImg

{
    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark - ImageCompress 图片压缩处理
/**
 *	@brief	将图片分辨率最大一边改为指定的大小
 *
 *	@param 	sourceImage 	传入需要处理的UIImage
 *	@param 	defineWidth 	最大分辨率
 *
 *	@return	处理后的UIImage
 */
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth

{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    //    CGFloat targetHeight = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor >= heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
        
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    //    thumbnailRect.size.height = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 文件操作相关

/**
 *	@brief	获取文件完整的DocumentFilePath
 *
 *	@param 	filePath 	文件FilePath
 *
 *	@return	完整的DocumentFilePath
 */
+ (NSString *)returnDocumentFilePathWithFilePath:(NSString *)filePath
{
    return [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),filePath];
}

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
+ (BOOL)creatFileWithData:(NSData *)data WitchFileType:(NSString *)typeStr InPath:(NSString *)filePath WithFileName:(NSString *)fileName AndIsNeedIntermediateDirectories:(BOOL)yesOrNo
{
    NSError * error = nil;
    
    NSFileManager * fm = [NSFileManager defaultManager];
    
    if ([fm createDirectoryAtPath:filePath withIntermediateDirectories:yesOrNo attributes:nil error:&error])
    {
        return YES;
    }
    
    NSLog(@"创建文件错误：%@",[error localizedDescription]);
    
    return NO;
}

/**
 *	@brief	删除传入的文件FilePath
 *
 *	@param 	filePath 	文件FilePath
 *
 *	@return	是否删除成功 YesOrNo
 */
+ (BOOL)deleteFileWithFilePath:(NSString *)filePath
{
    NSError * error = nil;
    
    NSFileManager * fm = [NSFileManager defaultManager];
    
    if ([fm removeItemAtPath:filePath error:&error])
    {
        return YES;
    }
    
    NSLog(@"删除文件错误：%@",[error localizedDescription]);
    
    return NO;
}

/**
 *	@brief	获取沙盒URL
 *
 *	@param 	filePath 	文件filePath
 *
 *	@return	沙盒URL+文件filePath
 */
+ (NSURL *)returnDocumentFilePathURLWithFilePath:(NSString *)filePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * documentPath = [paths lastObject];
    
    NSURL * filePathUrl = [NSURL fileURLWithPath:[documentPath stringByAppendingPathComponent:filePath]];
    
    return filePathUrl;
}


@end
