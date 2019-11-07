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


@implementation MainHqCell

-(void)setModel:(CoinModel *)model
{
    _model = model;
    _label1.text = model.coinname;
    _label2.text = [JCTool removeZero:_model.price];
    
    _label2.textColor = ColorWithHex(@"00B88E");
    _btn.backgroundColor = ColorWithHex(@"00B88E");
    //F5353D 红 /00B88E
    CGFloat pct = (model.price - model.open)/model.open*100.0;
    if (model.open==0) {
        pct = 0.00;
    }
    if (pct<0) {
        [_btn setTitle:[NSString stringWithFormat:@"%@%%",[JCTool removeZero:pct]] forState:(UIControlStateNormal)];
        _btn.backgroundColor = ColorWithHex(@"F5353D");
        _label2.textColor = ColorWithHex(@"F5353D");
    }else
    {
       [_btn setTitle:[NSString stringWithFormat:@"+%@%%",[JCTool removeZero:pct]] forState:(UIControlStateNormal)];
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
   
    _label1.adjustsFontSizeToFitWidth = 1;
    _label2.adjustsFontSizeToFitWidth = 1;
    
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

@implementation SYCell

-(void)setModel:(SYModel *)model
{
    _model = model;
    _stateL.text = model.stateStr;
    _timeL.text = model.exinfo;
    _numberL.text = [JCTool removeZero:model.dayamount];
}

@end

@implementation MyPrductCell

-(void)setModel:(MyPrudctModel *)model
{
    _model = model;
    _nameL.text = model.productname;
    
    NSString *dt = [model.stime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dt = [dt substringToIndex:10];
    _timeL.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"购买时间"),dt];
    dt = [dt stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    _orderidL.text = [NSString stringWithFormat:@"%@:%@%@",TLOCAL(@"单号"),dt,[JCTool sixNumber:model.orderid]];
    _priceL.text = [NSString stringWithFormat:@"%@:$%@/T",TLOCAL(@"购买价格"),[JCTool removeZero:model.buyprice]];
    _slL.text = [JCTool removeZero:model.rewardtotal];
    
    _numL.text = [NSString stringWithFormat:@"%@:%dT",TLOCAL(@"购买数量"),model.buycount];
    _cosetL.text = [NSString stringWithFormat:@"$%@",[JCTool removeZero:model.buytotal]];
    _chakan1.hidden = 0;
    _chakan2.hidden = 0;
    _chakan3.hidden = 1;
    NSDictionary *lanD = KOutObj(Klanguage);
    if ([[lanD valueForKey:@"idx"] intValue]==2) {
        _chakan1.hidden = 1;
        _chakan2.hidden = 1;
        _chakan3.hidden = 0;
    }
    
    
}

-(void)setYmodel:(MyYYReModel *)ymodel
{
    _ymodel = ymodel;
    _nameL.text = ymodel.productname;
    [_stateBtn setTitle:ymodel.stateStr forState:(UIControlStateNormal)];
    _num1.text = [NSString stringWithFormat:@"%dT",ymodel.buycount];
    _num2.text = [NSString stringWithFormat:@"%dT",ymodel.buiedcount];
    _num3.text =  [NSString stringWithFormat:@"%dT",ymodel.queuecount];
    _num4.text = [NSString stringWithFormat:@"$%@",[JCTool removeZero:ymodel.payedtotal]];
    _num5.text = [NSString stringWithFormat:@"$%@/T",[JCTool removeZero:ymodel.buyprice]];
    
    switch (ymodel.state) {
        case 1:
        {
            [_stateBtn setTitleColor:ColorWithHex(@"#FF374A") forState:(UIControlStateNormal)];
        }
            break;
        case 2:
        {
           [_stateBtn setTitleColor:ColorWithHex(@"#FF9A00") forState:(UIControlStateNormal)];
        }
            break;
        case 3:
        {
            [_stateBtn setTitleColor:ColorWithHex(@"#5193F4") forState:(UIControlStateNormal)];
        }
            break;
        default:
            break;
    }
    
    
}

-(void)setHismodel:(MyPrudctModel *)hismodel
{
    _hismodel = hismodel;
    _cosetL.text = [NSString stringWithFormat:@"%@",[JCTool removeZero:hismodel.buytotal]];
    _slL.text = [NSString stringWithFormat:@"%dT",hismodel.buycount];
    _reL.text = [NSString stringWithFormat:@"%@",[JCTool removeZero:hismodel.rewardtotal]];
    _timeL.text = hismodel.day;
    _priceL.text = [NSString stringWithFormat:@"$%@/T",[JCTool removeZero:hismodel.buyprice]];
    _nameL.text = [NSString stringWithFormat:@"%@  %dT",hismodel.productname,hismodel.buycount];
    _stimeL.text = [NSString stringWithFormat:@"%@%@",TLOCAL(@"从"),[hismodel.stime substringToIndex:10]];
    _etimeL.text = [NSString stringWithFormat:@"%@%@",TLOCAL(@"到"),[hismodel.etime substringToIndex:10]];
    
}
@end

