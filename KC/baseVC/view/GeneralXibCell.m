//
//  GeneralXibCell.m
//  RZQRose
//
//  Created by jian on 2019/5/22.
//  Copyright © 2019 jian. All rights reserved.
//

#import "GeneralXibCell.h"

@implementation GeneralXibCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end

//未启用
@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    CGFloat rw = SCREEN_WIDTH-80-30;
    UILabel *labelbg = [[UILabel alloc]initWithFrame:CGRectMake(rw-60, 8, 90, 15)];
    labelbg.backgroundColor = [UIColor clearColor];
    labelbg.transform = CGAffineTransformMakeRotation(45 * M_PI / 180.0f);
    [_leftV addSubview:labelbg];
   // [JCTool gradient:labelbg];
    
    _currL = [[UILabel alloc]initWithFrame:CGRectMake(rw-60, 8, 90, 15)];
    _currL.text = @"选择期";
    _currL.font = fontSize(10);
    _currL.backgroundColor = [UIColor clearColor];
    _currL.textColor = [UIColor blackColor];
    _currL.textAlignment = NSTextAlignmentCenter;
    _currL.transform = CGAffineTransformMakeRotation(45 * M_PI / 180.0f);
    [_contentV addSubview:_currL];
    
    UIView *rightBg = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 0, 80, 80)];
    rightBg.backgroundColor = ColorWithHex(@"22305b");
    [_contentV addSubview:rightBg];
    
    
    [_contentV bringSubviewToFront:_czV];
    [_contentV bringSubviewToFront:_comV];
    //[JCTool gradient:_btnBg];
}

-(void)setModel:(HomeListModel *)model
{
    _model = model;
    _lunciL.text = [NSString stringWithFormat:@"%@%@%@",TLOCAL(@"第"),model.roundid,TLOCAL(@"期")];
    int num1 = [model.roundid intValue]/100;
    int num2 = [model.roundid intValue]%100;
    if (num1>0) {
        _lunciL.text = [NSString stringWithFormat:@"RE%02d-%02d%@",num1,num2,TLOCAL(@"期")];
    }
    
    _cnL.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"我的众筹"),[JCTool removeZero:model.totalcharge]];
    _jtL.text = [JCTool removeZero:model.jttotal];
    _dtL.text = [JCTool removeZero:model.dttotal];
    
    GameModel *currm = [[JCTool share].gameCurrDic valueForKey:[JCTool share].currthreadId];
    
    _currL.hidden = 0;
    _comV.hidden = 1;
    int num = [currm.ID intValue] - [_model.roundid intValue];
    _cellBtn.userInteractionEnabled = 1;
    switch (num) {
        case 0:
        {
            //不显示任何期
            _currL.hidden = 1;
            _btnBg.backgroundColor = [UIColor clearColor];
            [_cellBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:(UIControlStateNormal)];
            [_cellBtn setTitle:TLOCAL(@"操作") forState:(UIControlStateNormal)];
            _cellBtn.userInteractionEnabled = 0;
        }
            break;
        case 1:
        {
           //收益期
            _currL.text = TLOCAL(@"收益期");
            [_cellBtn setTitle:TLOCAL(@"操作") forState:(UIControlStateNormal)];
            _currL.backgroundColor = [JCTool themColor];
            _btnBg.backgroundColor = [JCTool themColor];
            [_cellBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }
            break;
        case 2:
        case 3:
        {
            //选择期
            NSString *ss = TLOCAL(@"复投期");
            if (num==3) {
                ss = TLOCAL(@"提现期");
            }
            _currL.text = ss;//2 复投期 3 提现期
            
            _currL.backgroundColor = ColorWithHex(@"09DEAA");
            _comV.hidden = 0;
            _comdtL.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"动"),_model.dtStr];
            _comjtL.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"静"),_model.jtStr];
            
        }
            break;
        default:
        {
            //已完成
            _currL.text = TLOCAL(@"已完成");
            _currL.backgroundColor = ColorWithHex(@"4E4E4E");
            _comV.hidden = 0;
            _comdtL.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"动"),_model.dtStr];
            _comjtL.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"静"),_model.jtStr];
            
        }
            break;
    }
    GameModel *currgm = [[JCTool share].gameDic valueForKey:[NSString stringWithFormat:@"%@,%@",model.threadid,model.roundid]];
    
    if (currgm.status==3||currgm.status==4)
    {
        _currL.hidden = 1;
        _comV.hidden = 1;
        _btnBg.backgroundColor = [UIColor clearColor];
        _cellBtn.userInteractionEnabled = 0;
        [_cellBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        if (currgm.status == 3)
        {
            [_cellBtn setTitle:TLOCAL(@"重启期") forState:(UIControlStateNormal)];
        }else
        {
            [_cellBtn setTitle:TLOCAL(@"止损期") forState:(UIControlStateNormal)];
        }
    }
    
}


@end






@implementation DListCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    CGFloat roat = 45;
    _labelbg = [[UILabel alloc]initWithFrame:CGRectMake(-roat, 5, 110, 15)];
    _labelbg.backgroundColor = [UIColor clearColor];
    _labelbg.transform = CGAffineTransformMakeRotation(-roat * M_PI / 180.0f);
    [self.contentV addSubview:_labelbg];
    [JCTool gradient:_labelbg];
    
    _currL = [[UILabel alloc]initWithFrame:CGRectMake(-roat, 5, 110, 15)];
    _currL.text = TLOCAL(@"复投");
    _currL.font = fontSize(10);
    _currL.backgroundColor = [UIColor clearColor];
    _currL.textColor = [UIColor blackColor];
    _currL.textAlignment = NSTextAlignmentCenter;
    _currL.transform = CGAffineTransformMakeRotation(-roat * M_PI / 180.0f);
    [self.contentV addSubview:_currL];
    
    UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, _contentV.height)];
    mask.backgroundColor = [JCTool themVCBGColor];
    [self.contentView addSubview:mask];
}

-(void)setModel:(GameDModel *)model
{
    _model = model;
    _label1.text = [NSString stringWithFormat:@"%@%@%@",TLOCAL(@"第"),model.PerNum,TLOCAL(@"期")];
    NSString *dt = [model.confirmdt stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringWithRange:NSMakeRange(5, 11)];
    _label3.text = dt;
    _label2.text = [NSString stringWithFormat:@"%@USDT",[JCTool removeZero:model.amount]];
    _currL.hidden = !model.recharge;
    _labelbg.hidden = !model.recharge;
    
}

@end

@implementation SugCell

-(void)setModel:(SugModel *)model
{
    _model = model;
    _label1.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"提交标题"),model.title];
    _label2.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"客服回复"),model.reply?model.reply:@""];
    NSString *dt = [model.createtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringWithRange:NSMakeRange(5, 11)];
    _label3.text = dt;
    _label4.text = model.stateStr;
}

@end

@implementation YJCell

-(void)setArray:(NSArray *)array
{
    _array = array;
    NSArray *arr = [YJModel mj_objectArrayWithKeyValuesArray:array];
    CGFloat num = 0;
    for (YJModel *mm in arr)
    {
        num +=mm.num;
    }
    _label2.text = [JCTool removeZero:num];
    
}

-(void)setLunci:(NSString *)lunci
{
    NSString *ll = [[lunci componentsSeparatedByString:@","] lastObject];
    _label1.text = ll;
}

@end

@implementation YJDCell

-(void)setModel:(YJModel *)model
{
    _model = model;
    _label1.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"入单用户"),_model.fromusername];
    
    NSString *dt = [model.dtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringWithRange:NSMakeRange(5, 11)];
    _label2.text = [JCTool removeZero:_model.addamount];
    _label3.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"入单时间"),dt];
}

@end


@implementation MainHqCell

-(void)setModel:(CoinModel *)model
{
    _model = model;
    _label1.text = model.coinName;
    _label2.text = [JCTool removeZero:_model.price];
    
    _label2.textColor = RGBA(63, 161, 27, 1);
    _label3.backgroundColor = RGBA(63, 161, 27, 1);
    if (model.pct<0) {
        _label3.text = [NSString stringWithFormat:@"%@%%",[JCTool removeZero:_model.pct]];
        _label2.textColor = RGBA(197, 52, 83, 1);
        _label3.backgroundColor = RGBA(197, 52, 83, 1);
    }else
    {
       _label3.text = [NSString stringWithFormat:@"+%@%%",[JCTool removeZero:_model.pct]];
    }
}

@end


@implementation WalletCell

-(void)setModel:(MoneyModel *)model
{
    _model = model;
    NSString *coinNames = model.coinName;
    if ([coinNames containsString:@"-"]) {
        coinNames = [[coinNames componentsSeparatedByString:@"-"] firstObject];
    }
    _coinName.text = coinNames;
    _label1.text = [JCTool removeZero:model.balance-model.lockcount];
    _label2.text = [JCTool removeZero:model.lockcount];
    [_logo sd_setImageWithURL:[NSURL URLWithString:model.logourl] placeholderImage:TimageName(@"W_BTC")];
    _label1.adjustsFontSizeToFitWidth = 1;
    _label2.adjustsFontSizeToFitWidth = 1;
    
}

@end

@implementation WalletOutCell

-(void)setModel:(WalletReOutModel *)model
{
    _model = model;
    CoinModel *mm = [[JCTool share].coinDic valueForKey:model.coinid];
    
    _coinNameL.text = mm.coinname;
    _numberL.text = [JCTool removeZero:model.amount_num];
    _stateL.text = model.stateStr;
    
    NSString *hash = model.tradehash?model.tradehash:@"";
    NSString *s = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"交易HASH"),hash];
    _hashL.attributedText = [NSString stringCustomText:s rangString:hash rangFont:12 rangColor:[UIColor whiteColor]];
    _hashL.hidden = !model.tradehash.length;
    
    NSString *s1 = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"目标地址"),model.target];
    _addressL.attributedText = [NSString stringCustomText:s1 rangString:model.target rangFont:12 rangColor:[UIColor whiteColor]];
    
    
    _feeL.text = [JCTool removeZero:mm.fee];
    NSString *dt = [model.requestime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringToIndex:dt.length-3];
    _timeL.text = dt;
    
}

@end

@implementation WalletInCell

-(void)setModel:(WalletReInModel *)model
{
    _model = model;
    CoinModel *mm = [[JCTool share].coinDic valueForKey:model.coinid];
    
    _coinNameL.text = mm.coinname;
    _numberL.text = [JCTool removeZero:model.inamount];
    _stateL.text = model.stateStr;
    NSString *hash = model.tradehash?model.tradehash:@"";
    NSString *s = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"交易HASH"),hash];
    _hashL.attributedText = [NSString stringCustomText:s rangString:hash rangFont:12 rangColor:[UIColor whiteColor]];
    _hashL.hidden = !model.tradehash.length;
    NSString *s1 = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"目标地址"),model.outaddr];
    _addressL.attributedText = [NSString stringCustomText:s1 rangString:model.outaddr rangFont:12 rangColor:[UIColor whiteColor]];
    
    NSString *dt = [model.dtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringToIndex:dt.length-3];
    _timeL.text = dt;
}

@end

@implementation MShareCell

-(void)setModel:(UserModel *)model
{
    _model = model;
    _label1.text = [NSString stringWithFormat:@"%@",model.uid];
    _label2.text = [NSString stringWithFormat:@"M%d",model.userlevel];
    _label3.text = [JCTool removeZero:model.totaladded];
    _label4.text = [JCTool removeZero:model.selfadded];
}

@end

@implementation JoinReCell

-(void)setModel:(HomeListModel *)model
{
    _model = model;
    
    _lunciL.text = [NSString stringWithFormat:@"%@%@%@",TLOCAL(@"第"),model.roundid,TLOCAL(@"期")];
    int num11 = [model.roundid intValue]/100;
    int num12 = [model.roundid intValue]%100;
    if (num11>0) {
        _lunciL.text = [NSString stringWithFormat:@"RE%02d-%02d%@",num11,num12,TLOCAL(@"期")];
    }
    NSString *num1 = [JCTool removeZero:model.totalcharge];
    NSString *s1 = [NSString stringWithFormat:@"%@:%@USDT",TLOCAL(@"我的众筹"),num1];
    _cnL.attributedText = [NSString stringCustomText:s1 rangString:num1 rangFont:15 rangColor:[UIColor whiteColor]];
    
    
    _jtL.text = [JCTool removeZero:model.jttotal];
    _dtL.text = [JCTool removeZero:model.dttotal];
    _jtTipL.text = [NSString stringWithFormat:@"*%@:%@%@%d%@%@,%@%@%d%@%@",TLOCAL(@"众筹收益"),TLOCAL(@"提现"),TLOCAL(@"第"),num12+3,TLOCAL(@"期"),TLOCAL(@"众筹完成到账"),TLOCAL(@"复投"),TLOCAL(@"第"),num12+2,TLOCAL(@"期"),TLOCAL(@"开始生效")];
    _dtTipL.text = [NSString stringWithFormat:@"*%@:%@%d%@%@",TLOCAL(@"社区奖励"),TLOCAL(@"第"),num12+3,TLOCAL(@"期"),TLOCAL(@"众筹完成到账")];
    
    _threeL.text = TLOCAL(@"*温馨提示：若不操作取消复投操作，系统默认本利全部复投");
    
    int num = [[JCTool share].currGameM.roundid intValue]-[model.roundid intValue];
    if (num<2) {
        _cellBtn.hidden = 0;
    }else
    {
       _cellBtn.hidden = 1;
    }
    NSString *ss = TLOCAL(@"未到账");
    if (model.dtstate==1) {
        ss = TLOCAL(@"已到账");
    }
    
    
    _dtstateL.text = [NSString stringWithFormat:@"%@（%@）",TLOCAL(@"社区奖励"),ss];
    _jtstateL.text = [NSString stringWithFormat:@"%@（%@）",TLOCAL(@"众筹收益"),_model.jtStr];
    _dtstateL.adjustsFontSizeToFitWidth = 1;
    _jtstateL.adjustsFontSizeToFitWidth = 1;
    
    if (![KOutObj(@"isf") boolValue]) {
        if (self.indexp.row==0) {
            KSaveObj(@"1", @"isf");
            [self tipBtnClick:self.tipBtn];
        }
    }
    
}

- (IBAction)tipBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _tipV.hidden = !sender.selected;
    UIImage *img = TimageName(@"wenhao_no");
    if (sender.selected) {
        img = TimageName(@"wenhao_yes");
        
    }
    
    [sender setImage:img forState:(UIControlStateNormal)];
    
}




@end


@implementation JLCell

-(void)setModel:(RewardModel *)model
{
    _model = model;
    NSString *ss = TLOCAL(@"分享奖励");
    NSString *jlsd = TLOCAL(@"奖励深度:");
    NSString  *leve = model.linklevel;
    if (model.forwhat==2) {
        ss = TLOCAL(@"节点奖励");
        jlsd = TLOCAL(@"奖励比例:");
        leve = [NSString stringWithFormat:@"%@%%",[JCTool removeZero:[model.linklevel floatValue]/2.0]];
    }
    _label1.text = TLOCAL(ss);
    _label2.text = [JCTool removeZero:model.amount];
    
    NSString *auT = [model.dtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _label6.text = [auT substringWithRange:NSMakeRange(5, 11)];
    _label5.text = leve;
    _label3.text = [NSString stringWithFormat:@"%d",(int)model.getround];
    _label4.text = model.stateStr;
    _label4.textColor = ColorWithHex(@"#E110EE");
    if (model.state==1)
    {
        _label4.textColor = ColorWithHex(@"#0CA313");
    }
    _sdlabel.text = jlsd;
    
    
    
}


@end


@implementation ZBCell1

-(void)setModel:(HomeListModel *)model
{
    _model = model;
    NSString *dt = [model.senddt stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _timeL.text = dt;
    _qiL.text = [NSString stringWithFormat:@"%@%@%@",TLOCAL(@"第"),model.roundid,TLOCAL(@"期")];
    int num11 = [model.roundid intValue]/100;
    int num12 = [model.roundid intValue]%100;
    if (num11>0) {
        _qiL.text = [NSString stringWithFormat:@"RE%02d-%02d%@",num11,num12,TLOCAL(@"期")];
    }
    
    _stateL.text = model.stateStr;
    _amountL.text = [JCTool removeZero:model.totalcharge];
    _jtnumL.text = [JCTool removeZero:model.jttotal];
    _dtnumL.text = [JCTool removeZero:model.dttotal];
    
    _amountL.adjustsFontSizeToFitWidth = 1;
    _jtnumL.adjustsFontSizeToFitWidth = 1;
    _dtnumL.adjustsFontSizeToFitWidth = 1;
    
}

@end

@implementation ZBCell2

-(void)setModel:(GRZBModel *)model
{
    _model = model;
    NSString *dt = [model.dtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringWithRange:NSMakeRange(5, 11)];
    _timeL.text = dt;
    _qiL.text = [NSString stringWithFormat:@"%@%@%@",TLOCAL(@"第"),model.roundid,TLOCAL(@"期")];
    int num11 = [model.roundid intValue]/100;
    int num12 = [model.roundid intValue]%100;
    if (num11>0) {
        _qiL.text = [NSString stringWithFormat:@"RE%02d-%02d%@",num11,num12,TLOCAL(@"期")];
    }
    _numberL1.text = [JCTool removeZero:model.deposit_amount];
    _numberL2.text = [JCTool removeZero:model.gettoken];
    _numberL1.adjustsFontSizeToFitWidth = 1;
    _numberL2.adjustsFontSizeToFitWidth = 1;
    
}

-(void)setOmodel:(OETModel *)omodel
{
    _omodel = omodel;
    NSString *dt = [omodel.dtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _timeL.text = dt;
    _qiL.text = [NSString stringWithFormat:@"%@%@%@",TLOCAL(@"第"),omodel.roundid,TLOCAL(@"期")];
    int num11 = [omodel.roundid intValue]/100;
    int num12 = [omodel.roundid intValue]%100;
    if (num11>0) {
        _qiL.text = [NSString stringWithFormat:@"RE%02d-%02d%@",num11,num12,TLOCAL(@"期")];
    }
    _numberL1.text = [JCTool removeZero:omodel.tokentotal];
    _numberL2.text = [JCTool removeZero:omodel.tokenprice];
    _numberL0.text = [JCTool removeZero:omodel.tokencount];
    _numberL0.adjustsFontSizeToFitWidth = 1;
    _numberL1.adjustsFontSizeToFitWidth = 1;
    _numberL2.adjustsFontSizeToFitWidth = 1;
}

@end


@implementation MyZCCell

-(void)setModel:(GameDModel *)model
{
    _model = model;
    _label1.text = [NSString stringWithFormat:@"%@%@%@",TLOCAL(@"第"),model.roundid,TLOCAL(@"期")];
    int num11 = [model.roundid intValue]/100;
    int num12 = [model.roundid intValue]%100;
    if (num11>0) {
        _label1.text = [NSString stringWithFormat:@"RE%02d-%02d%@",num11,num12,TLOCAL(@"期")];
    }
    NSString *dt = [model.confirmdt stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringWithRange:NSMakeRange(5, 11)];
    _label3.text = dt;
    
    _label2.text = [NSString stringWithFormat:@"%@",[JCTool removeZero:model.amount]];
    _futouL.hidden = 1;
    if (model.recharge==1) {
        _futouL.hidden = 0;
        NSString *ss = TLOCAL(@"复投");
        CGRect rect = getRectWithStr(ss, 10, 0, 100);
        [_futouL cornerRadius:2];
        [_futouL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(rect.size.width+10, 15));
        }];
        _futouL.text = ss;
    }
    
    
}

@end

@implementation OETCell



@end


@implementation YYCell
-(void)awakeFromNib
{
    [super awakeFromNib];
    _numL1.adjustsFontSizeToFitWidth = 1;
    _numL2.adjustsFontSizeToFitWidth = 1;
    _numL3.adjustsFontSizeToFitWidth = 1;
}

-(void)setModel:(JoinModel *)model
{
    _model = model;
    NSString *dt = [model.dtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    //dt = [dt substringWithRange:NSMakeRange(5, 11)];
    _timeL.text = dt;
    _hashL.text = model.tradehash?model.tradehash:@"";
    
    _hashV.hidden = !_hashL.text.length;
    _stateL.text = model.stateStr;
    _numL1.text = [JCTool removeZero:model.inamount];
    _numL2.text = [JCTool removeZero:model.queueamount];
    _numL3.text = [JCTool removeZero:model.confirmamount];
    
    _ll1.adjustsFontSizeToFitWidth = 1;
    _ll2.adjustsFontSizeToFitWidth = 1;
    _ll3.adjustsFontSizeToFitWidth = 1;
}


-(void)setRgModel:(RGModel *)rgModel
{
    _rgModel = rgModel;
    _stateL.text = rgModel.stateStr;
    _numL1.text = [JCTool removeZero:rgModel.total];
    _numL2.text = [JCTool removeZero:rgModel.price];
    _numL3.text = [JCTool removeZero:rgModel.amount];
    NSString *dt = [rgModel.dtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _timeL.text = dt;
    
}

-(IBAction)btnClick:(UIButton *)sender
{
    [UIPasteboard generalPasteboard].string = _model.tradehash;
    TAlertShow(@"复制成功!");
}

-(void)setYmodel:(SugModel *)ymodel
{
    _ymodel = ymodel;
    _numL1.text = [JCTool removeZero:ymodel.zycount];
    _numL2.text = [NSString stringWithFormat:@"M%@",ymodel.mlevel];
    _numL3.text = ymodel.leftcount;
}

-(void)setZmodel:(SugModel *)zmodel
{
    _zmodel = zmodel;
    NSString *dt = [zmodel.dtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringWithRange:NSMakeRange(5, 11)];
    _numL1.text = [NSString stringWithFormat:@"M%@",zmodel.zylevel];
    _numL2.text = [JCTool removeZero:zmodel.zycount];
    _stateL.text = (zmodel.state==1)?TLOCAL(@"已生效"):TLOCAL(@"未生效");
    _timeL.text = dt;
    
}

-(void)setHzModel:(BBHZModel *)hzModel
{
    _hzModel = hzModel;
    _stateL.text = @"OBS";
    if ([hzModel.coinid intValue]==1) {
        _stateL.text = @"USDT";
    }
    NSString *dt = [hzModel.dtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringWithRange:NSMakeRange(5, 11)];
    _timeL.text = dt;
    _numL1.text = [JCTool removeZero:hzModel.amount];
    _numL2.text = _hzModel.stateStr;
    
    
}

@end


@implementation TXCell

-(void)setModel:(TXModel *)model
{
    _model = model;
    _qiL.text = [NSString stringWithFormat:@"%@%@%@",TLOCAL(@"第"),model.roundid,TLOCAL(@"期")];
    int num11 = [model.roundid intValue]/100;
    int num12 = [model.roundid intValue]%100;
    if (num11>0) {
        _qiL.text = [NSString stringWithFormat:@"RE%02d-%02d%@",num11,num12,TLOCAL(@"期")];
    }
    _typeL.text = model.typeStr;
    NSString *dz = TLOCAL(@"未到账");
    if (model.confirmed==1) {
        dz = TLOCAL(@"已到账");
    }
    _stateL.text = dz;
    _feeL.text = [JCTool removeZero:model.fee_num];
    _amountL.text = [JCTool removeZero:model.amount_num];
    
}

@end

@implementation WTCell

-(void)setModel:(WTModel *)model
{
    _model = model;
    NSString *coinName = @"USDT";
    if ([model.lx isEqualToString:@"sell"])
    {
        _l1.text = TLOCAL(@"卖出");
        _l1.textColor = ColorWithHex(@"FF2600");
    }else
    {
        _l1.text = TLOCAL(@"买入");
        _l1.textColor = [JCTool themColor];
        coinName = @"OBS";
    }
    _l2.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"成交均价"),[JCTool removeZero:model.dealavg]];
    
    _l3.text = [NSString stringWithFormat:@"%@:%@%@",TLOCAL(@"手续费"),[JCTool removeZero:model.fee],coinName];
    _l4.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"状态"),model.statuStr];
    _l5.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"成交量"),[JCTool removeZero:model.dealcount]];
    _l6.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"成交额"),[JCTool removeZero:model.costed]];
    _l8.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"挂单价"),[JCTool removeZero:model.price]];
    _l9.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"挂单量"),[JCTool removeZero:model.count]];
    NSString *dt = [model.requesttime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringWithRange:NSMakeRange(5, 11)];
    _l7.text = dt;
    
}

-(void)setCdModel:(WTModel *)cdModel
{
    _cdModel = cdModel;
    _chedanBtn.hidden = cdModel.iscancel;
    NSString *coinName = @"USDT";
    if ([cdModel.lx isEqualToString:@"sell"])
    {
        _l1.text = TLOCAL(@"卖出");
        _l1.textColor = ColorWithHex(@"FF2600");
    }else
    {
        _l1.text = TLOCAL(@"买入");
        _l1.textColor = [JCTool themColor];
        coinName = @"OBS";
    }
    _l2.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"成交均价"),[JCTool removeZero:cdModel.dealavg]];
    
    _l3.text = [NSString stringWithFormat:@"%@:%@%@",TLOCAL(@"手续费"),[JCTool removeZero:cdModel.fee],coinName];
    _l4.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"状态"),cdModel.statuStr];
    _l5.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"成交量"),[JCTool removeZero:cdModel.dealcount]];
    _l6.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"成交额"),[JCTool removeZero:cdModel.costed]];
    _l8.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"挂单价"),[JCTool removeZero:cdModel.price]];
    _l9.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"挂单量"),[JCTool removeZero:cdModel.count]];
    NSString *dt = [cdModel.requesttime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringWithRange:NSMakeRange(5, 11)];
    _l7.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"时间"),dt];
    
}
@end


@implementation ChartLeftCell
-(void)setModel:(SugModel *)model
{
    
    _model = model;
    NSString *unc = [model.content stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    _contentL.text = unc;
}


@end

@implementation ChartRightCell
-(void)setModel:(SugModel *)model
{
    
    _model = model;
    NSString *unc = [model.content stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    _contentL.text = unc;
    
    
}


@end
#import <UIButton+WebCache.h>
@implementation IMGLeftCell
-(void)setModel:(SugModel *)model
{
    _model = model;
    _showImg.imageView.contentMode = UIViewContentModeScaleToFill;
    NSString *imgUrl = model.picurl;
    [_showImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] forState:(UIControlStateNormal) placeholderImage:TPlaceIMg];
    
}


- (IBAction)btnClick:(UIButton *)sender
{
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.image = _showImg.imageView.image;
    img.userInteractionEnabled = 1;
    [img addTapCallBack:self sel:@selector(removeimg:)];
    [[JCTool getWindow]addSubview:img];
    
}

-(void)removeimg:(UITapGestureRecognizer *)tap
{
    [tap.view removeFromSuperview];
}
@end

@implementation IMGRightCell
-(void)setModel:(SugModel *)model
{
     _model = model;
       _showImg.imageView.contentMode = UIViewContentModeScaleToFill;
       NSString *imgUrl = model.picurl;
       [_showImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] forState:(UIControlStateNormal) placeholderImage:TPlaceIMg];
}

- (IBAction)btnClick:(UIButton *)sender
{
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.image = _showImg.imageView.image;
    img.userInteractionEnabled = 1;
    [img addTapCallBack:self sel:@selector(removeimg:)];
    [[JCTool getWindow]addSubview:img];
        
}
    
-(void)removeimg:(UITapGestureRecognizer *)tap
{
    [tap.view removeFromSuperview];
}


@end
