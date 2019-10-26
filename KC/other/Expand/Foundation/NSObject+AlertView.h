//
//  NSObject+AlertView.h
//  ZhengWuApp
//
//  Created by leco on 2017/3/16.
//  Copyright © 2017年 Letide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AlertView)

/**
 *  1.0s后消失的弹出框提示
 *
 *  @param target 调用UIAlertController的对象
 *  @param title  提示语句
 */
+ (void)showAlertWithTarget:(id)target title:(NSString *)title;
+ (void)showAlertWithTitle:(NSString *)title;

/**
 *  1.0s后消失的弹出框提示
 *
 *  @param target 调用UIAlertController的对象
 *  @param title 提示语句
 *  @param block block回调
 */
+ (void)showAlertWithTarget:(id)target title:(NSString *)title block:(dispatch_block_t)block;
+ (void)showAlertWithTitle:(NSString *)title block:(dispatch_block_t)block;

/**
 *  一个按钮弹出框
 *
 *  @param target     调用UIAlertController的对象
 *  @param title      弹出框标题
 *  @param message    提示语句
 *  @param otherTitle 弹出框按钮标题
 *  @param handler    弹出框按钮的事件
 */
+ (void)showAlertWithTarget:(id)target title:(NSString *)title message:(NSString *)message actionWithTitle:(NSString *)otherTitle handler:(void (^)(UIAlertAction *action))handler;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actionWithTitle:(NSString *)otherTitle handler:(void (^)(UIAlertAction *action))handler;

/**
 *  两个按钮弹出框
 *
 *  @param target           调用UIAlertController的对象
 *  @param title            弹出框标题
 *  @param message          提示语句
 *  @param actionTitle      弹出框按钮标题
 *  @param otherActionTitle 弹出框按钮标题
 *  @param handler          弹出框按钮的事件
 */
+ (void)showAlertWithTarget:(id)target
                      title:(NSString *)title
                    message:(NSString *)message
                actionTitle:(NSString *)actionTitle
           otherActionTitle:(NSString *)otherActionTitle
                    handler:(void (^)(UIAlertAction *action))handler
               otherHandler:(void (^)(UIAlertAction *action))otherHandler;
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               actionTitle:(NSString *)actionTitle
          otherActionTitle:(NSString *)otherActionTitle
                   handler:(void (^)(UIAlertAction *action))handler
              otherHandler:(void (^)(UIAlertAction *action))otherHandler;


#pragma mark - Other

+ (UIViewController *)getCurrentVC;

+ (UIViewController *)currentViewController;

+ (UINavigationController *)currentNavigationController;

+ (void)logPropertyWithDictionary:(id)obj;

@end
