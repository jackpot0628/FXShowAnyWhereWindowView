//
//  VPImageCropperViewController.h
//  VPolor
//
//  Created by Vinson.D.Warm on 12/30/13.
//  Copyright (c) 2013 Huang Vinson. All rights reserved.
//

/*********************************************************************************
 *Copyright(C),2014.03-2015.03,东方数码
 *FileName:  BaseNavViewController
 *Author:  Jackpot(付祥)
 *Version:  3.2
 *Date:  2015.01.01
 *Description:  图片剪切ViewController
 
 *Others:  //其他内容说明
 *Function List:  主要函数列表见下方
 
 *History:  //修改历史记录列表，每条修改记录应包含修改日期、修改者及修改内容简介
 1.Date:
 Author:
 Modification:
 2.…………
 **********************************************************************************/

#import <UIKit/UIKit.h>

@class VPImageCropperViewController;

@protocol VPImageCropperDelegate <NSObject>

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage;
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController;

@end

@interface VPImageCropperViewController : UIViewController

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) id<VPImageCropperDelegate> delegate;
@property (nonatomic, assign) CGRect cropFrame;

- (id)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio;

#pragma mark - 根据照片拍摄方向，纠正照片方向
/**
 *	@brief	纠正照片方向
 *
 *	@param 	srcImg 	传入照片
 *
 *	@return	输出纠正后的照片
 */
+ (UIImage *)fixOrientation:(UIImage *)srcImg;

@end
