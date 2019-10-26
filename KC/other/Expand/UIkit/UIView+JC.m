//
//  UIView+JC.m
//  JC_Extension
//
//  Created by TNP on 2017/5/25.
//  Copyright © 2017年 CXMX. All rights reserved.
//

#import "UIView+JC.h"

@implementation UIView (JC)
UIFont *fontSize(NSUInteger size)
{
    return [UIFont systemFontOfSize:size];
}
UIImage *TimageName(NSString *name)
{
    return [UIImage imageNamed:name];
}
BOOL objectIsEmpty(id object)
{
    if ([object isKindOfClass:[NSNull class]] ||object==nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

BOOL iPhoneXSeries(void)
{
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone)
    {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *))
    {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0)
        {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
    
}


void LogObjectClass(id object)
{
    NSLog(@"object is %@ class",NSStringFromClass([object class]));
}
BOOL isHaveNewVersion(NSString *version)
{
    //去掉点
    NSString *oldVer = [bundleVersion() stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *newVer = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
    while (oldVer.length != newVer.length)
    {
        if (oldVer.length>newVer.length)
        {
            newVer = [newVer stringByAppendingString:@"0"];
        }else
        {
            oldVer = [oldVer stringByAppendingString:@"0"];
        }
    }
    if ([oldVer intValue]<[newVer intValue])
    {
        return YES;
    }else
    {
        return NO;
    }
}

NSString *sandBoxPath()
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)[0];
}

NSString *sandBoxCachesPath()
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

NSString *bundleVersion()
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

@end
#pragma mark UIView (frame)
@implementation UIView (frame)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end

#pragma mark UIView (line)
@implementation UIView (line)

- (UIView *)addtionUnderlineWithSross:(CGFloat)sross withColor:(UIColor *)color
{
    return [self addtionHorizontalLineWithSross:sross withTop:self.height - sross withColor:color];
}

- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withTop:(CGFloat)top withColor:(UIColor *)color
{
    return [self addtionHoriaontalLineWithSross:sross withLeft:left withTop:top withWidth:self.width - left withColor:color];
}

- (UIView *)addtionHorizontalLineWithSross:(CGFloat)sross withTop:(CGFloat)top withColor:(UIColor *)color
{
    return [self addtionHoriaontalLineWithSross:sross withLeft:0 withTop:top withWidth:self.width withColor:color];
}

- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withColor:(UIColor *)color
{
    return [self addtionHoriaontalLineWithSross:sross withLeft:left withTop:self.height - sross withWidth:self.width - left withColor:color];
}

- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withRight:(CGFloat)right withColor:(UIColor *)color
{
    return [self addtionHoriaontalLineWithSross:sross withRight:right withWidth:right withColor:color];
}

- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withWidth:(CGFloat)width withColor:(UIColor *)color
{
    return [self addtionHoriaontalLineWithSross:sross withLeft:left withTop:self.height - sross withWidth:width withColor:color];
}

- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withTop:(CGFloat)top withWidth:(CGFloat)width withColor:(UIColor *)color
{
    UIView *underLine = [[UIView alloc]initWithFrame:CGRectMake(left, top, width, sross)];
    [underLine bringToFront];
    underLine.backgroundColor = color;
    [self addSubview:underLine];
    return underLine;
}

- (UIView *)addtionHoriaontalLineWithSross:(CGFloat)sross withRight:(CGFloat)right withWidth:(CGFloat)width withColor:(UIColor *)color
{
    UIView *underLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, sross)];
    underLine.right = right;
    [underLine bringToFront];
    underLine.backgroundColor = color;
    [self addSubview:underLine];
    return underLine;
}

- (UIView *)addtionVarticalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withColor:(UIColor *)color
{
    return [self addtionVerticalLineWithSross:sross withLeft:left withTop:0 withHeight:self.height withColor:color];
}

- (UIView *)addtionVerticalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withTop:(CGFloat)top withColor:(UIColor *)color
{
    return [self addtionVerticalLineWithSross:sross withLeft:left withTop:top withHeight:self.height withColor:color];
}

- (UIView *)addtionVerticalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withBottom:(CGFloat)bottom withColor:(UIColor *)color
{
    return [self addtionVerticalLineWithSross:sross withLeft:left withTop:0 withHeight:bottom withColor:color];
}

- (UIView *)addtionVerticalLineWithSross:(CGFloat)sross withLeft:(CGFloat)left withTop:(CGFloat)top withHeight:(CGFloat)height withColor:(UIColor *)color
{
    UIView *underLine = [[UIView alloc]initWithFrame:CGRectMake(left, top, sross, height)];
    [underLine bringToFront];
    underLine.backgroundColor = color;
    [self addSubview:underLine];
    return underLine;
}

@end

#pragma mark UIView (extension)
@implementation UIView (extension)

- (void)addTapGestureWithTarget:(id)pTarget selector:(SEL)pSelector
{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:pTarget action:pSelector];
    self.exclusiveTouch=YES;
    tapGesture.numberOfTouchesRequired=1;
    tapGesture.numberOfTapsRequired=1;
    [self addGestureRecognizer:tapGesture];
    self.userInteractionEnabled = YES;
}

- (void)addDoubleTapGestureWithTarget:(id)pTarget selector:(SEL)pSelector
{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:pTarget action:pSelector];
    self.exclusiveTouch=YES;
    tapGesture.numberOfTouchesRequired=1;
    tapGesture.numberOfTapsRequired=2;
    [self addGestureRecognizer:tapGesture];
    self.userInteractionEnabled = YES;
}

- (UIViewController *)viewcontroller
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)removeAllSubviews
{
    while (self.subviews.count > 0) {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)removeAllSubviewsExcludView:(UIView *)view
{
    while (self.subviews.count > view.subviews.count) {
        UIView *child = self.subviews.lastObject;
        if (![child isEqual:view]) {
            [child removeFromSuperview];
        }
    }
}

- (void)addSubviews:(NSArray *)subviews
{
    for (UIView *subview in subviews) {
        [self addSubview:subview];
    }
}

- (void)removeSubviewForUIButton
{
    for (UIView *subview in self.subviews) {
        if ([subview isMemberOfClass:[UIButton class]]) {
            [subview removeFromSuperview];
        }
    }
}

-(void)removeViewWithTag:(NSInteger)tag{
    if (tag == 0) {
        return;
    }
    UIView *view = [self viewWithTag:tag];
    if (view) {
        [view removeFromSuperview];
    }
}

-(void)removeViewWithTags:(NSArray *)tagArray{
    for (NSNumber *num in tagArray) {
        [self removeViewWithTag:[num integerValue]];
    }
}

- (void)setbackgroundImage:(UIImage *)img
{
    self.layer.contents = (id)[img CGImage];
}

- (void)bringToFront
{
    [self.superview bringSubviewToFront:self];
}

- (UIImage *)imageByRenderingView
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (BOOL)hasGesture:(id)gestureObjClass
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isMemberOfClass:gestureObjClass]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)removeGesture:(id)gestureObjClass
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isMemberOfClass:gestureObjClass]) {
            [self removeGestureRecognizer:gesture];
            return YES;
        }
    }
    return NO;
}

- (BOOL)removeAllGestures
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        [self removeGestureRecognizer:gesture];
    }
    if (self.gestureRecognizers.count == 0) {
        return YES;
    }
    return NO;
}


@end
#pragma mark UIView (keyboard)
@implementation UIView (keyboard)

+ (UIView *)findKeyboard
{
    UIView *keyboardView = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in [windows reverseObjectEnumerator])//逆序效率更高，因为键盘总在上方
    {
        keyboardView = [self findKeyboardInView:window];
        if (keyboardView)
        {
            return keyboardView;
        }
    }
    return nil;
}

+ (UIView *)findKeyboardInView:(UIView *)view
{
    for (UIView *subView in [view subviews])
    {
        if (strstr(object_getClassName(subView), "UIKeyboard"))
        {
            return subView;
        }
        else
        {
            UIView *tempView = [self findKeyboardInView:subView];
            if (tempView)
            {
                return tempView;
            }
        }
    }
    return nil;
}

@end

#pragma mark UIView (rotation)
#import <objc/runtime.h>
static char loopNumKey;

@implementation UIView (rotation)

- (void)setLoopNumber:(NSInteger)loopNumber
{
    objc_setAssociatedObject(self, &loopNumKey, [NSNumber numberWithInteger:loopNumber], OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger)loopNumber
{
    if (!objc_getAssociatedObject(self, &loopNumKey)) {
        return 0;
    }
    return [objc_getAssociatedObject(self, &loopNumKey) integerValue];
}

- (void)beginRotation
{
    if (self.loopNumber == 360) {
        self.loopNumber = 0;
    }
    self.loopNumber ++;
    self.transform = CGAffineTransformMakeRotation(self.loopNumber * M_PI / 180.0f);
    
    [self performSelector:@selector(beginRotation) withObject:nil afterDelay:0.003];
}

- (void)cancelRotation
{
    objc_setAssociatedObject(self, &loopNumKey, nil, OBJC_ASSOCIATION_ASSIGN);
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)rotation_0
{
    self.transform = CGAffineTransformMakeRotation(0 * M_PI / 180.0f);
}

- (void)rotation_90
{
    self.transform = CGAffineTransformMakeRotation(90 * M_PI / 180.0f);
}

- (void)rotation_180
{
    self.transform = CGAffineTransformMakeRotation(180 * M_PI / 180.0f);
}

- (void)rotation_270
{
    self.transform = CGAffineTransformMakeRotation(270 * M_PI / 180.0f);
}

- (void)rotateToArc:(CGFloat)arc
{
    self.transform = CGAffineTransformMakeRotation(arc * M_PI / 180.0f);
}

@end
#pragma mark UIViewController (orientation)
@implementation UIViewController (orientation)

- (void)setOrientationWithAnimationDuration:(CGFloat)duration complement:(void (^)(BOOL complete, UIDeviceOrientation orientation))complement
{
    self.view.window.backgroundColor = [UIColor blackColor];
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    id <UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    UIWindow *window = delegate.window;
    switch (orientation) {
        case 1: {
            [UIView animateWithDuration:duration animations:^{
                
                [self.view rotation_0];
                self.view.frame = window.bounds;
            } completion:^(BOOL finished) {
                if (complement) {
                    complement(YES, orientation);
                }
            }];
        } break;
        case 2: {
            [UIView animateWithDuration:duration animations:^{
                
                self.view.frame = CGRectMake(0, 0, window.height, window.width);
                self.view.centerX = window.width / 2;
                self.view.centerY = window.height / 2;
                [self.view rotation_180];
            } completion:^(BOOL finished) {
                if (complement) {
                    complement(YES, orientation);
                }
            }];
        } break;
        case 3: {
            [UIView animateWithDuration:duration animations:^{
                
                self.view.frame = CGRectMake(0, 0, window.height, window.width);
                self.view.centerX = window.width / 2;
                self.view.centerY = window.height / 2;
                [self.view rotation_90];
            } completion:^(BOOL finished) {
                if (complement) {
                    complement(YES, orientation);
                }
            }];
        } break;
        case 4: {
            [UIView animateWithDuration:duration animations:^{
                
                self.view.frame = CGRectMake(0, 0, window.height, window.width);
                self.view.centerX = window.width / 2;
                self.view.centerY = window.height / 2;
                [self.view rotation_270];
            } completion:^(BOOL finished) {
                if (complement) {
                    complement(YES, orientation);
                }
            }];
        } break;
            
        default: {
            if (complement) {
                complement(NO, orientation);
            }
        } break;
    }
}


- (void)setInterfaceOrientationWithInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:orientation] forKey:@"orientation"];
}
@end

#pragma mark UIImage (Size)
@implementation UIImage (Size)
// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}
//  获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}
@end

#pragma mark UIDevice (KeychainIDFV)
@implementation UIDevice (KeychainIDFV)

+(NSString *)KeychainIDFV
{
    return [[self currentDevice] KeychainIDFV];
}

-(NSString *)KeychainIDFV
{
    NSString *idfv = [self getIdfvFromKeyChain];
    
    if (idfv && idfv.length > 0 && [idfv isKindOfClass:[NSString class]]) {
        return idfv;
    }else
    {
        NSString *idfv = [[self identifierForVendor] UUIDString];
        idfv = [idfv stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [self saveIdfvToKeyChain:idfv];
        return idfv;
    }
}


-(void)removeKeychainIDFV
{
    NSString *keychainKey = [[NSBundle mainBundle] bundleIdentifier];
    keychainKey = [keychainKey stringByAppendingString:@".IDFV"];
    [self delete:keychainKey];
}

+(void)removeKeychainIDFV
{
    [[self currentDevice] removeKeychainIDFV];
}


-(void)saveIdfvToKeyChain:(NSString *)idfv
{
    NSString *keychainKey = [[NSBundle mainBundle] bundleIdentifier];
    keychainKey = [keychainKey stringByAppendingString:@".IDFV"];
    [self save:keychainKey data:idfv];
}

-(NSString *)getIdfvFromKeyChain
{
    NSString *keychainKey = [[NSBundle mainBundle] bundleIdentifier];
    keychainKey = [keychainKey stringByAppendingString:@".IDFV"];
    NSString * idfv = [self load:keychainKey];
    return idfv;
}


- (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

- (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

- (id)load:(NSString *)service {
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

- (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}

CGFloat CurrSystemVersion(void)
{
    return [[UIDevice currentDevice].systemVersion floatValue];
}
@end

#pragma mark NSString (JC_extension)

@implementation NSString (CJ_extension)



NSMutableAttributedString *stringWithStr(NSString * string,UIColor *acolor,NSRange arange)
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:objectIsEmpty(string)?@"":string];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:acolor
                             range:arange];
    return attributedString;
}


NSMutableAttributedString *getAttributedStringWithStr(NSString * string,CGFloat fontsize,CGFloat lineSpacing,CGFloat maxcontentWidth)
{
    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:(objectIsEmpty(string)?@"":string)];
    [contentText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontsize] range:NSMakeRange(0, contentText.length)];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpacing];
    [paragraphStyle1 setLineBreakMode:NSLineBreakByWordWrapping];
    [contentText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, contentText.length)];
    
    return contentText;
}

CGRect getRectWithStr(NSString * string,CGFloat fontsize,CGFloat lineSpacing,CGFloat maxcontentWidth)
{
    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:(objectIsEmpty(string)?@"":string)];
    [contentText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontsize] range:NSMakeRange(0, contentText.length)];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpacing];
    [paragraphStyle1 setLineBreakMode:NSLineBreakByWordWrapping];
    [contentText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, contentText.length)];
    
    CGRect contentRect = [contentText boundingRectWithSize:CGSizeMake(maxcontentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return contentRect;
}


@end




