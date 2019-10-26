//
//  NetTool.m
//  PutWallet
//
//  Created by liqiang on 2018/12/10.
//  Copyright © 2018年 Chongqing Letide Information Technology Co., Ltd. All rights reserved.
//

#import "NetTool.h"

@implementation NetTool

+(void)getDataWithInterface:(NSString *)port Parameters:(NSDictionary *)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *reqUrl = [JCTool arcRandomUrl];
    NSDictionary *d = KOutObj(Klanguage);
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    if ([JCTool isLogin]) {
        [parms setValue:[JCTool share].user.login_uid forKey:@"login_uid"];
    }
    [parms setValue:port forKey:@"service"];
    [parms setValue:[d valueForKey:@"vaule"] forKey:@"lang"];
    [parms setValue:@"2" forKey:@"plat_type"];
    [parms setValue:@"20990912121200000" forKey:@"request_time"];
    [parms setValue:@"5279078C72657CEF" forKey:@"partner_id"];
    [parms setValue:UIDevice.currentDevice.identifierForVendor.UUIDString forKey:@"sessionid"];
//    [parms enumerateKeysAndObjectsUsingBlock:^(NSString  * key, NSString *obj, BOOL * _Nonnull stop) {
//        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
//    }];
   
    
    [manager POST:reqUrl parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
    {
        
        NSDictionary *reD = [responseObject mj_JSONObject];
        
//        JCLog(@"-----%@=",[head valueForKey:@"response_msg"]);
        NSMutableDictionary *succesDic = [NSMutableDictionary dictionary];
        if (reD.count>0)
        {
            NSDictionary *head = [reD valueForKey:@"head"];
            NSDictionary *body = [reD valueForKey:@"body"];
            if ([[head valueForKey:@"response_code"]isEqualToString:@"login"])
            {
                TAlertShow(@"本地登录已失效,请重新登录");
                [JCTool goLoginPage];
                return;
            }
            NSString *login_uid = [head valueForKey:@"login_uid"];
            if (!kStringIsEmpty(login_uid)&&login_uid.length>0) {
                [JCTool share].login_uid = login_uid;
            }
            if ([[head valueForKey:@"response_code"] isEqualToString:@"success"]) {
                [succesDic setValue:@"1" forKey:@"code"];
                [succesDic setValue:body forKey:@"data"];
                [succesDic setValue:[head valueForKey:@"response_msg"] forKey:@"msg"];
            }
            else
            {
                [succesDic setValue:@"-1" forKey:@"code"];
                [succesDic setValue:@"" forKey:@"data"];
                [succesDic setValue:[head valueForKey:@"response_msg"] forKey:@"msg"];
            }
        }
        
        success(succesDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

+(void)getTypeDataWithInterface:(NSString *)port Parameters:(NSDictionary *)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *reqUrl = [[JCTool arcRandomUrl] stringByAppendingString:port];
    
    [manager GET:reqUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
     {
         
         NSDictionary *reD = [responseObject mj_JSONObject];
         if ([reD isKindOfClass:[NSArray class]])
         {
             NSMutableDictionary *succesDic = [NSMutableDictionary dictionary];
             [succesDic setValue:@"1" forKey:@"code"];
             [succesDic setValue:reD forKey:@"data"];
             success(succesDic);

         }else if([reD isKindOfClass:[NSDictionary class]])
         {
             NSMutableDictionary *succesDic = [NSMutableDictionary dictionary];
             if (reD.count>0)
             {
                 if ([[reD valueForKey:@"code"] intValue]==-2&&[JCTool isLogin])
                 {
                     TAlertShow(@"本地登录已失效,请重新登录");
                     [JCTool goLoginPage];
                     return;
                 }
                 [succesDic setValue:[reD valueForKey:@"code"] forKey:@"code"];
                 [succesDic setValue:[reD valueForKey:@"result"] forKey:@"data"];
                 [succesDic setValue:[reD valueForKey:@"msg"] forKey:@"msg"];
             }
             success(succesDic);
         }
         else
         {
             //JCLog(@"111-------%@",responseObject);
             NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
             success(@{@"data":result});
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure(error);
     }];
}
@end
