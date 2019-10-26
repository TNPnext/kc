//
//  NSString+Extension.m
//  ZhengWuApp
//
//  Created by leco on 2017/3/7.
//  Copyright © 2017年 Letide. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Extension)

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformToLatin,NO);
//    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}


+(NSString *)strChangeTwo:(CGFloat)str
{
    //0.00
    if (str==0)
    {
        return @"0";
    }
    NSString *ss = [NSString stringWithFormat:@"%0.2f",str];
    //50.00
    if ([ss hasSuffix:@".00"])
    {
        return [ss substringToIndex:ss.length-3];
    }
    //50.80
    if ([ss hasSuffix:@"0"])
    {
        return [ss substringToIndex:ss.length-1];
    }
    return ss;
}

- (CGSize)sizeFromFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize textSize;
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        
        textSize = [self sizeWithAttributes:attributes];
        
    } else {
        // NSStringDrawingTruncatesLastVisibleLine 内容超出指定的矩形限制，将被截去并在最后一个字符后加上省略号。
        // NSStringDrawingUsesLineFragmentOrigin 该选项被忽略
        // NSStringDrawingUsesFontLeading 计算行高时使用行间距。（字体大小+行间距=行高）
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
    }
    return textSize;
}

- (CGSize)sizeWithText:(NSString*)text lineSpace:(CGFloat)lineSpace font:(CGFloat)font constrainedToSize:(CGSize)size {
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return [self sizeWithAttributes:attributes];
    } else {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = lineSpace;
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paraStyle};
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        return textSize;
    }
}

+ (NSAttributedString*)stringCustomText:(NSString*)text rangString:(NSString*)rangString rangFont:(CGFloat)rangFont rangColor:(UIColor*)rangColor {
    if (kStringIsEmpty(rangString)) {
        rangString = @"";
    }
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttributes:@{NSFontAttributeName:fontSize(rangFont),NSForegroundColorAttributeName:rangColor} range:[text rangeOfString:rangString]];
    return attributedString;
}

+ (NSAttributedString*)stringCustomText:(NSString*)text lineSpacing:(CGFloat)spacing color:(UIColor*)color fontOfSize:(CGFloat)size {
    if (kStringIsEmpty(text)) {
        text = @"";
    }
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSAttributedString* string = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName:[UIFont systemFontOfSize:size], NSParagraphStyleAttributeName: paragraphStyle}];
    return string;
}

+ (NSAttributedString*)stringCustomText:(NSString*)text lineSpacing:(CGFloat)spacing color:(UIColor*)color fontOfSize:(CGFloat)size rangString:(NSString*)rangString rangColor:(UIColor*)rangColor {
    if (kStringIsEmpty(rangString)) {
        rangString = @"";
    }
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSMutableAttributedString* aString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName:[UIFont systemFontOfSize:size], NSParagraphStyleAttributeName: paragraphStyle}];
    [aString addAttributes:@{NSForegroundColorAttributeName:rangColor} range:[text rangeOfString:rangString]];
    return aString;
}

- (NSString *)fileSizeString
{
    // 总大小
    unsigned long long size = 0;
    // 文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    // 文件属性
    NSDictionary *attrs = [manager attributesOfItemAtPath:self error:nil];
    // 如果这个文件或者文件夹不存在,或者路径不正确直接返回0;
    if (attrs == nil) return [NSString stringWithFormat:@"%llu", size];
    
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 如果是文件夹
        // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 文件大小
            NSNumber *fileSize = [manager attributesOfItemAtPath:fullSubpath error:nil][NSFileSize];
            // 累加文件大小
            size += fileSize.unsignedLongLongValue;
        }
        return [NSString sizeStringWith:size];
        
    } else { // 如果是文件
        size = [attrs[NSFileSize] unsignedLongLongValue];
        
        return [NSString sizeStringWith:size];
    }
}

+ (NSString *)sizeStringWith:(unsigned long long)fileSize
{
    NSString *sizeString;
    
    if (fileSize >= pow(10, 9)) { // size >= 1GB
        sizeString = [NSString stringWithFormat:@"%.2fGB", fileSize / pow(10, 9)];
    } else if (fileSize >= pow(10, 6)) { // 1GB > size >= 1MB
        sizeString = [NSString stringWithFormat:@"%.2fMB", fileSize / pow(10, 6)];
    } else if (fileSize >= pow(10, 3)) { // 1MB > size >= 1KB
        sizeString = [NSString stringWithFormat:@"%.2fKB", fileSize / pow(10, 3)];
    } else { // 1KB > size
        sizeString = [NSString stringWithFormat:@"%zdB", fileSize];
    }
    
    return sizeString;
}

- (NSString *)directorySize
{
    // 总大小
    unsigned long long size = 0;
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    BOOL exist = [manager fileExistsAtPath:self isDirectory:&isDir];
    
    // 判断路径是否存在
    if (!exist) return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
    if (isDir) { // 是文件夹
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            NSNumber *fileSize = [manager attributesOfItemAtPath:fullPath error:nil][NSFileSize];
            size += [fileSize unsignedLongLongValue];
        }
    } else { // 是文件
        NSNumber *fileSize = [manager attributesOfItemAtPath:self error:nil][NSFileSize];
        size += [fileSize unsignedLongLongValue];
    }
    return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
}

- (instancetype)docDir
{
    return [[NSString documentPath] stringByAppendingPathComponent:[self lastPathComponent]];
}
- (instancetype)libDir
{
    return [[NSString libraryPath] stringByAppendingPathComponent:[self lastPathComponent]];
}
- (instancetype)cacheDir
{
    return [[NSString cachePath] stringByAppendingPathComponent:[self lastPathComponent]];
}
- (instancetype)tempDir
{
    return [[NSString tempPath] stringByAppendingPathComponent:[self lastPathComponent]];
}

+ (NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}
+ (NSString *)libraryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}
+ (NSString *)cachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}
+ (NSString *)tempPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)appVersion
{
    return [NSBundle.mainBundle.infoDictionary valueForKey:@"CFBundleShortVersionString"];
}
+ (NSString *)buildVersion
{
    return [NSBundle.mainBundle.infoDictionary valueForKey:@"CFBundleVersion"];
}
+ (NSString *)displayName
{
    return [NSBundle.mainBundle.localizedInfoDictionary valueForKey:@"CFBundleDisplayName"];
}
+ (NSString *)bundleIdentifier
{
    return NSBundle.mainBundle.bundleIdentifier;
}
+ (NSString *)localeLanguage
{
    return [[NSLocale preferredLanguages] firstObject];
}

- (CompareResultType)versionCompare:(NSString *)oldVersion
{
    NSArray *currentVersionArray = [self componentsSeparatedByString:@"."];
    NSArray *oldVersionArray = [oldVersion componentsSeparatedByString:@"."];
    
    NSInteger currentVersionLength = currentVersionArray.count;
    NSInteger oldVersionLength = oldVersionArray.count;
    
    // 小数点个数不相等，按下标索引从小到大比较，若较小的位数都相同，那么较大位数的大（1.1.1 > 1.1）
    if (currentVersionLength != oldVersionLength) {
        NSInteger smallerLength = currentVersionLength < oldVersionLength ? currentVersionLength : oldVersionLength;
        for (int i = 0; i < smallerLength; i++) {
            if ([currentVersionArray[i] intValue] < [oldVersionArray[i] intValue]) {
                return SmallerResultType;
            } else if ([currentVersionArray[i] intValue] > [oldVersionArray[i] intValue]) {
                return BiggerResultType;
            } else {
                continue; //相等就继续
            }
        }
        //前面的都相等, （1.1.1 > 1.1）
        return currentVersionLength < oldVersionLength ? SmallerResultType : BiggerResultType;
    } else {
        //小数点个数相等，按下标索引从小到大比较
        for (int i = 0; i < currentVersionLength; i++) {
            if ([currentVersionArray[i] intValue] < [oldVersionArray[i] intValue]) {
                return SmallerResultType;
            } else if ([currentVersionArray[i] intValue] > [oldVersionArray[i] intValue]) {
                return BiggerResultType;
            } else {
                continue; //相等就继续
            }
        }
    }
    return EqualResultType;
}

- (CGSize)sizeFromFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode
{
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attributes = [NSMutableDictionary new];
        attributes[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attributes[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attributes context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font
{
    CGSize size = [self sizeFromFont:font size:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = [self sizeFromFont:font size:CGSizeMake(width, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping];
    return size.height;
}


+ (NSString *)strmethodComma:(NSString *)str
{
    NSString *intStr;
    NSString *floStr;
    
    if ([str containsString:@"."]) {
        NSRange range = [str rangeOfString:@"."];
        floStr = [str substringFromIndex:range.location];
        intStr = [str substringToIndex:range.location];
        
    } else {
        floStr = @"";
        intStr = str;
    }
    
    if (intStr.length <=3 ) {
        return [intStr stringByAppendingString:floStr];
        
    } else {
        NSInteger length = intStr.length;
        NSInteger count = length/3;
        NSInteger y = length % 3;
        NSString *tit = [intStr substringToIndex:y];
        
        NSMutableString *det = [[intStr substringFromIndex:y] mutableCopy];
        
        for (int i = 0; i < count; i++) {
            NSInteger index = i + i * 3;
            [det insertString:@","atIndex:index];
        }
        if (y == 0) {
            det = [[det substringFromIndex:1] mutableCopy];
        }
        
        intStr = [tit stringByAppendingString:det];
        return [intStr stringByAppendingString:floStr];
    }
}

- (NSString *)safeString
{
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([self isKindOfClass:[NSNull class]] ||
        self == nil ||
        self == NULL ||
        [[self stringByTrimmingCharactersInSet:set] length] == 0)
    {
        return @"";
    }
    return self;
}

-(NSMutableAttributedString *)insertImg:(UIImage *)Img atIndex:(NSInteger )index IMGrect:(CGRect )IMGrect
{
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self];
    
    if (![NSString isNULL:self] && index <= self.length - 1) {
        
        NSTextAttachment *attatchment = [[NSTextAttachment alloc] init];
        attatchment.image = Img;
        attatchment.bounds = IMGrect;
        [attributedText insertAttributedString:[NSAttributedString attributedStringWithAttachment:attatchment] atIndex:index];
    }
    
    return attributedText;
}

+(BOOL)isNULL:(id)string{
    
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSAttributedString *)addRemoveLineOnString:(NSString*)string {
    NSMutableAttributedString* newString = [[NSMutableAttributedString alloc] initWithString:string];
    [newString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newString.length)];
    return newString;
}

+ (NSString*)removeDecimalAllZero:(NSString*)string {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString* formatterString = [formatter stringFromNumber:[NSNumber numberWithFloat:[string doubleValue]]];
    NSRange range = [formatterString rangeOfString:@"."]; //现获取要截取的字符串位置
    if (range.length > 0) {
        NSString* result = [formatterString substringFromIndex:range.location]; //截取字符串
        if (result.length >= 4) {
            formatterString=[formatterString substringToIndex:formatterString.length - 1];
        }
    }
    return formatterString;
}

#pragma mark - 字符串加星处理
+(NSString *)encryptionDisplayMessageWith:(NSString *)content WithFirstIndex:(NSInteger)findex {
    if (findex <= 0) {
        findex = 2;
    }else if (findex + 1 > content.length) {
        findex --;
    }
    return [NSString stringWithFormat:@"%@******%@",[content substringToIndex:findex],[content substringFromIndex:content.length - 2]];
}

#pragma mark - Contains
/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)isContainChinese
{
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)isContainBlank
{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

//Unicode编码的字符串转成NSString
- (NSString *)makeUnicodeToString
{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

- (BOOL)containsCharacterSet:(NSCharacterSet *)set
{
    NSRange rang = [self rangeOfCharacterFromSet:set];
    if (rang.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}


/**
 *  @brief 获取字符数量
 */
- (int)wordsCount
{
    NSInteger n = self.length;
    int i;
    int l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++)
    {
        c = [self characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a == 0 && l == 0) {
        return 0;
    }
    return l + (int)ceilf((float)(a + b) / 2.0);
}

//--------------------------- 【正则表达式】 ------------------------------//
//

- (BOOL)match:(NSString *)pattern
{
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

// QQ号验证
- (BOOL)isQQ
{
    // 1.不能以0开头
    // 2.全部是数字
    // 3.5-11位
    return [self match:@"^[1-9]\\d{4,10}$"];
}

// 手机号验证
- (BOOL)isPhoneNumber
{
    NSString *string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (string.length != 11) {
        return NO;
    }
    // 1.全部是数字
    // 2.11位
    // 3.以13\15\18\17开头
    // JavaScript的正则表达式:\^1[3578]\\d{9}$\
    
    return [self match:@"^1[3456789]\\d{9}$"];
}

-(BOOL)isPassWord
{
    //
    return [self match:@"^[0-9A-Za-z]{6,16}$"];
//    return [self match:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"];
}

-(BOOL)isAddress
{
    return [self match:@"^[0-9A-Za-z]{6,60}$"];
}

-(BOOL)isAddress6_8
{
    return [self match:@"^[0-9A-Za-z]{6,8}$"];
}
//邮箱
- (BOOL)isEmail
{
    return [self match:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

//身份证号
- (BOOL)isIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    return [self match:@"^(\\d{14}|\\d{17})(\\d|[xX])$"];
}

// 网址验证
- (BOOL)isIPAddress
{
    // 1-3个数字: 0-255
    // 1-3个数字.1-3个数字.1-3个数字.1-3个数字
    return [self match:@"^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$"];
}

// 车牌号验证
- (BOOL)isDateCarNo
{
    return [self match:@"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$"];
}

#pragma mark 判断身份证号是否合法
- (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    //** 开始进行校验 *//
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex  = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum      += subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod = idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod == 2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    } else {
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}



#pragma mark - Hash

- (NSString *)md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH].lowercaseString;
}

- (NSData *)md5Data
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [NSData dataWithBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha1String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha224String {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA224(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha256String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha384String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA384(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha512String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)hmacMD5StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgMD5 withKey:key];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

- (NSString *)hmacSHA224StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

- (NSString *)hmacSHA384StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
}


#pragma mark - Helpers

- (NSString *)hmacStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key
{
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:size];
    CCHmac(alg, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:(int)mutableData.length];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}



@end
