//
//  GeneralModel.m
//  PUT
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 TNP. All rights reserved.
//

#import "GeneralModel.h"
#import <MJExtension.h>

@implementation UserModel
@end

@implementation MoneyModel
-(NSString *)coinName
{
    CoinModel *mm = [[JCTool share].coinDic valueForKey:_coinid];
    return mm.coinname;
}


@end


@implementation SugModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"cid":@"id"};
}
-(NSString *)stateStr
{
    NSString *s = @"";
    //0-待处理  1  已经回复  2已关闭
    switch (_state) {
        case 0:
            s = @"待处理";
            break;
        case 1:
            s = @"已回复";
            break;
        case 2:
            s = @"已关闭";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}

@end



@implementation AdModel


@end
@implementation BannerModel


@end

@implementation ZXModel


@end

@implementation CoinModel


@end



@implementation prductModel


@end

@implementation SYModel
-(NSString *)stateStr
{
    NSString *s = @"";
    //0 未到账 1 已到账

    switch (_state) {
        case 0:
            s = @"未到账";
            break;
        case 1:
            s = @"已到账";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}
@end

@implementation MyPrudctModel
-(NSString *)stateStr
{
    NSString *s = @"";
    //预约中 1 购买中   2 已结束
    switch (_state) {
        case 0:
            s = @"预约中";
            break;
        case 1:
            s = @"购买中";
            break;
            case 2:
            s = @"已结束";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}
@end

@implementation MyYYReModel
-(NSString *)stateStr
{
    NSString *s = @"";
    //    1预约中，2部分确认（部分购买），3完全确认（全部购买）
    switch (_state) {
        case 1:
            s = @"预约中";
            break;
        case 2:
            s = @"部分确认";
            break;
            case 3:
            s = @"全部确认";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}
@end


@implementation WalletListModel
-(NSString *)stateStr
{
    NSString *s = @"";
    //0 未确认  1已确认 9作废
    switch (_state) {
        case 0:
            s = @"未确认";
            break;
        case 1:
            s = @"已确认";
            break;
            case 9:
            s = @"作废";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}
-(NSString *)typeStr
{
    NSString *s = @"";
    //1 转入   2 转出  3 收益 4 社区奖励(矿池)  5 社群奖励(节点) 6矿机购置 7退款
    switch (_tradetype) {
        case 1:
            s = @"转入";
            break;
            case 2:
            s = @"转出";
            break;
            case 3:
            s = @"矿机收益";
            break;
            case 4:
            s = @"社区奖励";
            break;
            case 5:
            s = @"节点分红";
            break;
            case 6:
            s = @"矿机购置";
            break;
            case 7:
            s = @"退款";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}
@end
