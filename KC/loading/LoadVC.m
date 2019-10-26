//
//  LoadVC.m
//  RZQRose
//
//  Created by jian on 2019/8/17.
//  Copyright © 2019 jian. All rights reserved.
//

#import "LoadVC.h"

@interface LoadVC ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@property(nonatomic,assign)int count;
@end

@implementation LoadVC
-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.hidden = 1;
    _count = 0;
    kWeakSelf;
    [SocketTool share].loadingBlock = ^{
        static int a = 0;
        a++;
        if (a%10==0) {
            weakSelf.count++;
        }
    };
    [self initViews];
}

-(void)initViews
{
    
//
//
//    [self goHome];
//
    [self reuestD];
    
}

-(void)reuestD
{
#ifdef DEBUG
    //[self getCoinInfo];
    [self getUserInfo];
#else
    [self getSeverUrl];
#endif
}

-(void)versionUpdate
{
    [[[UIAlertView alloc]initWithTitle:TLOCAL(@"更新提示") message:TLOCAL(@"当前版本过低，需要更新才能体验更好的功能服务") delegate:self cancelButtonTitle:TLOCAL(@"去更新") otherButtonTitles:nil, nil]show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self openUrl];
}

-(void)openUrl
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://dw.pub/obsapple"]];
    [self performSelector:@selector(outApp) withObject:nil afterDelay:0.5];
}

-(void)getSeverUrl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    [manager GET:@"https://obstoken.io/server.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *arr = [responseObject mj_JSONObject];
         if (arr.count>0) {
             KSaveObj(arr, @"Urls");
         }
         [self initData];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self performSelector:@selector(getSeverUrl) withObject:nil afterDelay:5];
     }];
}

-(void)initData
{
    [self getCoinInfo];
    [self getUserInfo];
    
}


//查询用户信息
-(void)getUserInfo
{
    NSDictionary *dic = [JCTool getJsonWithPath:Kimportant];
    if (dic.count<=0)
    {
        [self.imgV stopAnimating];
        [JCTool goLoginPage];
        return;
    }
    else
    {
    
        UserModel *user = [UserModel mj_objectWithKeyValues:dic];
        [JCTool share].user = user;
        [JCTool goHomePage];
        return;
    }
    kWeakSelf;
    NSDate *detailDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    TParms;
    [parms setValue:[JCTool share].user.username forKey:@"username"];
    [parms setValue:TSEC(currentDateStr) forKey:@"parm"];
    [parms setValue:[JCTool getLanguage] forKey:@"locale"];
    [parms setValue:@"2" forKey:@"platform"];
    [NetTool getDataWithInterface:@"/api/queryuserinfo" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSArray *arr = [[responseObject valueForKey:@"data"] mj_JSONObject];
                if ([arr isKindOfClass:[NSArray class]] && arr.count>0)
                {
                    NSDictionary *dd = arr[0];
                    UserModel *user = [UserModel mj_objectWithKeyValues:dd];
                    user.username = [JCTool share].user.username;
                    [JCTool share].user = user;
                    [weakSelf getSeverTime];
                }
                
            }
                break;
            default:
                [weakSelf getSeverTime];
                break;
        }
    } failure:^(NSError *error) {
        [weakSelf getSeverTime];
    }];
}

-(void)goHome
{
    if (_count%3==0 &&_count!=0) {
        [self.imgV stopAnimating];
        
        [JCTool goHomePage];
        
        return;
    }
    [self performSelector:@selector(goHome) withObject:nil afterDelay:1];
    
}

-(void)getCoinInfo
{
    
    TParms;
    [parms setValue:[JCTool getLanguage] forKey:@"locale"];
    [parms setValue:@"2" forKey:@"platform"];
    [NetTool getTypeDataWithInterface:@"/api/coindefine" Parameters:parms success:^(id  _Nullable responseObject) {
        NSString *date = [responseObject valueForKey:@"data"];
        NSArray *arr = [date mj_JSONObject];
        
        NSArray *dataA = [CoinModel mj_objectArrayWithKeyValuesArray:arr];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if ([dataA isKindOfClass:[NSArray class]] && dataA.count>0)
        {
            for (CoinModel *mm in dataA)
            {
                [dict setValue:mm forKey:[NSString stringWithFormat:@"%d",mm.coinid]];
            }
        }
        [JCTool share].coinDic = dict;
//        JCLog(@"-------arr==%@",dataA);
        
    } failure:^(NSError *error) {
        [self performSelector:@selector(getCoinInfo) withObject:nil afterDelay:10];
    }];
    
}


-(void)getSeverTime
{
    kWeakSelf;
    [NetTool getTypeDataWithInterface:@"/api/getsrvtime" Parameters:nil success:^(id  _Nullable responseObject) {
        NSString *date = [responseObject valueForKey:@"data"];
        //date = [date substringWithRange:NSMakeRange(1, 19)];
        NSInteger tt = [[JCTool numberWithUpdata:date] integerValue];
        //NSInteger now = [[NSDate date]timeIntervalSince1970];
        [JCTool share].diff = tt;
        [weakSelf goHome];
    } failure:^(NSError *error) {
        [self performSelector:@selector(getSeverTime) withObject:nil afterDelay:10];
    }];
    
}

-(void)getSeverTime2
{
    //kWeakSelf;
    [NetTool getTypeDataWithInterface:@"/api/getsrvtime" Parameters:nil success:^(id  _Nullable responseObject) {
        NSString *date = [responseObject valueForKey:@"data"];
        
        NSInteger tt = [[JCTool numberWithUpdata:date] integerValue];
        
        [JCTool share].diff = tt;
        
    } failure:^(NSError *error) {
        [self performSelector:@selector(getSeverTime) withObject:nil afterDelay:10];
    }];
    
}


@end
