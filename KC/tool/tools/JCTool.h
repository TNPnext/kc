//
//  JCTool.h
//  PutWallet
//
//  Created by liqiang on 2018/12/6.
//  Copyright © 2018年 Chongqing Letide Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "Header.h"
#import "TNPTarbarView.h"
@class GoodsModel;
@class MoneyModel;
@class UserModel;
@class DeckViewController;
@class JCNavViewController;
@interface JCTool : NSObject

+(instancetype)share;

@property(nonatomic,assign)BOOL AppIsActive;
@property(nonatomic,copy)NSString *login_uid;
@property(nonatomic,strong)UserModel *user;
@property(nonatomic,strong)MoneyModel *money;
@property(nonatomic,strong)NSDictionary *coinDic;//包含logo fee
@property(nonatomic,strong)NSDictionary *moneyDic;
@property(nonatomic,strong)NSDictionary *tradeMoneyDic;


@property(nonatomic,strong)HModel *currGameM;//当前进行的轮次
@property(nonatomic,assign)BOOL ishangqingpage;
@property(nonatomic,strong)DeckViewController *leftVc;
@property(nonatomic,strong)JCNavViewController *HomeNav;


@property(nonatomic,copy)NSString *currthreadId;//当前选中的线程
@property(nonatomic,strong)NSDictionary *gameCurrDic;//线程对应 当前轮次


@property(nonatomic,strong)NSDictionary *gameDic;




@property(nonatomic,strong)TNPTarbarView *tarbarV;
@property(nonatomic,copy)NSString *tempStr;
@property(nonatomic,assign)NSInteger diff;//与服务器的时间差
@property(nonatomic,assign)NSInteger activeTime;//红包时间
@property(nonatomic,strong)NSDictionary *urlDic;


+(CGFloat )getCanPay;
+(NSString *)getLanguage;
+(UIWindow *)getWindow;
+(UIColor *)themColor;
+(UIColor *)thempurColor;
+(UIColor *)blackColor;
+(UIColor *)themVCBGColor;


+(NSString *)getSimpleCoinName:(NSInteger)num;
+(NSString *)getFullCoinName:(NSInteger)num;
+(NSString *)getCoinImageName:(NSInteger)num;

+(id)getViewControllerWithID:(NSString *)Id;
+(id)getViewControllerWithID:(NSString *)Id name:(NSString *)name;
+(id)getXibViewWithIdx:(NSInteger)idx;
+(NSString *)arcRandomUrl;



+(BOOL)isLogin;
+(NSString *)getUserid;
+(NSString *)getToken;
+(void)goLoginPage;
+(void)goHomePage;



//
+(NSString *)removeTWOZero:(CGFloat)number;//2
+(NSString *)removeZeroThree:(CGFloat)number;//3
+(NSString *)removeZero:(CGFloat)number;//4
+(UIFont *)customFontSize:(CGFloat)size;//自定义字体
+(NSAttributedString *)colorWithStr:(NSString *)str Color:(UIColor *)color;



//传入数组带时间返回最大的时间
+(NSString *)getMaxDate:(NSArray *)dataA;
//根据时间排序以小到大的时间排序
+(NSMutableArray *)sortUpdataArray:(NSArray *)array sortDateString:(NSString *)str;

//根据需要的数字字符串以小到大的时间排序
+(NSMutableArray *)sortUpdataArray:(NSArray *)array sortString:(NSString *)str;

//转换为时间戳格式
+(NSNumber *)numberWithUpdata:(NSString *)updateStr;


//-----
+(BOOL)saveJsonWithData:(id)obj path:(NSString *)fliePath;
+(id)getJsonWithPath:(NSString *)fliePath;
//-----
+ (NSString *)getFirstLetterFromString:(NSString *)aString;

//设置交易密码
+(void)settingPass;
//输入支付密码
+(void)inputPassWord:(void(^)(NSString *password))handler;

+(void)querybalance;
+(NSString *)getCurrLan;
+(void)gradient:(UIView *)view;
@end
