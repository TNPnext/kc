//
//  UIView+Extension.h
//  SmartApartment
//
//  Created by 刘靖 on 2017/2/23.
//  Copyright © 2017年 Trudian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};

@interface UIView (Extension)

@property (nonatomic, assign, readonly) CGFloat minX;
@property (nonatomic, assign, readonly) CGFloat minY;

@property (nonatomic, assign, readonly) CGFloat maxX;
@property (nonatomic, assign, readonly) CGFloat maxY;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

/**
 * 创建完整视图层次结构的快照映像
 * Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)snapshotImage;

/**
 Create a snapshot PDF of the complete view hierarchy.
 */
- (nullable NSData *)snapshotPDF;

/**
 Create a view From Xib.
 */
+ (instancetype)viewFromXib;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 * 找到第一个子视图(包含此视图)，它是特定类的成员
 */
- (UIView *)descendantOrSelfWithClass:(Class)aclass;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 * 找到第一个祖先视图(包括这个视图)，它是特定类的成员
 */
- (UIView *)ancestorOrSelfWithClass:(Class)aclass;
/**
 * 为视图添加一个事件
 */
- (void)addTapCallBack:(id)target sel:(SEL)selector;

- (void)cornerRadius;
- (void)cornerRadius:(CGFloat)radius;
- (void)cornerRadius:(CGFloat)radius color:(UIColor *)color;
- (void)cornerRadius:(CGFloat)radius color:(UIColor *)color width:(CGFloat)width;

- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/

+ (void)drawDashLine:(UIView *)lineView topSpace:(CGFloat)topSpace;

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;

NS_ASSUME_NONNULL_END
@end
