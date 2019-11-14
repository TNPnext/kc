//
//  SLZLVC.m
//  KC
//
//  Created by jian on 2019/10/30.
//  Copyright © 2019 jian. All rights reserved.
//

#import "SLZLVC.h"
#import "UIView+JC.h"
@interface SLZLVC ()
{
    BOOL checkXY;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UIView *SView;
@property (weak, nonatomic) IBOutlet UITextField *numberF;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *apriceL;
@property (weak, nonatomic) IBOutlet UILabel *totalL;
@property (weak, nonatomic) IBOutlet UIView *zlView;



@property (weak, nonatomic) IBOutlet UILabel *zjL;
@property (weak, nonatomic) IBOutlet UILabel *name2;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *totL;
@property (weak, nonatomic) IBOutlet UILabel *userdL;
@property (weak, nonatomic) IBOutlet UILabel *snumL;
@property (weak, nonatomic) IBOutlet UIButton *seBtn;
@property (weak, nonatomic) IBOutlet UILabel *rsyL;
@property (weak, nonatomic) IBOutlet UILabel *hbsjL;
@property (weak, nonatomic) IBOutlet UILabel *ywfL;
@property (weak, nonatomic) IBOutlet UILabel *glfL;



@property (weak, nonatomic) IBOutlet UILabel *price2L;
@property (weak, nonatomic) IBOutlet UILabel *pricea2L;
@property (weak, nonatomic) IBOutlet UIView *yuyueV;



@property (strong, nonatomic) prductModel *model;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;


@end

@implementation SLZLVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TInitArray;
    KAddNoti(@selector(textChange), UITextFieldTextDidEndEditingNotification);
    KAddNoti(@selector(moneyChage), KMMChange);
    KAddNoti(@selector(getinfoData), @"clickKC");
    self.customNavBar.title = TLOCAL(@"矿机购买");
    [SVProgressHUD showWithStatus:@"Loading..."];
    NSArray *contentA = @[@"云矿机业务是一项支持用户按T购买，并享受相应收益的业务。目前本平台在售云矿机仅支持分布式存储挖矿，周期目前为永续。平台后期会陆续上线其他挖矿方式和挖矿周期的云矿机。",@"您需要通过分享链接注册为平台用户，登录平台 a.minerx.org DAPP，或下载a.minerx.org APP，根据页面提示进行购买，整个流程如下：\n【使用USDT购买云矿机——次日产生收益——第3天发放收益】。",@"1）费用构成：运维费+管理费。\n2）运维费：矿场运维费0.025U/T（含电费）\n3）管理费：矿场管理费：0.025U/T\n4）平台分配比：平台将从矿机每天的挖矿收益中收取30%纳入平台收益，平台将提出绝大部分放入分红池，按规则分配给为平台和社区做出贡献的矿工；平台收益比结算方式（挖矿日收益－矿场运维费－矿场管理费）×30%。\n5）运维费、管理费和平台收益将从每天的挖矿收益中进行折算。",@"1）收益分配将使用PPS+理论收益进行计算，矿机所产生的收益每天将以USDT的形式发放至矿工账户。\n2）矿工收益由数字资产网络实际数据存储计算得出，将动态变化，预估值仅供参考，当天矿机的收益扣除运维费、管理费及平台分配部分后，即为矿工每天挖矿的净收益。",@"1）挖矿的数字资产价格可能发生大幅波动，另外挖矿难度也可能有变化，这会导致矿机挖矿收益的提高或下降。\n\n2）不可抗力及意外事件风险：自然灾害、数字货币市场危机、战争、设备故障、通讯故障、电力故障、或者国家政策变化等不能预见、不能避免、不能克服的不可抗力事件，都可能导致本服务终止，影响投资收益降低乃至本金损失，对于不可抗力及意外风险导致的不良后果平台不承担任何责任。\n\n3）运维成本、电力成本、管理费用可能由于国家政策、矿场实际情况及电力成本的变化而波动，平台将保留适当调整运维费、管理费等费用的权利。\n\n4）用户需要仔细评估自己的投资能力和风险承受能力，在可接受的风控范围内投资数字资产挖矿。"];
    NSArray *titA = @[@"业务说明",@"购买流程",@"费用说明",@"收益结算",@"风险提示"];
    NSArray *imgA = @[@"kg_item0",@"kg_item1",@"kg_item2",@"kg_item3",@"kg_item4"];
    for (int i = 0; i<imgA.count; i++) {
        NSMutableDictionary *dd = [NSMutableDictionary dictionary];
        [dd setValue:titA[i] forKey:@"tit"];
        [dd setValue:contentA[i] forKey:@"content"];
        [dd setValue:imgA[i] forKey:@"img"];
        [_dataArray addObject:dd];
    }
    
    [self getinfoData];
    [self moneyChage];
    
//p1    预计挖矿日收益率
//p2 n   平台分配比
//p3    运维费
//p4    管理费
//p5  n  预计矿工日收益率
//p6    预计挖矿回本时间

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _dataArray[indexPath.row];
    NSString *content = [dic valueForKey:@"content"];
    if(indexPath.row==0)
    {
        return getRectWithStr(content, 11, 0, SCREEN_WIDTH-20).size.height+70;
    }
    return getRectWithStr(content, 11, 0, SCREEN_WIDTH-20).size.height+52;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cell2";
    if (indexPath.row==0) {
        cellID = @"cell1";
    }
    NSDictionary *dic = _dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    UIView *vv = cell.contentView;
    UILabel *l1 = [vv viewWithTag:10];
    UILabel *l2 = [vv viewWithTag:11];
    UIImageView *img = [vv viewWithTag:12];
    NSString *content = [dic valueForKey:@"content"];
    NSString *tit = [dic valueForKey:@"tit"];
    NSString *imgn = [dic valueForKey:@"img"];
    img.image = TimageName(imgn);
    l1.text = tit;
    l2.text = content;
    return cell;
}



-(void)moneyChage
{
    _userdL.text = [NSString stringWithFormat:@"%@USDT",[JCTool removeZero:[JCTool getCanPay]]];
}

- (IBAction)xieyiClick:(UIButton *)sender {
    //xuanzhong_yes
    switch (sender.tag) {
        case 10:
        {
            sender.selected = !sender.selected;
            checkXY = sender.selected;
            if (sender.selected) {
                [_seBtn setImage:TimageName(@"xuanzhong_yes") forState:(UIControlStateNormal)];
            }else
            {
                [_seBtn setImage:TimageName(@"xuanzhong_no") forState:(UIControlStateNormal)];
            }
        }
        break;
        case 11:
        {
           WebViewController *web = [WebViewController new];
            NSDictionary *dic = [JCTool share].xyDic;
           NSString *url = [dic valueForKey:[NSString stringWithFormat:@"linkurl_%@",[JCTool getCurrLan]]];
            if (kStringIsEmpty(url)) {
                url = @"";
            }
            web.reqUrl = url;
            web.t_tilte = TLOCAL(@"购买协议");
            [self.navigationController pushViewController:web animated:1];
        }
        break;
        default:
            break;
    }
    
    
}



-(void)textChange
{
    int number = [_numberF.text intValue];
    if (number<_model.mincount_peruser) {
        number = _model.mincount_peruser;
    }
    if (number>_model.maxcount_peruser) {
        number = _model.maxcount_peruser;
    }
    _numberF.text = [NSString stringWithFormat:@"%d",number];
    [self reloadUI];
}


- (IBAction)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
        {
            _SView.hidden = 0;
        }
        break;
        case 11:
        {
            //--
            int number = [_numberF.text intValue];
            number--;
            if (number<_model.mincount_peruser) {
                number = _model.mincount_peruser;
            }
            _numberF.text = [NSString stringWithFormat:@"%d",number];
            [self reloadUI];
        }
        break;
        case 12:
        {
            //++
            int number = [_numberF.text intValue];
            number++;
            if (number>_model.maxcount_peruser) {
                number = _model.maxcount_peruser;
            }
            _numberF.text = [NSString stringWithFormat:@"%d",number];
            [self reloadUI];
        }
        break;
        case 13:
       {
           if (!checkXY) {
               TShowMessage(@"请先勾选同意协议");
               return;
           }
           //确定
           CGFloat userd = [JCTool getCanPay];
           if (userd<[_zjL.text doubleValue]) {
               TShowMessage(@"可用余额不足");
               return;
           }
           if ([JCTool share].user.transcodeseted==0) {
               [JCTool settingPass];
               return;
           }
           kWeakSelf;
           [JCTool inputPassWord:^(NSString *password) {
               [weakSelf pay:password];
           }];
           
       }
        break;
        case 14:
       {
           //取消
           _SView.hidden = 1;
       }
        break;
        default:
        break;
    }
    
    
}

-(void)pay:(NSString *)password
{
    TParms;
    kWeakSelf;
    NSString *ss = [NSString stringWithFormat:@"%@:%@",[JCTool share].user.mycode,password];
    [parms setValue:[ss sha256String] forKey:@"paypassword"];
    [parms setValue:_numberF.text forKey:@"amount"];
    [parms setValue:_model.productid forKey:@"productid"];
    [NetTool getDataWithInterface:@"rzq.trade.pay" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                weakSelf.SView.hidden = 1;
                TShowMessage(@"提交成功!");
                [JCTool querybalance];
                [weakSelf getinfoData];
            }
                break;
                
            default:
                TShowResMsg;
                break;
        }
    } failure:^(NSError *error) {
        TShowNetError;
    }];
}



-(void)getinfoData
{
    TParms;
    kWeakSelf;
    [NetTool getDataWithInterface:@"rzq.leftmachine.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dict = [responseObject valueForKey:@"data"];
                if (dict.count>0) {
                    prductModel *mom = [prductModel mj_objectWithKeyValues:dict];
                    weakSelf.model = mom;
                    weakSelf.numberF.text = [NSString stringWithFormat:@"%d",mom.mincount_peruser];
                    weakSelf.yuyueV.hidden = !(mom.state==2);
                    weakSelf.zlView.hidden = (mom.state==2);
                    if (mom.state==2) {
                        [weakSelf.buyBtn setTitle:TLOCAL(@"立即预约") forState:(UIControlStateNormal)];
                    }
                    [weakSelf reloadUI];
                }else
                {
                    TShowMessage(@"暂无数据");
                }
                
            }
                break;
            default:
                TShowResMsg;
                break;
        }
    } failure:^(NSError *error) {
        TShowNetError;
    }];
}

-(void)reloadUI
{
    
    _priceL.text = [NSString stringWithFormat:@"%@U/T",[JCTool removeZero:_model.price]];
    _apriceL.attributedText = [NSString addRemoveLineOnString:[NSString stringWithFormat:@"%@:%@U/T",TLOCAL(@"优惠价"),[JCTool removeZero:_model.aprice]]];
    _totalL.text = [NSString stringWithFormat:@"%@T",[JCTool removeZero:_model.totalcount]];
    NSString *ss = [JCTool removeZero:_model.price*[_numberF.text intValue]];
    _zjL.text = [NSString stringWithFormat:@"%@U",ss];
    
    _totL.text = [NSString stringWithFormat:@"%@U",_zjL.text];
    _name2.text = _nameL.text;
    _price2.text = _priceL.text;
    _numL.text = [NSString stringWithFormat:@"%@T",_numberF.text];
    _snumL.text = _numL.text;
    _price2L.text = _priceL.text;
    _pricea2L.attributedText = [NSString addRemoveLineOnString:[NSString stringWithFormat:@"%@:%@U/T",TLOCAL(@"优惠价"),[JCTool removeZero:_model.aprice]]];
    NSDictionary *land = KOutObj(Klanguage);
    switch ([[land valueForKey:@"idx"] intValue]) {
        case 0:
        {
            _nameL.text = _model.productname;
            _rsyL.text = _model.p1;
            _hbsjL.text = _model.p6;
            _ywfL.text = _model.p3;
            _glfL.text = _model.p4;
        }
            break;
        case 1:
        {
            _nameL.text = _model.name_tw;
            _rsyL.text = _model.p1_tw;
            _hbsjL.text = _model.p6_tw;
            _ywfL.text = _model.p3_tw;
            _glfL.text = _model.p4_tw;
        }
            break;
        case 2:
        {
            _nameL.text = _model.name_en;
            _rsyL.text = _model.p1_en;
            _hbsjL.text = _model.p6_en;
            _ywfL.text = _model.p3_en;
            _glfL.text = _model.p4_en;
        }
            break;
        default:
            break;
    }
    
    
    [SVProgressHUD dismiss];
}





@end


/*
 {
 aprice = 150;
 buiedcount = 110;
 datestr = "2019-11-10";
 detailurl = "https://minerx.org";
 "detailurl_en" = "<null>";
 "detailurl_tw" = "<null>";
 etime = "2020-01-01T18:10:17";
 iscurrent = 1;
 "maxcount_peruser" = 10000000;
 "mincount_peruser" = 1;
 "name_en" = "MineX miner";
 "name_tw" = "MinerX\U4e91\U7926\U6a5f";
 p1 = "0.21%";
 "p1_en" = aaaaa;
 "p1_tw" = aaaa;
 p2 = 30;
 "p2_en" = bbbbb;
 "p2_tw" = bbbb;
 p3 = "0.25";
 "p3_en" = cccc;
 "p3_tw" = cccc;
 p4 = "0.25";
 "p4_en" = dddd;
 "p4_tw" = dddd;
 p5 = "0.0021%";
 "p5_en" = eeee;
 "p5_tw" = eeee;
 p6 = 467;
 "p6_en" = "<null>";
 "p6_tw" = ffff;
 price = 100;
 "price_description" = "\U6e2c\U8a66\U4fe1\U606f";
 "price_description_en" = "Test Info";
 "price_description_tw" = "\U6e2c\U8a66\U4fe1\U606f";
 productid = 1;
 productname = "MinerX\U4e91\U77ff\U673a";
 proinfo = 111111111;
 "proinfo_en" = 111111111;
 "proinfo_tw" = 111111;
 roundid = 1;
 state = 1;
 stime = "2019-11-05T18:10:13";
 totalcount = 3000;
 */
