//
//  UIColor+Extension.h
//  ZhengWuApp
//
//  Created by leco on 2017/2/7.
//  Copyright © 2017年 Letide. All rights reserved.
//

#import "UIColor+Extension.h"

UIColor *ColorWithAHex(NSString *hexString, CGFloat alpha) {
    NSString *valueString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if (valueString.length < 6) return [UIColor clearColor];
    
    // strip 0X if it appears
    if ([valueString hasPrefix:@"0X"]) valueString = [valueString substringFromIndex:2];
    if ([valueString hasPrefix:@"#"]) valueString = [valueString substringFromIndex:1];
    
    if ([valueString length] != 6) return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    //r
    NSString *rString = [valueString substringWithRange:NSMakeRange(0, 2)];
    //g
    NSString *gString = [valueString substringWithRange:NSMakeRange(2, 2)];
    //b
    NSString *bString = [valueString substringWithRange:NSMakeRange(4, 2)];
    
    // Scan values
    unsigned r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    if (@available(iOS 10.0, *)) {
        return [UIColor colorWithDisplayP3Red:((CGFloat)r / 255.0f)
                                        green:((CGFloat)g / 255.0f)
                                         blue:((CGFloat)b / 255.0f)
                                        alpha:alpha];
    } else {
        return [UIColor colorWithRed:((CGFloat)r / 255.0f)
                               green:((CGFloat)g / 255.0f)
                                blue:((CGFloat)b / 255.0f)
                               alpha:alpha];
    }
}

@implementation UIColor (Extension)

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b alphaComponent:(CGFloat)alpha {
    return [[self r:r g:g b:b] colorWithAlphaComponent:alpha];
}

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b {
    return [self r:r g:g b:b a:0xff];
}

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b a:(uint8_t)a {
    return [self colorWithRed:r / 255. green:g / 255. blue:b / 255. alpha:a / 255.];
}

+ (instancetype)rgba:(NSUInteger)rgba {
    return [self r:(rgba >> 24)&0xFF g:(rgba >> 16)&0xFF b:(rgba >> 8)&0xFF a:rgba&0xFF];
}

+ (instancetype)colorWithHexString:(NSString *)hexString {
    if (!hexString)
        return nil;
    
    NSString* hex = [NSString stringWithString:hexString];
    if ([hex hasPrefix:@"#"])
        hex = [hex substringFromIndex:1];
    
    if (hex.length == 6)
        hex = [hex stringByAppendingString:@"FF"];
    else if (hex.length != 8)
        return nil;
    
    uint32_t rgba;
    NSScanner* scanner = [NSScanner scannerWithString:hex];
    [scanner scanHexInt:&rgba];
    return [UIColor rgba:rgba];
}

+(UIColor *) colorWithHex:(NSString *) string andalpha:(CGFloat) alpha{
    NSString *cleanString = [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)]
                       ];
    }
    
    if ([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+(UIColor *) colorWithColor:(UIColor *) color andalpha:(CGFloat) alpha{
    CGFloat red = 0, green = 0, blue = 0, tempalpha = 0;
    [color getRed:&red green:&green blue:&blue alpha:&tempalpha];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSUInteger)rgbaValue {
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        NSUInteger rr = (NSUInteger)(r * 255 + 0.5);
        NSUInteger gg = (NSUInteger)(g * 255 + 0.5);
        NSUInteger bb = (NSUInteger)(b * 255 + 0.5);
        NSUInteger aa = (NSUInteger)(a * 255 + 0.5);
        
        return (rr << 24) | (gg << 16) | (bb << 8) | aa;
    } else {
        return 0;
    }
}

@end
