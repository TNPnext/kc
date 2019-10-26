//
//  GeneralModel.h
//  PUT
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 TNP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *area;
@property(nonatomic,copy)NSString *invitepath;
@property(nonatomic,copy)NSString *inviterid;
@property(nonatomic,copy)NSString *isactive;
@property(nonatomic,copy)NSString *mail;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *mycode;
@property(nonatomic,copy)NSString *login_uid;
@property(nonatomic,assign)int transcodeseted;//是否设置交易密码
@property(nonatomic,assign)int userlevel;

//
@property(nonatomic,assign)CGFloat total;

//
@property(nonatomic,copy)NSString *showname;

@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *invitercode;
@property(nonatomic,assign)int thirdpart;


//share
@property(nonatomic,assign)CGFloat totaladded;
@property(nonatomic,assign)CGFloat selfadded;

@end


@interface MoneyModel : NSObject
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,assign)CGFloat balance;
@property(nonatomic,assign)CGFloat lockcount;

//
@property(nonatomic,copy)NSString *coinName;
@property(nonatomic,copy)NSString *logourl;
@property(nonatomic,copy)NSString *fee;

@end


@interface GameModel : NSObject
@property(nonatomic,copy)NSString *threadid;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,assign)CGFloat needamount;
@property(nonatomic,assign)CGFloat progress;
@property(nonatomic,copy)NSString *stime;
@property(nonatomic,copy)NSString *etime;
@property(nonatomic,copy)NSString *updatedt;
@property(nonatomic,assign)int status;//0未开始 1进行中  2结束
@property(nonatomic,assign)int iscurrent;
@property(nonatomic,assign)int nextstage_count;

@end

@interface GameDModel : NSObject
@property(nonatomic,copy)NSString *threadid;
@property(nonatomic,copy)NSString *IDx;
@property(nonatomic,copy)NSString *PerNum;
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,copy)NSString *roundid;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,assign)CGFloat amount;
@property(nonatomic,assign)CGFloat Income;
@property(nonatomic,assign)CGFloat fee;
@property(nonatomic,assign)int recharge;//复投
@property(nonatomic,copy)NSString *confirmdt;
@property(nonatomic,copy)NSString *selecttime;
@property(nonatomic,copy)NSString *updatedt;
@property(nonatomic,assign)int status;
@property(nonatomic,copy)NSString *incomeaddr;
@property(nonatomic,copy)NSString *incomehash;
@property(nonatomic,assign)int incomestate;

@end


@interface JoinModel : NSObject
@property(nonatomic,assign)int threadid;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *idx;
@property(nonatomic,copy)NSString *updatedt;
@property(nonatomic,assign)int state;//1 排队中  2 部分确认   3 全部确认
@property(nonatomic,copy)NSString *incomedetail;
@property(nonatomic,copy)NSString *dtime;
@property(nonatomic,assign)CGFloat inamount;
@property(nonatomic,assign)CGFloat confirmamount;
@property(nonatomic,assign)CGFloat queueamount;
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,copy)NSString *incomeaddr;
@property(nonatomic,copy)NSString *tradehash;


@property(nonatomic,copy)NSString *stateStr;
@end

@interface IncomeModel : NSObject
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *IDX;
@property(nonatomic,copy)NSString *updatedt;
@property(nonatomic,copy)NSString *block;
@property(nonatomic,copy)NSString *blockidx;
@property(nonatomic,assign)int state;//0  待确认  1 已确认
@property(nonatomic,copy)NSString *tradehash;
@property(nonatomic,copy)NSString *dtime;
@property(nonatomic,assign)CGFloat inamount;
@property(nonatomic,assign)CGFloat confirmamount;
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,copy)NSString *outaddr;

@property(nonatomic,copy)NSString *stateStr;
@end

@interface OutModel : NSObject
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *IDX;
@property(nonatomic,copy)NSString *updatedt;
@property(nonatomic,assign)int state;//0 待审核  1 已发出  2 已到账
@property(nonatomic,copy)NSString *requestime;
@property(nonatomic,copy)NSString *audittime;
@property(nonatomic,assign)CGFloat inamount;
@property(nonatomic,assign)CGFloat amount_num;
@property(nonatomic,assign)CGFloat fee_num;
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,copy)NSString *target;
@property(nonatomic,copy)NSString *checksum;
@property(nonatomic,copy)NSString *tradehash;

@property(nonatomic,copy)NSString *stateStr;
@end

@interface RewardModel : NSObject
@property(nonatomic,assign)CGFloat amount;
@property(nonatomic,copy)NSString *dtime;
@property(nonatomic,copy)NSString *tradehash;
@property(nonatomic,copy)NSString *tradetime;
@property(nonatomic,copy)NSString *updatedt;
@property(nonatomic,assign)int forwhat;//1 节点奖励  2 社区奖励
@property(nonatomic,assign)CGFloat getround;
@property(nonatomic,copy)NSString *linklevel;
@property(nonatomic,assign)CGFloat linkuser;
@property(nonatomic,assign)CGFloat sourceidx;
@property(nonatomic,assign)int sourceper;
@property(nonatomic,assign)int sourcethread;
@property(nonatomic,assign)CGFloat sourceuser;
@property(nonatomic,assign)int state;//0 未发放 1已发放
@property(nonatomic,assign)int userid;

@property(nonatomic,copy)NSString *stateStr;
@end


@interface HomeListModel : NSObject
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *threadid;//进程ID
@property(nonatomic,assign)int dtopcode;//动态操作 0 全部复投   1 全部提现
@property(nonatomic,assign)int dtstate;//0 未到账 1已到账
@property(nonatomic,assign)CGFloat dttotal;//动态奖励
@property(nonatomic,assign)int jtopcode;//静态操作  0 全部复投   1 本金复投  2 利息复投  3 全部提现
@property(nonatomic,assign)CGFloat jttotal;//静态奖励
@property(nonatomic,copy)NSString *roundid;//轮次ID
@property(nonatomic,copy)NSString *senddt;
@property(nonatomic,assign)int state;//1 进行中  2 已结束  3 已清算
@property(nonatomic,assign)CGFloat totalcharge;//我的众筹
@property(nonatomic,copy)NSString *updatedt;

@property(nonatomic,copy)NSString *jtStr;
@property(nonatomic,copy)NSString *dtStr;
@property(nonatomic,copy)NSString *stateStr;


//
//@property(nonatomic,assign)int iscurrent;
@end


@interface SugModel : NSObject
@property(nonatomic,assign)int state;//状态 state  0-待处理  1  已经回复  2已关闭
@property(nonatomic,copy)NSString *createtime;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *reply;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *cid;
@property(nonatomic,copy)NSString *stateStr;
@property(nonatomic,copy)NSString *picurl;
@property(nonatomic,copy)NSString *username;
//质押
@property(nonatomic,copy)NSString *leftcount;//剩余名额
@property(nonatomic,copy)NSString *mlevel;//获得的等级
@property(nonatomic,assign)CGFloat zycount;//质押的金额

//质押记录
@property(nonatomic,copy)NSString *dtime;
@property(nonatomic,copy)NSString *zylevel;
@end



@interface YJModel : NSObject
@property(nonatomic,assign)CGFloat addamount;
@property(nonatomic,assign)CGFloat num;
@property(nonatomic,assign)int tradeid;
@property(nonatomic,assign)int userid;
@property(nonatomic,assign)int fromuser;
@property(nonatomic,assign)int fromthread;
@property(nonatomic,assign)int roundid;
@property(nonatomic,copy)NSString *fromusername;
@property(nonatomic,copy)NSString *dtime;
@end


@interface AdModel : NSObject
@property(nonatomic,copy)NSString *idx;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subject;
@property(nonatomic,copy)NSString *showtime;
@property(nonatomic,copy)NSString *updated;
@property(nonatomic,copy)NSString *linkurl;
@property(nonatomic,copy)NSString *linkurlen;
@property(nonatomic,assign)int state;
@property(nonatomic,copy)NSString *titleen;
@property(nonatomic,copy)NSString *subjecten;


@property(nonatomic,copy)NSString *sendtime;

@end

@interface BannerModel : NSObject
@property(nonatomic,copy)NSString *idx;
@property(nonatomic,copy)NSString *category;
@property(nonatomic,copy)NSString *pic_name;
@property(nonatomic,copy)NSString *pic_url;
@property(nonatomic,copy)NSString *linkurl;
@property(nonatomic,copy)NSString *updatedt;
//@property(nonatomic,assign)int state;
@end

@interface ZXModel : NSObject
@property(nonatomic,copy)NSString *idx;
@property(nonatomic,copy)NSString *content_en;
@property(nonatomic,copy)NSString *content_tw;
@property(nonatomic,copy)NSString *content_zhcn;
@property(nonatomic,copy)NSString *createtime;
@property(nonatomic,copy)NSString *linkurl_en;
@property(nonatomic,copy)NSString *linkurl_tw;
@property(nonatomic,copy)NSString *linkurl_zhcn;
@property(nonatomic,copy)NSString *picurl;
@property(nonatomic,copy)NSString *title_en;
@property(nonatomic,copy)NSString *title_tw;
@property(nonatomic,copy)NSString *title_zhcn;


@end


@interface CoinModel : NSObject
@property(nonatomic,assign)int coinid;
@property(nonatomic,assign)CGFloat price;
@property(nonatomic,assign)CGFloat pct;
@property(nonatomic,copy)NSString *coinName;

//
@property(nonatomic,copy)NSString *coinname;
@property(nonatomic,assign)CGFloat fee;
@property(nonatomic,copy)NSString *logourl;

@property(nonatomic,assign)CGFloat open;

@end


@interface HModel : NSObject
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,assign)CGFloat currentamount;
@property(nonatomic,copy)NSString *etime;
@property(nonatomic,copy)NSString *ftje;
@property(nonatomic,assign)int iscurrent;
@property(nonatomic,assign)CGFloat needamount;
@property(nonatomic,copy)NSString *roundid;
@property(nonatomic,assign)int state;
@property(nonatomic,copy)NSString *stime;
@property(nonatomic,assign)int threadid;
@property(nonatomic,copy)NSString *updatedt;
@property(nonatomic,copy)NSString *stateStr;

@end


@interface WalletReInModel : NSObject
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,assign)CGFloat inamount;
@property(nonatomic,copy)NSString *IDX;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *outaddr;
@property(nonatomic,copy)NSString *tradehash;
@property(nonatomic,assign)int state;
@property(nonatomic,copy)NSString *dtime;
@property(nonatomic,copy)NSString *updatedt;
@property(nonatomic,copy)NSString *stateStr;
@end

@interface WalletReOutModel : NSObject
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,assign)CGFloat amount_num;
@property(nonatomic,copy)NSString *IDX;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *target;
@property(nonatomic,assign)CGFloat fee_num;
@property(nonatomic,copy)NSString *tradehash;
@property(nonatomic,assign)int state;
@property(nonatomic,copy)NSString *requestime;
@property(nonatomic,copy)NSString *audittime;
@property(nonatomic,copy)NSString *updatedt;
@property(nonatomic,copy)NSString *stateStr;
@end


@interface GRZBModel : NSObject
@property(nonatomic,assign)CGFloat deposit_amount;
@property(nonatomic,assign)CGFloat gettoken;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *sendhash;
@property(nonatomic,assign)int state;
@property(nonatomic,copy)NSString *roundid;
@property(nonatomic,copy)NSString *dtime;
@end


@interface OETModel : NSObject
@property(nonatomic,assign)CGFloat tokenprice;
@property(nonatomic,assign)CGFloat tokencount;
@property(nonatomic,assign)CGFloat tokentotal;
//@property(nonatomic,assign)CGFloat tokencount;
@property(nonatomic,assign)int state;
@property(nonatomic,copy)NSString *roundid;
@property(nonatomic,copy)NSString *dtime;

@end

@interface TXModel : NSObject
@property(nonatomic,assign)CGFloat amount_num;
@property(nonatomic,assign)CGFloat fee_num;
@property(nonatomic,assign)int state;//没用
@property(nonatomic,assign)int confirmed;//0 未到账  1 已到账
@property(nonatomic,assign)int forwhat;//1 众筹奖励   2 节点奖励
@property(nonatomic,copy)NSString *roundid;
@property(nonatomic,copy)NSString *typeStr;

@end


@interface RGModel : NSObject
@property(nonatomic,assign)CGFloat amount;
@property(nonatomic,assign)CGFloat price;
@property(nonatomic,assign)CGFloat total;
@property(nonatomic,assign)int state;
@property(nonatomic,copy)NSString *stateStr;
@property(nonatomic,copy)NSString *dtime;
@end


@interface WTModel : NSObject
@property(nonatomic,assign)CGFloat count;//挂单数量
@property(nonatomic,assign)CGFloat dealcount;//成交数量
@property(nonatomic,assign)CGFloat price;//挂单价格
//@property(nonatomic,assign)CGFloat finishticosted;//成交金额
@property(nonatomic,assign)CGFloat dealavg;//成交均价
@property(nonatomic,assign)CGFloat costed;
@property(nonatomic,assign)CGFloat fee;
@property(nonatomic,assign)int status;//1 待成交   2 部分成交  3 已成交    0 已撤单
@property(nonatomic,copy)NSString *idx;
@property(nonatomic,copy)NSString *statuStr;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,copy)NSString *requesttime;
@property(nonatomic,copy)NSString *lx;//sell buy
@property(nonatomic,assign)BOOL iscancel;//---

@end

@interface BBHZModel : NSObject
@property(nonatomic,copy)NSString *category;
@property(nonatomic,assign)CGFloat amount;
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,copy)NSString *idx;
@property(nonatomic,copy)NSString *tradehash;
@property(nonatomic,assign)int state;
@property(nonatomic,copy)NSString *dtime;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *stateStr;
@end
