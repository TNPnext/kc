//
//  WRCustomNavigationBar.h
//  CodeDemo
//
//  Created by wangrui on 2017/10/22.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar

#import <UIKit/UIKit.h>

@interface WRCustomNavigationBar : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);

@property (nonatomic, copy)   NSString* title;
@property (nonatomic, strong) UIColor*  titleLabelColor;
@property (nonatomic, strong) UIFont* titleLabelFont;
@property (nonatomic, strong) UIColor* barBackgroundColor;
@property (nonatomic, strong) UIImage* barBackgroundImage;

@property (nonatomic, strong) UIView   *titleView;
@property (nonatomic, strong) UIView      *bottomLine;
@property (nonatomic, assign) BOOL leftButtonEnable;
@property (nonatomic, assign) BOOL rightButtonEnable;

+ (instancetype)CustomNavigationBar;

- (void)wr_setLeftButtonHidden:(BOOL)hidden;
- (void)wr_setBottomLineHidden:(BOOL)hidden;
- (void)wr_setBackgroundAlpha:(CGFloat)alpha;
- (void)wr_setTintColor:(UIColor *)color;
- (void)wr_settitleView:(UIView*)view ;
- (void)wr_setRightButtonHidden:(BOOL)hidden;
// 默认返回事件
- (void)wr_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)wr_setLeftButtonWithImage:(UIImage *)image;
- (void)wr_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

- (void)wr_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)wr_setRightButtonWithImage:(UIImage *)image;
- (void)wr_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)wr_setRightButtonWithTitle:(NSString *)title font:(CGFloat)font;

@end
