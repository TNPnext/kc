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
@property(nonatomic,copy)NSString *coinname;
@property(nonatomic,assign)CGFloat open;
@end

//矿机
@interface prductModel : NSObject
@property(nonatomic,assign)int iscurrent;

@property(nonatomic,assign)int roundid;
@property(nonatomic,assign)int state;
@property(nonatomic,assign)int maxcount_peruser;
@property(nonatomic,assign)int mincount_peruser;

@property(nonatomic,assign)CGFloat totalcount;
@property(nonatomic,assign)CGFloat buiedcount;
@property(nonatomic,assign)CGFloat price;
@property(nonatomic,assign)CGFloat aprice;
@property(nonatomic,copy)NSString *productname;
@property(nonatomic,copy)NSString *price_description;
@property(nonatomic,copy)NSString *proinfo;
@property(nonatomic,copy)NSString *datestr;
@property(nonatomic,copy)NSString *stime;
@property(nonatomic,copy)NSString *etime;
@property(nonatomic,copy)NSString *detailurl;
@property(nonatomic,copy)NSString *productid;


@end


//收益
@interface SYModel : NSObject
@property(nonatomic,assign)int state;
@property(nonatomic,assign)CGFloat dayamount;
@property(nonatomic,assign)CGFloat rewardamount;
@property(nonatomic,copy)NSString *orderid;
@property(nonatomic,copy)NSString *roundid;
@property(nonatomic,copy)NSString *linklevel;
@property(nonatomic,copy)NSString *exinfo;
@property(nonatomic,copy)NSString *dtime;
@property(nonatomic,copy)NSString *stateStr;

@end


//我的矿机
@interface MyPrudctModel : NSObject
@property(nonatomic,assign)int state;
@property(nonatomic,assign)int buycount;
@property(nonatomic,assign)int opcode;//0 预约中 1 取消续租
@property(nonatomic,assign)CGFloat buyprice;
@property(nonatomic,assign)CGFloat buytotal;
@property(nonatomic,assign)CGFloat rewardtotal;
@property(nonatomic,copy)NSString *day;
@property(nonatomic,copy)NSString *etime;
@property(nonatomic,copy)NSString *fromqueueid;

@property(nonatomic,copy)NSString *productname;
@property(nonatomic,copy)NSString *orderid;
@property(nonatomic,copy)NSString *productid;
@property(nonatomic,copy)NSString *roundid;
@property(nonatomic,copy)NSString *stime;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *stateStr;
@end

//预约记录
@interface MyYYReModel : NSObject
@property(nonatomic,assign)int state;
@property(nonatomic,assign)int buycount;
@property(nonatomic,assign)CGFloat buyprice;
@property(nonatomic,assign)int buiedcount;
@property(nonatomic,assign)int queuecount;
@property(nonatomic,assign)CGFloat payedtotal;
@property(nonatomic,copy)NSString *etime;

@property(nonatomic,copy)NSString *productname;
@property(nonatomic,copy)NSString *orderid;
@property(nonatomic,copy)NSString *productid;
@property(nonatomic,copy)NSString *roundid;
@property(nonatomic,copy)NSString *stime;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *stateStr;
@end



//钱包记录
@interface WalletListModel : NSObject
@property(nonatomic,assign)int tradetype;
@property(nonatomic,assign)int state;

@property(nonatomic,assign)CGFloat outamount;
@property(nonatomic,assign)CGFloat inamount;
@property(nonatomic,assign)CGFloat fee;

@property(nonatomic,copy)NSString *tradeid;
@property(nonatomic,copy)NSString *tradehash;
@property(nonatomic,copy)NSString *toaddr;
@property(nonatomic,copy)NSString *fromaddr;
@property(nonatomic,copy)NSString *dtime;
//@property(nonatomic,copy)NSString *description;
@property(nonatomic,copy)NSString *confirmdt;
@property(nonatomic,copy)NSString *coinid;
@property(nonatomic,copy)NSString *stateStr;
@property(nonatomic,copy)NSString *typeStr;
@end
