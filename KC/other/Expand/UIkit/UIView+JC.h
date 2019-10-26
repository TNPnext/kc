//
//  UIView+JC.h
//  JC_Extension
//
//  Created by TNP on 2017/5/25.
//  Copyright © 2017年 CXMX. All rights reserved.
//

#import <UIKit/UIKit.h>

//全局数据和设置宏一样的概念
@interface UIView (JC)
/**
 *     设置字体大小
 *
 *     @return 字体大小
 */
UIFont *fontSize(NSUInteger size);
/**
 *     设置图片
 *
 *     @return 图片
 */
 UIImage *TimageName(NSString *name);
/**
 *     判断对象是否为空
 */
FOUNDATION_EXPORT BOOL objectIsEmpty(id object);

/**
 isIPhoneXSeries 是否是iPhonex类型

 @return yes or no
 */
FOUNDATION_EXPORT  BOOL iPhoneXSeries(void);
/**
 *     输出对象类型
 */
FOUNDATION_EXPORT void LogObjectClass(id object);
/**
 *     判断是否有新版本(传入App Store的版本)
 *
 */
FOUNDATION_EXPORT BOOL isHaveNewVersion(NSString *version);

/**
 *     沙盒路径
 */
FOUNDATION_EXPORT NSString *sandBoxPath(void);

/**
 *     沙盒缓存路径
 */
FOUNDATION_EXPORT NSString *sandBoxCachesPath(void);

/**
 *     当前版本号
 */
FOUNDATION_EXPORT NSString *bundleVersion(void);
@end
/**
 *     布局位置
 */
@interface UIView (frame)
/**
 *     左边距离
 */
@property (nonatomic) CGFloat left;

/**
 *     上面的距离
 */
@property (nonatomic) CGFloat top;

/**
 *     右边距离
 */
@property (nonatomic) CGFloat right;

/**
 *     下面的距离
 */
@property (nonatomic) CGFloat bottom;

/**
 *     宽度
 */
@property (nonatomic) CGFloat width;

/**
 *     高度
 */
@property (nonatomic) CGFloat height;

/**
 *     横向的中心点
 */
@property (nonatomic) CGFloat centerX;

/**
 *     纵向的中心点
 */
@property (nonatomic) CGFloat centerY;

/**
 *     左边距离和上面距离
 */
@property (nonatomic) CGPoint origin;

/**
 *     宽度和高度
 */
@property (nonatomic) CGSize size;


@end

/**
 *     快速添加线条
 */
@interface UIView (line)


/**
 *     在最底下添加一条线条
 *
 *     @param sross 线宽
 *     @param color 颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionUnderlineWithSross:(CGFloat)sross withColor:(UIColor *)color;

/**
 *     添加横线
 *
 *     @param sross 线宽
 *     @param top   线在上面的距离
 *     @param color 颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionHorizontalLineWithSross:(CGFloat)sross withTop:(CGFloat)top withColor:(UIColor *)color;

/**
 *     在最底下添加一条线条
 *
 *     @param sross 线宽
 *     @param left  距左边的距离
 *     @param color 颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withColor:(UIColor *)color;

/**
 *     在最底下添加一条线条
 *
 *     @param sross 线宽
 *     @param left  距左边的距离
 *     @param width 线的长度
 *     @param color 颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withWidth:(CGFloat)width withColor:(UIColor *)color;

/**
 *     添加横线
 *
 *     @param sross 线宽
 *     @param left  距左边的距离
 *     @param top   距上面的距离
 *     @param color 颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withTop:(CGFloat)top withColor:(UIColor *)color;

/**
 *     添加横线
 *
 *     @param sross 线宽
 *     @param left  距左边的距离
 *     @param top   距上面的距离
 *     @param width 线长
 *     @param color 颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withTop:(CGFloat)top withWidth:(CGFloat)width withColor:(UIColor *)color;

/**
 *     在最底下添加一条线
 *
 *     @param sross 线宽
 *     @param right 距右边的距离
 *     @param color 颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withRight:(CGFloat)right withColor:(UIColor *)color;

/**
 *     在最底下添加一条线
 *
 *     @param sross 线宽
 *     @param right 距右边的距离
 *     @param width 线长
 *     @param color 颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withRight:(CGFloat)right withWidth:(CGFloat)width withColor:(UIColor *)color;

/**
 *     添加竖线
 *
 *     @param sross 线宽
 *     @param left  距左边的距离
 *     @param color 颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionVarticalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withColor:(UIColor *)color;

/**
 *     添加竖线
 *
 *     @param sross 线宽
 *     @param left  距左边的距离
 *     @param top   距上面的距离
 *     @param color 颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionVerticalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withTop:(CGFloat)top withColor:(UIColor *)color;

/**
 *     添加线条
 *
 *     @param sross  线宽
 *     @param left   距左边的距离
 *     @param bottom 距下面的距离
 *     @param color  颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionVerticalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withBottom:(CGFloat)bottom withColor:(UIColor *)color;

/**
 *     添加线条
 *
 *     @param sross  线宽
 *     @param left   距左边的距离
 *     @param top    距上面的距离
 *     @param height 线高
 *     @param color  颜色
 *
 *     @return 线条对象
 */
- (UIView *)addtionVerticalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withTop:(CGFloat)top withHeight:(CGFloat)height withColor:(UIColor *)color;


@end
/**
 *     常用拓展
 */
@interface UIView (extension)


/**
 *     添加点击
 *
 *     @param pTarget   响应的对象
 *     @param pSelector SEL
 */
- (void)addTapGestureWithTarget:(id)pTarget selector:(SEL)pSelector;

- (void)addDoubleTapGestureWithTarget:(id)pTarget selector:(SEL)pSelector;

/**
 *     视图的控制器
 *
 *     @return 视图的控制器
 */
- (UIViewController *)viewcontroller;

/**
 *     删除所有子视图
 */
- (void)removeAllSubviews;

- (void)removeAllSubviewsExcludView:(UIView *)view;

/**
 *     添加一个数组的子视图
 *
 *     @param subviews 子视图数组
 */
- (void)addSubviews:(NSArray *)subviews;

/**
 *     删除所有为 UIButton 的子视图
 */
- (void)removeSubviewForUIButton;
/**
 *     删除tag相同子视图
 */
-(void)removeViewWithTag:(NSInteger)tag;
/**
 *     删除tag相同的子视图
 */
-(void)removeViewWithTags:(NSArray *)tagArray;
/**
 *     设置背景图片
 *
 *     @param img 背景图
 */
- (void)setbackgroundImage:(UIImage *)img;

/**
 *     在父视图的所有子视图中进入最上层
 */
- (void)bringToFront;

/**
 *     截图
 *
 *     @return 截图
 */
- (UIImage *)imageByRenderingView;

/**
 *     返回是否添加手势
 *
 *     @param gestureObjClass 手势对象
 *
 *     @return 是否添加该手势对象
 */
- (BOOL)hasGesture:(id)gestureObjClass;

/**
 *     删除指定的手势
 *
 *     @param gestureObjClass 指定的手势
 *
 *     @return 是否成功删除
 */
- (BOOL)removeGesture:(id)gestureObjClass;

/**
 *     删除所有手势
 *
 *     @return 是否成功删除
 */
- (BOOL)removeAllGestures;



@end
/**
 *     查找键盘
 */
@interface UIView (keyboard)


/**
 *     取到键盘
 *
 *     @return 键盘对象
 */
+ (UIView *)findKeyboard;


@end


/**
 *     视图旋转的扩展
 */
@interface UIView (rotation)


/**
 *     旋转圈数
 */
@property (nonatomic, assign) NSInteger loopNumber;

/**
 *     开始旋转
 */
- (void)beginRotation;

/**
 *     取消旋转
 */
- (void)cancelRotation;

/**
 *     旋转回正常
 */
- (void)rotation_0;

/**
 *     旋转 90 度
 */
- (void)rotation_90;

/**
 *     旋转 180 度
 */
- (void)rotation_180;

/**
 *     旋转 270 度
 */
- (void)rotation_270;

/**
 *     旋转到指定的幅度
 *
 *     @param arc 幅度
 */
- (void)rotateToArc:(CGFloat)arc;


@end

/**
 *     Controller
 */
@interface UIViewController (orientation)

/**
 *     屏幕旋转
 */
- (void)setOrientationWithAnimationDuration:(CGFloat)duration complement:(void(^)(BOOL complete, UIDeviceOrientation orientation))complement;


- (void)setInterfaceOrientationWithInterfaceOrientation:(UIInterfaceOrientation)orientation;

@end

/**
 *     UIImage
 */
@interface UIImage (Size)
/**
 *  根据图片url获取图片尺寸
 *
 *  @param imageURL 图片url
 */
+(CGSize)getImageSizeWithURL:(id)imageURL;
@end

/**
 *     UIDevice
 */
@interface UIDevice (KeychainIDFV)

-(NSString *)KeychainIDFV;

+(NSString *)KeychainIDFV;

-(void)removeKeychainIDFV;

+(void)removeKeychainIDFV;

FOUNDATION_EXPORT CGFloat CurrSystemVersion(void);

@end

/**
 *     NSString
 */
@interface NSString (CJ_extension)

/**
 *     设置字符串的颜色位置
 */
FOUNDATION_EXPORT NSMutableAttributedString *stringWithStr(NSString * string,UIColor *acolor,NSRange arange);


/**
 *  NSMutableAttributedString
 *
 *  @param string          字符串
 *  @param fontsize        字体大小
 *  @param lineSpacing     行高
 *  @param maxcontentWidth 最大宽度
 *
 *  @return 返回获得的NSMutableAttributedString
 */
FOUNDATION_EXPORT NSMutableAttributedString *getAttributedStringWithStr(NSString * string,CGFloat fontsize,CGFloat lineSpacing,CGFloat maxcontentWidth);

/**
 *  获取字体内容返回的高度
 *
 *  @param string          字符串
 *  @param fontsize        字体大小
 *  @param lineSpacing     行高
 *  @param maxcontentWidth 最大宽度
 *
 *  @return 返回CGRect
 */
FOUNDATION_EXPORT CGRect getRectWithStr(NSString * string,CGFloat fontsize,CGFloat lineSpacing,CGFloat maxcontentWidth);


@end

