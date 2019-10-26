//
//  NSString+Extension.h
//  ZhengWuApp
//
//  Created by leco on 2017/3/7.
//  Copyright © 2017年 Letide. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CompareResultType) {
    BiggerResultType,
    SmallerResultType,
    EqualResultType,
};

@interface NSString (Extension)

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString ;

//将数字转为保留两位小数  如果小数后面以0结尾去掉
+(NSString *)strChangeTwo:(CGFloat)str;
/* 字符串尺寸 */
- (CGSize)sizeFromFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize)sizeWithText:(NSString*)text lineSpace:(CGFloat)lineSpace font:(CGFloat)font constrainedToSize:(CGSize)size;

/* 自定义字符串 */
+ (NSAttributedString*)stringCustomText:(NSString*)text lineSpacing:(CGFloat)spacing color:(UIColor*)color fontOfSize:(CGFloat)size;

+ (NSAttributedString*)stringCustomText:(NSString*)text rangString:(NSString*)rangString rangFont:(CGFloat)rangFont rangColor:(UIColor*)rangColor;

+ (NSAttributedString*)stringCustomText:(NSString*)text lineSpacing:(CGFloat)spacing color:(UIColor*)color fontOfSize:(CGFloat)size rangString:(NSString*)rangString rangColor:(UIColor*)rangColor;

/* 获取文件大小 */
- (NSString *)fileSizeString;

/* 获取文件大小 */
+ (NSString *)sizeStringWith:(unsigned long long)fileSize;

/* 获取文件大小 */
- (NSString *)directorySize;

/** 生成文档目录全路径 */
- (instancetype)docDir;
/* 生成资源库目录全路径 */
- (instancetype)libDir;
/** 生成缓存目录全路径 */
- (instancetype)cacheDir;
/** 生成临时目录全路径 */
- (instancetype)tempDir;

/* 文档目录 */
+ (NSString *)documentPath;
/* 资源库目录 */
+ (NSString *)libraryPath;
/* 缓存目录 */
+ (NSString *)cachePath;
/* 临时目录 */
+ (NSString *)tempPath;

/* app的版本号 */
+ (NSString *)appVersion;
/* app build版本号 */
+ (NSString *)buildVersion;
/* app的显示名称 */
+ (NSString *)displayName;
/* app的identifier */
+ (NSString *)bundleIdentifier;
/* 获取当前语言 */
+ (NSString *)localeLanguage;


/* 版本号比较 */
- (CompareResultType)versionCompare:(NSString *)oldVersion;

/* 字符串尺寸 */
- (CGSize)sizeFromFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/* 字符串宽度 */
- (CGFloat)widthForFont:(UIFont *)font;

/* 字符串高度 */
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

/* 价格格式化 */
+ (NSString *)strmethodComma:(NSString *)str;

- (NSString *)safeString;

/**
 *  字符串添加图片
 */
-(NSMutableAttributedString *)insertImg:(UIImage *)Img atIndex:(NSInteger )index IMGrect:(CGRect )IMGrect;

/*
 在文字上添加删除线（例如过去的价格）
 */
+ (NSAttributedString *)addRemoveLineOnString:(NSString*)string;

+(NSString*)removeDecimalAllZero:(NSString*)string;
/**
 字符串加星处理
 
 @param content NSString字符串
 @param findex 第几位开始加星
 @return 返回加星后的字符串
 */
+ (NSString *)encryptionDisplayMessageWith:(NSString *)content WithFirstIndex:(NSInteger)findex;



#pragma mark - nil NULL "space"
+(BOOL)isNULL:(id)string;

#pragma mark - Contains

/**
 *  @return URL是否包含中文
 */
- (BOOL)isContainChinese;
/**
 *  @return 是否包含空格
 */
- (BOOL)isContainBlank;
/**
 *  @return Unicode编码的字符串转成NSString
 */
- (NSString *)makeUnicodeToString;
/**
 *  @brief 是否包含字符集
 */
- (BOOL)containsCharacterSet:(NSCharacterSet *)set;
/**
 *  @brief 获取字符数量
 */
- (int)wordsCount;

//--------------------------- 【正则表达式】 ------------------------------//
//
-(BOOL)isPassWord;
-(BOOL)isAddress;
-(BOOL)isAddress6_8;
- (BOOL)isQQ;
- (BOOL)isPhoneNumber;
- (BOOL)isEmail;
- (BOOL)isIdentityCard;
- (BOOL)isIPAddress;
- (BOOL)isDateCarNo;
- (BOOL)judgeIdentityStringValid:(NSString *)identityString;


#pragma mark - Hash
/// 返回结果：32长度(128位，16字节，16进制字符输出则为32字节长度)   终端命令：md5 -s "123"
@property (readonly) NSString *md5String;
/// 返回结果：40长度   终端命令：echo -n "123" | openssl sha -sha1
@property (readonly) NSString *sha1String;
/// 返回结果：56长度   终端命令：echo -n "123" | openssl sha -sha224
@property (readonly) NSString *sha224String;
/// 返回结果：64长度   终端命令：echo -n "123" | openssl sha -sha256
@property (readonly) NSString *sha256String;
/// 返回结果：96长度   终端命令：echo -n "123" | openssl sha -sha384
@property (readonly) NSString *sha384String;
/// 返回结果：128长度   终端命令：echo -n "123" | openssl sha -sha512
@property (readonly) NSString *sha512String;

#pragma md5
- (NSString *)md5String;

- (NSData *)md5Data;


#pragma mark - HMAC
/// 返回结果：32长度  终端命令：echo -n "123" | openssl dgst -md5 -hmac "123"
- (NSString *)hmacMD5StringWithKey:(NSString *)key;
/// 返回结果：40长度   echo -n "123" | openssl sha -sha1 -hmac "123"
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)hmacSHA224StringWithKey:(NSString *)key;
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)hmacSHA384StringWithKey:(NSString *)key;
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;


@end


