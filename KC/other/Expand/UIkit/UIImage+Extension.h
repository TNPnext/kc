//
//  UIImage+Extension.h
//  ZhengWuApp
//
//  Created by leco on 2017/2/7.
//  Copyright © 2017年 Letide. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MGImageResizingMethod) {
    MGImageResizeCrop,	// analogous to UIViewContentModeScaleAspectFill, i.e. "best fit" with no space around.
    MGImageResizeCropStart,
    MGImageResizeCropEnd,
    MGImageResizeScale	// analogous to UIViewContentModeScaleAspectFit, i.e. scale down to fit, leaving space around if necessary.
};

@interface UIImage (Extension)


- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

- (UIImage *)imageToFitSize:(CGSize)size method:(MGImageResizingMethod)resizeMethod;
- (UIImage *)imageCroppedToFitSize:(CGSize)size; // uses MGImageResizeCrop
- (UIImage *)imageScaledToFitSize:(CGSize)size; // uses MGImageResizeScale

/**
 *  返回圆形图片
 */
+ (instancetype)dc_circleImage:(NSString *)name;

/**
 *  返回一张可以随意拉伸但不变形的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

/**
 *【加载最原始的图片，没有渲染】
 */
+ (UIImage *)imageWithOriginalName:(NSString *)imageName;

/**
 *【加载受保护的图片(被拉伸的)】
 */
+ (UIImage *)imageWithStretchableName:(NSString *)imageName;

/**
 *  调整图片大小，返回调整后的图片
 *
 *  @param newSize   新图片的尺寸
 *  @return image
 */
- (UIImage *)resizeToSize:(CGSize)newSize;

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize ;

/**
 *【加载颜色生成的图片】
 */
+ (UIImage *)imageWithColor:(UIColor *)color WithSize:(CGSize)size;

/*
 *【根据传入的图片,生成一张带有边框的圆形图片】
 *
 * @param image         原始图片
 * @param borderW       边框宽度
 * @param borderColor   边框颜色
 */
+ (UIImage *)imageWithCircleImage:(NSString *)imageName border:(CGFloat)borderW color:(UIColor *)borderColor;

- (UIImage *)circleImageWithBorder:(CGFloat)borderW color:(UIColor *)borderColor;

/*
 *【返回一张绘制字符串的图片】
 */
+ (UIImage *)imageWithNSString:(NSString *)string font:(CGFloat)textFont color:(UIColor *)textColor clip:(BOOL)clip drawAtImage:(UIImage *)image drawAtPoint:(CGPoint)atPoint;

/*
 *【根据传入的图片,返回一张圆形图片】
 */
- (UIImage *)circleImage;

/*
 *【返回一张抗锯齿图片】
 * 本质：在图片生成一个透明为1的像素边框
 */
- (UIImage *)imageAntialias;


/*
 *【固定宽度与固定高度】
 */
- (UIImage *)scaleWithFixedWidth:(CGFloat)width;
- (UIImage *)scaleWithFixedHeight:(CGFloat)height;


/*
 *【裁剪图片的一部分】
 */
- (UIImage *)croppedImageAtFrame:(CGRect)frame;


/*
 *【将自身填充到指定的size】
 */
- (UIImage *)fillClipSize:(CGSize)size;

/**
 *【图片圆角处理】
 */

- (UIImage *)createRoundedRectWithRadius:(NSInteger)radius;

- (UIImage *)createRoundedRectWithSize:(CGSize)size withRadius:(NSInteger)radius;


#pragma mark - 二维码

+ (UIImage *)encodeQRImageWithContent:(NSString *)content width:(CGFloat)width;

/**
 生成自定义样式二维码
 注意：有些颜色结合生成的二维码识别不了
 @param codeString 字符串
 @param size 大小
 @param backColor 背景色
 @param frontColor 前景色
 @param centerImage 中心图片
 @return image二维码
 */
+ (UIImage *_Nullable)createQRCodeImageWithString:(nonnull NSString *)codeString andSize:(CGSize)size andBackColor:(nullable UIColor *)backColor andFrontColor:(nullable UIColor *)frontColor andCenterImage:(nullable UIImage *)centerImage;


@end
