//
//  Macros.h
//  TNP
//
//  Created by TNP on 2000/10/10.
//  Copyright © 2000年 TNP. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

// 开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
#define JCLog(FORMAT, ...) NSLog((@"[File:%s]" "[Func:%s]" "[Line:%d] " FORMAT), [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define JCLog(...)
#endif

/** 弱引用 */
#define kWeakSelf         __weak typeof(self) weakSelf = self;

//系统版本
#define kSystemVersion    [[UIDevice currentDevice].systemVersion floatValue]
#define kSystemiOS10      (kSystemVersion >= 10.0)
#define kSystemiOS9       (kSystemVersion >= 9.0)
#define kSystemiOS8       (kSystemVersion >= 8.0)

/*****************  屏幕适配  ******************/
#define iphone6p (SCREEN_HEIGHT == 763)
#define iphone6 (SCREEN_HEIGHT == 667)
#define iphone5 (SCREEN_HEIGHT == 568)

/*** 全局配置 ***/
#define kUUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

#define SCREEN_WIDTH      [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height

#define NAV_HEIGHT          (iPhoneXSeries() ? 88 : 64)
#define STATUSBAR_HEIGHT    (iPhoneXSeries() ? 44 : 20)
#define TABBAR_HEIGHT       (iPhoneXSeries() ? 83 : 49)
#define TOP_SAFE_SPACE      (iPhoneXSeries() ? 24 : 0)
#define BOTTOM_SAFE_SPACE   (iPhoneXSeries() ? 34: 0)
#define HEIGHT_NO_STATUSBAR SCREEN_HEIGHT - STATUSBAR_HEIGHT

#define RGBA(r,g,b,a)     [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define kLineColor            ColorWithHex(@"#dddddd") //线条颜色
#define kTextColor3           ColorWithHex(@"#333333")
#define kTextColor6           ColorWithHex(@"#666666")
#define kTextColor9           ColorWithHex(@"#999999")

#define KPostNotiobj(name,OBJ) [[NSNotificationCenter defaultCenter]postNotificationName:name object:OBJ];
#define KPostNoti(name) [[NSNotificationCenter defaultCenter]postNotificationName:name object:nil];
#define KAddNoti(SEL,pname) [[NSNotificationCenter defaultCenter]addObserver:self selector:SEL name:pname object:nil]

#define KSaveObj(obj,key) [[NSUserDefaults standardUserDefaults]setValue:obj forKey:key];\
[[NSUserDefaults standardUserDefaults]synchronize]
#define KOutObj(key) [[NSUserDefaults standardUserDefaults]valueForKey:key]

#define TShowMessage(message) [SVProgressHUD showInfoWithStatus:TLOCAL(message)]
#define TShowResMsg [SVProgressHUD showInfoWithStatus:[responseObject valueForKey:@"msg"]]
#define TShowNetError [SVProgressHUD showInfoWithStatus:TLOCAL(@"网络错误")]

#define TAlertShowResMsg [NSObject showAlertWithTitle:[responseObject valueForKey:@"msg"]]
#define TAlertShowNetError [NSObject showAlertWithTitle:TLOCAL(@"网络错误")]
#define TAlertShow(msg)[NSObject showAlertWithTitle:TLOCAL(msg)]


#define Kimportant @"important"
#define KMpriceDic [NSString stringWithFormat:@"KMpriceDic%@%@",[NSString appVersion],[JCTool getUserid]]
#define KMoneyDic [NSString stringWithFormat:@"KMoneyDic%@%@",[NSString appVersion],[JCTool getUserid]]
#define KFriendsDic [NSString stringWithFormat:@"KFriendsDic%@%@",[NSString appVersion],[JCTool getUserid]]
#define KLianJAsDic [NSString stringWithFormat:@"KLianJAsDic%@%@",[NSString appVersion],[JCTool getUserid]]
#define KMoneyRecordPath [NSString stringWithFormat:@"KMoneyRecordPath%@%@",[NSString appVersion],[JCTool getUserid]]
#define KENRecordPath [NSString stringWithFormat:@"KENRecordPath%@%@",[NSString appVersion],[JCTool getUserid]]
#define KPushRecordPath [NSString stringWithFormat:@"KPushRecordPath%@%@",[NSString appVersion],[JCTool getUserid]]
#define KNewsHRecordPath [NSString stringWithFormat:@"KNewsHRecordPath%@%@",[NSString appVersion],[JCTool getUserid]]
#define KDontReadPath [NSString stringWithFormat:@"KDontReadPath%@%@",[NSString appVersion],[JCTool getUserid]]
#define KMySenderPath [NSString stringWithFormat:@"KMySenderPath%@%@",[NSString appVersion],[JCTool getUserid]]
#define KOtherSenderPath [NSString stringWithFormat:@"KOtherSenderPath%@%@",[NSString appVersion],[JCTool getUserid]]



#define TLOCAL(ss) [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[KOutObj(Klanguage) valueForKey:@"app"] ofType:@"lproj"]] localizedStringForKey:(ss) value:nil table:nil]

#define TParms NSMutableDictionary *parms = [NSMutableDictionary dictionary]
#define TInitArray _dataArray = [NSMutableArray array]
#define TSEC(sss) [SecurityUtil encryptAESData:sss Key:[JCTool getToken]]
#define TResCode [[responseObject valueForKey:@"code"] intValue]
#define TPlaceIMg [UIImage imageNamed:@"placeholder"]


//余额变动
#define KMMChange @"moneyChange"
#define KBBChange @"moneyBBChange"
#define KHaveNew @"haveNewMessage"

#define Klanguage @"language"




// 参照屏幕宽度（iphone 6）
static CGFloat const IPHONE_WIDTH = 375.0;
static CGFloat const IPHONE_HEIGHT = 667.0;

// fminf(1.0, SCREEN_WIDTH / IPHONE_WIDTH);
static inline CGFloat AdaptationWidth() {
    return SCREEN_WIDTH / IPHONE_WIDTH;
}

static inline CGFloat AdaptationHeight() {
    return SCREEN_HEIGHT / IPHONE_HEIGHT;
}

static inline CGFloat CGRatioWidth(CGFloat s) {
    return ceilf(s * AdaptationWidth());
}

static inline CGFloat CGRatioHeight(CGFloat s) {
    return ceilf(s * AdaptationHeight());
}

static inline CGSize AdaptationSize(CGFloat width, CGFloat height) {
    CGFloat newWidth = width * AdaptationWidth();
    CGFloat newHeight = height * AdaptationHeight();
    
    return CGSizeMake(newWidth, newHeight);
}

static inline CGPoint AdaptationCenter(CGFloat x, CGFloat y) {
    CGFloat newX = x * AdaptationWidth();
    CGFloat newY = y * AdaptationHeight();
    
    return CGPointMake(newX, newY);
}

static inline CGRect AdaptationFrame(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    CGFloat newX = x * AdaptationWidth();
    CGFloat newY = y * AdaptationHeight();
    CGFloat newWidth = width * AdaptationWidth();
    CGFloat newHeight = height * AdaptationHeight();
    
    return CGRectMake(newX, newY, newWidth, newHeight);
}

static inline CGRect CGRectSizeMake(CGFloat x, CGFloat y, CGSize size) {
    CGRect rect;
    rect.origin.x = ceilf(x);
    rect.origin.y = ceilf(y);
    rect.size.width = ceilf(size.width);
    rect.size.height = ceilf(size.height);
    return rect;
}

static inline UIFont *Font(CGFloat s) {
    if (kSystemiOS9) {
        return [UIFont fontWithName:@"PingFangSC-Regular" size:CGRatioWidth(s)];
    } else {
        return [UIFont systemFontOfSize:CGRatioWidth(s)];
    }
}

static inline UIFont *BoldFont(CGFloat s) {
    if (kSystemiOS9) {
        return [UIFont fontWithName:@"PingFangSC-Semibold" size:CGRatioWidth(s)];
    } else {
        return [UIFont boldSystemFontOfSize:CGRatioWidth(s)];
    }
}

/*** 判断是否为空 ***/
static inline BOOL kStringIsEmpty(NSString *str) {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([str isKindOfClass:[NSNull class]] ||
        str == nil ||
        str == NULL ||
        [[str stringByTrimmingCharactersInSet:set] length] == 0)
    {
        return YES;
    }
    return NO;
}

static inline BOOL kArrayIsEmpty(NSArray *array) {
    if (array == nil ||
        [array isKindOfClass:[NSNull class]] ||
        array.count == 0)
    {
        return YES;
    }
    return NO;
}

static inline BOOL kDictIsEmpty(NSDictionary *dic) {
    if (dic == nil ||
        [dic isKindOfClass:[NSNull class]] ||
        dic.allKeys == 0)
    {
        return YES;
    }
    return NO;
}

static inline BOOL kObjectIsEmpty(id _object) {
    if (_object == nil ||
        [_object isKindOfClass:[NSNull class]] ||
        ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) ||
        ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
    {
        return YES;
    }
    return NO;
}

#endif /* Macros_h */
