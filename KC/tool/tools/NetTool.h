//
//  NetTool.h
//  PutWallet
//
//  Created by liqiang on 2018/12/10.
//  Copyright © 2018年 Chongqing Letide Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetTool : NSObject

+(void)getDataWithInterface:(NSString *)port Parameters:(NSDictionary *)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

+(void)getTypeDataWithInterface:(NSString *)port Parameters:(NSDictionary *)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

@end
