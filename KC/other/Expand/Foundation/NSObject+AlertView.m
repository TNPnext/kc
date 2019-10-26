//
//  NSObject+AlertView.m
//  ZhengWuApp
//
//  Created by leco on 2017/3/16.
//  Copyright © 2017年 Letide. All rights reserved.
//

#import "NSObject+AlertView.h"
#define kDispalyDuration 1.5
@implementation NSObject (AlertView)

+ (void)showAlertWithTarget:(id)target title:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    [target presentViewController:alertController animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDispalyDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
    });
}

+ (void)showAlertWithTitle:(NSString *)title
{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
//
//    id windowVC = [[[UIApplication sharedApplication] delegate] window].rootViewController;
//    [windowVC presentViewController:alertController animated:YES completion:nil];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDispalyDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [alertController dismissViewControllerAnimated:YES completion:nil];
//    });
    UIAlertView *alet = [[UIAlertView alloc]initWithTitle:nil message:title delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alet show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDispalyDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alet dismissWithClickedButtonIndex:0 animated:1];
        
    });
}


+ (void)showAlertWithTarget:(id)target title:(NSString *)title block:(dispatch_block_t)block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [target presentViewController:alert animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDispalyDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
        block();
    });
}

+ (void)showAlertWithTitle:(NSString *)title block:(dispatch_block_t)block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    id windowVC = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    [windowVC presentViewController:alert animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDispalyDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
        block();
    });
}


+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actionWithTitle:(NSString *)otherTitle handler:(void (^)(UIAlertAction *action))handler

{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:handler]];
    id windowVC = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    [windowVC presentViewController:alert animated:YES completion:nil];
}

+ (void)showAlertWithTarget:(id)target title:(NSString *)title message:(NSString *)message actionWithTitle:(NSString *)otherTitle handler:(void (^)(UIAlertAction *action))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:handler]];
    [target presentViewController:alert animated:YES completion:nil];
}


+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               actionTitle:(NSString *)actionTitle
          otherActionTitle:(NSString *)otherActionTitle
                   handler:(void (^)(UIAlertAction *action))handler
              otherHandler:(void (^)(UIAlertAction *action))otherHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:handler]];
    [alert addAction:[UIAlertAction actionWithTitle:otherActionTitle style:UIAlertActionStyleDefault handler:otherHandler]];
    id windowVC = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    [windowVC presentViewController:alert animated:YES completion:nil];
}

+ (void)showAlertWithTarget:(id)target
                      title:(NSString *)title
                    message:(NSString *)message
                actionTitle:(NSString *)actionTitle
           otherActionTitle:(NSString *)otherActionTitle
                    handler:(void (^)(UIAlertAction *action))handler
               otherHandler:(void (^)(UIAlertAction *action))otherHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:handler]];
    [alert addAction:[UIAlertAction actionWithTitle:otherActionTitle style:UIAlertActionStyleDefault handler:otherHandler]];
    [target presentViewController:alert animated:YES completion:nil];
}


#pragma mark - Other

+ (UIViewController *)getCurrentVC {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    
    while (![nextResponder isKindOfClass:[UIViewController class]] ||
           [nextResponder isKindOfClass:[UINavigationController class]] ||
           [nextResponder isKindOfClass:[UITabBarController class]])
    {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}

+ (UIViewController *)currentViewController
{
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        if ([viewController isKindOfClass:[UITabBarController class]])
        {
            viewController = [(UITabBarController *)viewController selectedViewController];
        }
        else if ([viewController isKindOfClass:[UINavigationController class]])
        {
            viewController = [(UINavigationController *)viewController visibleViewController];
        }
        else if (viewController.presentedViewController) {
            viewController = viewController.presentedViewController;
        }
        else
            break;
    }
    return viewController;
}

+ (UINavigationController *)currentNavigationController
{
    return [self currentViewController].navigationController;
}

+ (void)logPropertyWithDictionary:(id)obj
{
#if DEBUG
    NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        propertyDic = [(NSDictionary *)obj mutableCopy];
    } else if ([obj isKindOfClass:[NSArray class]]) {
        NSMutableArray *tempArr = [(NSArray *)obj mutableCopy];
        if (tempArr.count > 0) {
            propertyDic = [tempArr[0] mutableCopy];
        } else {
            return;
        }
    } else {
        return;
    }
    
    if (propertyDic.count == 0) {
        return;
    }
    
    NSMutableString *strM = [NSMutableString string];
    [propertyDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *className = NSStringFromClass([obj class]);
        
        if ([className isEqualToString:@"__NSCFString"] |
            [className isEqualToString:@"__NSCFConstantString"] |
            [className isEqualToString:@"NSTaggedPointerString"])
        {
            [strM appendFormat:@"@property (copy, nonatomic) NSString *%@;\n",key];
        }
        else if ([className isEqualToString:@"__NSCFArray"] |
                 [className isEqualToString:@"__NSArray0"] |
                 [className isEqualToString:@"__NSArrayI"])
        {
            [strM appendFormat:@"@property (strong, nonatomic) NSArray *%@;\n",key];
        }
        else if ([className isEqualToString:@"__NSCFDictionary"])
        {
            [strM appendFormat:@"@property (strong, nonatomic) NSDictionary *%@;\n",key];
        }
        else if ([className isEqualToString:@"__NSCFNumber"])
        {
            [strM appendFormat:@"@property (copy, nonatomic) NSNumber *%@;\n",key];
        }
        else if ([className isEqualToString:@"__NSCFBoolean"])
        {
            [strM appendFormat:@"@property (assign, nonatomic) BOOL   %@;\n",key];
        }
        else if ([className isEqualToString:@"NSDecimalNumber"])
        {
            [strM appendFormat:@"@property (copy, nonatomic) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
        else if ([className isEqualToString:@"NSNull"])
        {
            [strM appendFormat:@"@property (copy, nonatomic) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
        else if ([className isEqualToString:@"__NSArrayM"])
        {
            [strM appendFormat:@"@property (strong, nonatomic) NSMutableArray *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
    }];
#endif
}

@end
