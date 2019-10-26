//
//  UIColor+Extension.h
//  ZhengWuApp
//
//  Created by leco on 2017/2/7.
//  Copyright © 2017年 Letide. All rights reserved.
//

#import <UIKit/UIKit.h>

static inline UIColor *ColorARGB(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
    if (@available(iOS 10.0, *)) {
        return [UIColor colorWithDisplayP3Red:((CGFloat)red/255.0f)
                                        green:((CGFloat)green/255.0f)
                                         blue:((CGFloat)blue/255.0f)
                                        alpha:(CGFloat)alpha];
    } else {
        return [UIColor colorWithRed:((CGFloat)red/255.0f)
                               green:((CGFloat)green/255.0f)
                                blue:((CGFloat)blue/255.0f)
                               alpha:(CGFloat)alpha];
    }
}

static inline UIColor *ColorRGB(CGFloat red, CGFloat green, CGFloat blue) {    
    return ColorARGB(red, green, blue, 1.0);
}

static inline UIColor *RandomColor() {
    int red = (arc4random() % 256);
    int green = (arc4random() % 256);
    int blue = (arc4random() % 256);    
    return ColorARGB(red, green, blue, 1.0);
}

static inline UIColor *ColorAHexFloat(uint32_t hexColor, CGFloat alpha) {
    CGFloat red = (CGFloat)((hexColor & 0xFF0000) >> 16);
    CGFloat green = (CGFloat)((hexColor & 0xFF00) >> 8);
    CGFloat blue = (CGFloat)(hexColor & 0xFF);
    
    return ColorARGB(red, green, blue, alpha);
}

static inline UIColor *ColorHexFloat(uint32_t hexColor) {
    return ColorAHexFloat(hexColor, 1.0);
}

extern UIColor *ColorWithAHex(NSString *hexString, CGFloat alpha);

static inline UIColor *ColorWithHex(NSString *hexString) {
    return ColorWithAHex(hexString, 1.0);
}

@interface UIColor (Extension)

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b alphaComponent:(CGFloat)alpha;
+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b;
+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b a:(uint8_t)a;
+ (instancetype)rgba:(NSUInteger)rgba;
+ (instancetype)colorWithHexString:(NSString*)hexString;
+ (UIColor *) colorWithHex:(NSString *) string andalpha:(CGFloat) alpha;
+ (UIColor *) colorWithColor:(UIColor *) color andalpha:(CGFloat) alpha;

- (NSUInteger)rgbaValue;

@end
