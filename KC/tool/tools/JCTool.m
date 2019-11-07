//
//  JCTool.m
//  PutWallet
//
//  Created by liqiang on 2018/12/6.
//  Copyright © 2018年 Chongqing Letide Information Technology Co., Ltd. All rights reserved.
//

#define savePath(fliePathName) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",fliePathName]]

#import "JCTool.h"
@implementation JCTool

static JCTool *tool = nil;

+(instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[JCTool alloc]init];
    });
    return tool;
}


+(NSString *)arcRandomUrl
{
    
    //---------测试--------
#ifdef DEBUG
    NSDictionary *testDic = @{@"ip":@"http://192.168.1.200",@"port":@"5002"};
    [JCTool share].urlDic = testDic;
//    return @"http://192.168.1.200:5002/server";
    return @"http://27.159.82.32:8034/server";
#endif
    // return @"";
    NSArray *urlArr = KOutObj(@"Urls");
    if ([urlArr isKindOfClass:[NSArray class]]&&urlArr.count==0)
    {
        NSArray *arr = [self createUrl];
        NSInteger arcount = arc4random()%arr.count;
        NSDictionary *dic = arr[arcount];
        NSString *url = [NSString stringWithFormat:@"%@",[dic valueForKey:@"ip"]];
        [JCTool share].urlDic = dic;
        return url;
    }
    NSInteger arcount = arc4random()%urlArr.count;
    NSDictionary *dic = urlArr[arcount];
    NSString *url = [NSString stringWithFormat:@"%@",[dic valueForKey:@"ip"]];
    [JCTool share].urlDic = dic;
    return url;
}

+(NSArray *)createUrl
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *url = @[@"https://obstoken.io"];
    for (int i = 0; i<url.count; ++i)
    {
        NSDictionary *dic = @{@"ip":url[i]};
        [array addObject:dic];
    }
    
    return array;
}





+(NSString *)getUserid
{
    if ([JCTool isLogin])
    {
        return [JCTool share].user.userid;
    }
    else
    {
        return @"";
    }
}

+(NSString *)getToken
{
//    return @"35CE809900F79ADC";
    NSString *token = [JCTool getJsonWithPath:@"token"];
    if (!kStringIsEmpty(token))
    {
        return token;
    }
    else
    {
        return @"";
    }
}


+(id)getViewControllerWithID:(NSString *)Id
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:Id];;
}

+(id)getViewControllerWithID:(NSString *)Id name:(NSString *)name
{
    return [[UIStoryboard storyboardWithName:name bundle:nil] instantiateViewControllerWithIdentifier:Id];;
}

+(id)getXibViewWithIdx:(NSInteger)idx
{
    return [[NSBundle mainBundle]loadNibNamed:@"XibView" owner:nil options:nil][idx];
}



+(UIFont *)customFontSize:(CGFloat)size
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"DS-DIGIB" ofType:@"TTF"];
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    return font;
}

+(NSAttributedString *)colorWithStr:(NSString *)str Color:(UIColor *)color
{
    if (kStringIsEmpty(str))
    {
        str = @"";
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置富文本对象的颜色
    attributes[NSForegroundColorAttributeName] = color;
    // 设置UITextField的占位文字
    return  [[NSAttributedString alloc] initWithString:str attributes:attributes];
}



+(UIWindow *)getWindow
{
    return [[UIApplication sharedApplication].delegate window];
}

+(UIColor *)themColor
{
    return ColorWithHex(@"5193F4");//亮绿色
}

+(UIColor *)thempurColor
{
    return ColorWithHex(@"ED5AEB");//紫色
}

+(UIColor *)blackColor
{
    return [UIColor blackColor];
}

+(UIColor *)themVCBGColor
{
    return ColorWithHex(@"050B2B");//背景颜色
}



+(BOOL)isLogin
{
    if ([JCTool share].user)
    {
        return 1;
    }
    return 0;
}


+(void)goLoginPage
{
    [JCTool saveJsonWithData:@{} path:Kimportant];
    [JCTool share].user = nil;
    JCNavViewController *loginV = [JCTool getViewControllerWithID:@"LoginVC" name:@"Login"];
    [JCTool getWindow].rootViewController = loginV;
    
}

+(void)goHomePage
{
    TarbarViewController *rootvc = [TarbarViewController new];
    JCNavViewController *nav = [[JCNavViewController alloc]initWithRootViewController:rootvc];
    [JCTool share].HomeNav = nav;
    
    [JCTool getWindow].rootViewController = nav;
    
}

+(BOOL)saveJsonWithData:(id)obj path:(NSString *)fliePath
{
    if (!objectIsEmpty(obj))
    {
        return [NSKeyedArchiver archiveRootObject:obj toFile:savePath(fliePath)];
    }
    return NO;
}

+(id)getJsonWithPath:(NSString *)fliePath
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:savePath(fliePath)];
}

+(NSString *)sixNumber:(NSString *)str
{
    if (str.length>5) {
        return str;
    }
    return [NSString stringWithFormat:@"%06d",[str intValue]];
}

+(NSString *)removeTWOZero:(CGFloat)number
{
    return [JCTool removeZero:number];
//    return  [NSString stringWithFormat:@"%.2f",number];
}
+(NSString *)removeZero:(CGFloat)number
{
    NSString *str = [NSString stringWithFormat:@"%f",number];
    NSArray *arr = [str componentsSeparatedByString:@"."];
    NSString *first = [arr firstObject];
    NSString *last = [arr lastObject];
    while ([last hasSuffix:@"0"])
    {
        last = [last substringToIndex:last.length-1];
        if (last.length<3)
        {
            break;
        }
    }
    if (last.length>=4)
    {
//        NSString *ff = [last substringWithRange:NSMakeRange(3, 1)];
        last = [last substringToIndex:4];
//        if ([ff intValue]>0)
//        {
//            int aa = [last intValue]+1;
//            last = [NSString stringWithFormat:@"%d",aa];
//        }
        
    }
    return [NSString stringWithFormat:@"%@.%@",first,last];
    
}

+(NSString *)removeZeroThree:(CGFloat)number
{
    return [JCTool removeZero:number];
    NSString *str = [NSString stringWithFormat:@"%f",number];
    NSArray *arr = [str componentsSeparatedByString:@"."];
    NSString *first = [arr firstObject];
    NSString *last = [arr lastObject];
    while ([last hasSuffix:@"0"])
    {
        last = [last substringToIndex:last.length-1];
        if (last.length<3)
        {
            break;
        }
    }
    if (last.length>=3)
    {
        last = [last substringToIndex:3];
    }
    return [NSString stringWithFormat:@"%@.%@",first,last];
    
}

+(NSString *)getMaxDate:(NSArray *)dataA
{
    
    NSMutableArray *dateArray = [NSMutableArray array];
    if (dataA.count>0)
    {
        for (NSDictionary *dd in dataA)
        {
            NSString *updateStr = [dd valueForKey:@"updatedt"];
            updateStr = [updateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
            [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
            NSDate *tempDate = [dateFormatter dateFromString:updateStr];//将字符串转换为时间对象
            NSInteger timeStr = [tempDate timeIntervalSince1970];
            NSNumber *nn = [NSNumber numberWithInteger:timeStr];
            [dateArray addObject:nn];
        }
        
        [dateArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        
        NSNumber *laster = [dateArray lastObject];
        NSTimeInterval time = [laster integerValue];
        NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
        return currentDateStr;
        
    }
    return @"2010-01-01 00:00:00";
    
}

+(NSMutableArray *)sortUpdataArray:(NSArray *)array sortDateString:(NSString *)str
{
    NSString *ds = @"updatedt";
    if (str)
    {
        ds = str;
    }
    NSMutableArray *dateArray = [[NSMutableArray alloc]initWithArray:array];
    if (dateArray.count>0)
    {
        [dateArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            return [[JCTool numberWithUpdata:[obj1 valueForKey:ds]] compare:[JCTool numberWithUpdata:[obj2 valueForKey:ds]]];
        }];
        return dateArray;
        
    }
    return @[].mutableCopy;
}

+(NSMutableArray *)sortUpdataArray:(NSArray *)array sortString:(NSString *)str
{
    NSMutableArray *dateArray = [[NSMutableArray alloc]initWithArray:array];
    if (dateArray.count>0)
    {
        [dateArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            return [[NSNumber numberWithDouble:[[obj1 valueForKey:str] doubleValue]] compare:[NSNumber numberWithDouble:[[obj2 valueForKey:str] doubleValue]]];
        }];
        return dateArray;
        
    }
    return @[].mutableCopy;
}

+(NSNumber *)numberWithUpdata:(NSString *)updateStr
{
    NSString * dateStr = [updateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    if ([dateStr containsString:@"."])
    {
        dateStr = [[dateStr componentsSeparatedByString:@"."] firstObject];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:dateStr];//将字符串转换为时间对象
    NSInteger timeStr = [tempDate timeIntervalSince1970];
    return [NSNumber numberWithInteger:timeStr];
}




+(NSString *)getLanguage
{
    /*
    zhcn 简体中文
    zhtw 繁体中文
    en english
    jp  日文
    kr 韩文
    de 德文
    fr 法文
     */
    NSDictionary *dic = KOutObj(Klanguage);
    return [dic valueForKey:@"vaule"];
}

+(CGFloat )getCanPay
{
    return [JCTool share].money.balance-[JCTool share].money.lockcount;
}


+(void)getPriceA10
{
    //查询价格
    TParms;
    [parms setValue:[JCTool share].user.username forKey:@"username"];
    [parms setValue:@"" forKey:@"parm"];
    [parms setValue:[JCTool getLanguage] forKey:@"locale"];
    [parms setValue:@"2" forKey:@"platform"];
    [NetTool getDataWithInterface:@"A10" Parameters:parms success:^(id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        switch (TResCode)
        {
            case 1:
            {
                NSArray *arr = [dict[@"data"] mj_JSONObject];
                if (arr.count<1) {
                    return;
                }
                NSMutableDictionary *priceDic = [NSMutableDictionary dictionary];
                for (NSDictionary *d in arr)
                {
                    [priceDic setValue:d forKey:[NSString stringWithFormat:@"%@",[d valueForKey:@"coinid"]]];
                }
                [JCTool saveJsonWithData:priceDic path:KMpriceDic];
            }
                break;
                
            default:
                break;
        }
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)getFirstLetterFromString:(NSString *)aString
{
    
    NSMutableString *mutableString = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    NSString *pinyinString = [mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    // 将拼音首字母装换成大写
    NSString *strPinYin = [[self polyphoneStringHandle:aString pinyinString:pinyinString] uppercaseString];
    // 截取大写首字母
    NSString *firstString = [strPinYin substringToIndex:1];
    // 判断姓名首位是否为大写字母
    NSString * regexA = @"^[A-Z]$";
    NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
    // 获取并返回首字母
    return [predA evaluateWithObject:firstString] ? firstString : @"#";
    
}

/**
 多音字处理
 */
+ (NSString *)polyphoneStringHandle:(NSString *)aString pinyinString:(NSString *)pinyinString
{
    if ([aString hasPrefix:@"长"]) { return @"chang";}
    if ([aString hasPrefix:@"沈"]) { return @"shen"; }
    if ([aString hasPrefix:@"厦"]) { return @"xia";  }
    if ([aString hasPrefix:@"地"]) { return @"di";   }
    if ([aString hasPrefix:@"重"]) { return @"chong";}
    return pinyinString;
}

+(void)settingPass
{
    if (![JCTool share].user) {
        [JCTool goLoginPage];
        return;
    }
    
    BaseViewController *vc = [JCTool getViewControllerWithID:@"SetPassVC" name:@"Login"];
    [[NSObject currentViewController]presentViewController:vc animated:1 completion:nil];
    
}



+(void)inputPassWord:(void(^)(NSString *password))handler
{
    __block UITextField *inputF;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:TLOCAL(@"请输入交易密码")message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:TLOCAL(@"取消")style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:TLOCAL(@"确定")style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (inputF.text.length>=6) {
            handler(inputF.text);
        }else
        {
            TShowMessage(@"请输入正确的交易密码");
        }
        
    }]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = TLOCAL(@"请输入6-16位交易密码");
        textField.secureTextEntry = 1;
        inputF = textField;
    }];
    
    [[NSObject currentViewController] presentViewController:alert animated:YES completion:nil];
}

+(void)querybalance
{
    if (![JCTool isLogin]) {
        return;
    }
    TParms;
    [NetTool getDataWithInterface:@"rzq.user.coin" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *arr = [dic valueForKey:@"List"];
                NSArray *dataA = [MoneyModel mj_objectArrayWithKeyValuesArray:arr];
                for (MoneyModel *mm in dataA) {
                    if ([mm.coinid intValue]==1) {
                        [JCTool share].money = mm;
                        KPostNoti(KMMChange);
                        break;
                    }
                }
                
            }
                break;
                
            default:
            {
                
            }
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}




+(void)gradient:(UIView *)view
{
    if (!view) {
        return;
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    gradientLayer.colors = @[(__bridge id)ColorWithHex(@"#463AFF").CGColor, (__bridge id)ColorWithHex(@"#3D93FF").CGColor];//这里颜色渐变
    gradientLayer.locations = @[@0, @1.0];//颜色位置
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    [view.layer addSublayer:gradientLayer];
    
}

+(NSString *)getCurrLan
{
    NSDictionary *dic = KOutObj(Klanguage);
    if ([[dic valueForKey:@"vaule"] isEqualToString:@"en"])
    {
        return @"en";
    }
    if ([[dic valueForKey:@"vaule"] isEqualToString:@"zhcn"])
    {
        return @"zhcn";
    }
    if ([[dic valueForKey:@"vaule"] isEqualToString:@"zhtw"])
    {
        return  @"tw";
    }
    return @"en";
}
@end
