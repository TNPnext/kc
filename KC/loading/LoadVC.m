//
//  LoadVC.m
//  RZQRose
//
//  Created by jian on 2019/8/17.
//  Copyright © 2019 jian. All rights reserved.
//

#import "LoadVC.h"
#import <WebKit/WKWebView.h>
@interface LoadVC ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (strong, nonatomic) WKWebView *webView;

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
    _webView = [[WKWebView alloc]init];
    _webView.scrollView.scrollEnabled = 0;
    _webView.scrollView.showsHorizontalScrollIndicator = 0;
    _webView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 300);
     NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"MinerX_start" ofType:@"gif"]];
    [_webView loadData:gif MIMEType:@"image/gif" characterEncodingName:@"UTF-8"  baseURL:nil];
    [self.view addSubview:_webView];
    [self initViews];
}

-(void)initViews
{
    //[self reuestD];
    [self performSelector:@selector(reuestD) withObject:nil afterDelay:3];
}

-(void)reuestD
{
#ifdef DEBUG
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
       NSString *ss =  KOutObj(@"isfirst");
        if (!ss) {
            KSaveObj(@"1", @"isfirst");
            UIViewController *guide = [JCTool getViewControllerWithID:@"GuideVC"];
            [JCTool getWindow].rootViewController = guide;
            return;
        }
        
    
        UserModel *user = [UserModel mj_objectWithKeyValues:dic];
        [JCTool share].user = user;
        [self getConfig];
        [self getzlxy];
        [JCTool goHomePage];
    }
}



-(void)getConfig
{
    TParms;
    [NetTool getDataWithInterface:@"rzq.config.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                //val 501 基金会官网链接 502 邀请链接 503 提币最小数量
                NSArray *arr = [responseObject valueForKey:@"data"];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                for (NSDictionary *dd in arr) {
                    [dic setValue:dd forKey:[NSString stringWithFormat:@"%@",[dd valueForKey:@"idx"]]];
                }
                [JCTool share].configDic = dic;
                
            }
                break;
                
            default:
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)getzlxy
{
    TParms;
    [parms setValue:@"zlxy" forKey:@"code"];
    [NetTool getDataWithInterface:@"rzq.news.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                [JCTool share].xyDic = [list firstObject];
                
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



@end
