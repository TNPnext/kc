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
-(NSString *)fee
{
    CoinModel *mm = [[JCTool share].coinDic valueForKey:_coinid];
    return [JCTool removeZero:mm.fee];
}
-(NSString *)logourl
{
    CoinModel *mm = [[JCTool share].coinDic valueForKey:_coinid];
    return mm.logourl;
}
@end

@implementation GameModel
@end

@implementation GameDModel
@end

@implementation JoinModel
-(NSString *)stateStr
{
    NSString *s = @"";
    // 0待确认 1 排队中  2 部分确认   3 全部确认
    switch (_state) {
        case 0:
            s = @"待确认";
            break;
        case 1:
            s = @"排队中";
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

@implementation IncomeModel
-(NSString *)stateStr
{
    NSString *s = @"";
    //0  待确认  1 已确认
    switch (_state) {
        case 0:
            s = @"待确认";
            break;
        case 1:
            s = @"已确认";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}
@end

@implementation OutModel
-(NSString *)stateStr
{
    NSString *s = @"";
    //0待审核  1待发出 2已发出  3已到账 9已退回
    switch (_state) {
        case 0:
            s = @"待审核";
            break;
        case 1:
            s = @"待发出";
            break;
        case 2:
            s = @"已发出";
            break;
        case 3:
            s = @"已到账";
            break;
        case 9:
            s = @"已退回";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}
@end

@implementation RewardModel
-(NSString *)stateStr
{
    NSString *s = @"";
    switch (_state) {
        case 0:
            s = @"未发放";
            break;
        case 1:
            s = @"已发放";
            break;
        
        default:
            break;
    }
    return TLOCAL(s);
}

@end

@implementation HomeListModel
-(NSString *)jtStr
{
    NSString *s = @"";
    //0 全部复投   1 本金复投  2 利息复投  3 全部提现
    switch (_jtopcode) {
        case 0:
            s = @"全部复投";
            break;
        case 1:
            s = @"本金复投";
            break;
        case 2:
            s = @"利息复投";
            break;
        case 3:
            s = @"全部提现";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}

-(NSString *)dtStr
{
    NSString *s = @"";
    //0 全部复投   1 全部提现
    switch (_dtopcode) {
        case 0:
            s = @"全部复投";
            break;
        case 1:
            s = @"全部提现";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}

-(NSString *)stateStr
{
    //1 进行中  2 已结束  3 已清算
    NSString *s = @"";
    switch (_dtopcode) {
        case 1:
            s = @"进行中";
            break;
        case 2:
            s = @"已结束";
            break;
        case 3:
            s = @"已清算";
            break;
        default:
            break;
    }
    return TLOCAL(s);
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

@implementation YJModel


@end

@implementation AdModel


@end
@implementation BannerModel


@end

@implementation ZXModel


@end

@implementation CoinModel
-(NSString *)coinName
{
    switch (_coinid) {
        case 1:
            return @"BTC";
            break;
        case 2:
            return @"ETH";
            break;
        case 3:
            return @"EOS";
            break;
        case 4:
            return @"LTC";
            break;
        case 5:
            return @"BCH";
            break;
            
        default:
            break;
    }
    return @"";
}

@end


@implementation HModel

-(NSString *)stateStr
{
    NSString *s = @"";
    //0 即将开始
    //1 众筹中
    //2 已完成
    //3 止损轮
    //4 众筹失败
    switch (_state) {
        case 0:
            s = @"即将开始";
            break;
        case 1:
            s = @"众筹中";
            break;
        case 2:
            s = @"已完成";
            break;
        case 3:
            s = @"止损期";
            break;
        case 4:
            s = @"众筹失败";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}

@end

@implementation WalletReInModel

-(NSString *)stateStr
{
    NSString *s = @"";
    switch (_state) {
        case 0:
            s = @"待确认";
            break;
        case 1:
            s = @"已确认";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}

@end

@implementation WalletReOutModel

-(NSString *)stateStr
{
    NSString *s = @"";
    switch (_state) {
        case 0:
        case 1:
            s = @"待发出";
            break;
        case 2:
            s = @"已发出";
            break;
        case 3:
            s = @"已到账";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}

@end


@implementation GRZBModel



@end


@implementation OETModel



@end

@implementation TXModel

-(NSString *)typeStr
{
    NSString *s = @"";
    switch (_forwhat) {
        case 1:
            s = @"众筹奖励";
            break;
        case 2:
            s = @"节点奖励";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}
@end

@implementation RGModel

-(NSString *)stateStr
{
    //0 待确认 1 USDT发出 2 USDT到账  3OBS发出 4OBS到账
    NSString *s = @"";
    switch (_state) {
        case 0:
            s = @"待确认";
            break;
        case 1:
            s = @"USDT发出";
            break;
        case 2:
            s = @"USDT到账";
            break;
        case 3:
            s = @"OBS发出";
            break;
        case 4:
            s = @"OBS到账";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}

@end

@implementation WTModel
-(NSString *)statuStr
{
    ////1 待成交   2 部分成交  3 已成交    0 已撤单
    NSString *s = @"";
    switch (_status) {
        case 1:
            s = @"待成交";
            break;
        case 2:
            s = @"部分成交";
            break;
        case 3:
            s = @"已成交";
            break;
        case 0:
            s = @"已撤单";
            break;
        default:
            break;
    }
    return TLOCAL(s);
}
@end

@implementation BBHZModel

-(NSString *)stateStr
{
    NSString *s = @"";
    switch (_state) {
        case 0:
            s = @"待确认";
            break;
        case 1:
            s = @"已确认";
            break;
        
        default:
            break;
    }
    return TLOCAL(s);
}
@end
