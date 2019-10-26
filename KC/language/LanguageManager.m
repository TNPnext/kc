//
//  LanguageManage.m
//  RZQRose
//
//  Created by jian on 2019/5/16.
//  Copyright © 2019 jian. All rights reserved.
//

#import "LanguageManager.h"

@implementation LanguageManager
+(NSString *)changeWithStr:(NSString *)str
{
    NSString *changeStr = @"";
    NSDictionary *dic = KOutObj(Klanguage);
    if (kDictIsEmpty(dic))
    {
        return str;
    }
    switch ([[dic valueForKey:@"idx"] intValue])
    {
        case 1:
            //简体中文
            return str;
            break;
        case 2:
            //繁体中文
          changeStr = [self changeChWithStr:str];
            break;
        case 3:
            //English
          changeStr = [self changeENWithStr:str];
            break;
        default:
            break;
    }
    return changeStr;
}

//繁体中文
+(NSString *)changeChWithStr:(NSString *)str
{
    NSString *changeS = @"";
    NSDictionary *dic;
    dic = @{
             @"语言设置":@"語言設置",
             @"数据加载中...":@"數據加載中...",
            };
    changeS = [dic valueForKey:str];
    return changeS;
}

//English
+(NSString *)changeENWithStr:(NSString *)str
{
    NSString *changeS = @"";
    NSDictionary *dic;
    dic = @{
            @"语言设置":@"Language Setting",
            @"数据加载中...":@"loading...",
            };
    changeS = [dic valueForKey:str];
    return changeS;
}

@end
