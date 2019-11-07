//
//  SLZLVC.m
//  KC
//
//  Created by jian on 2019/10/30.
//  Copyright © 2019 jian. All rights reserved.
//

#import "SLZLVC.h"

@interface SLZLVC ()
{
    BOOL checkXY;
}
@property (weak, nonatomic) IBOutlet UIView *SView;
@property (weak, nonatomic) IBOutlet UITextField *numberF;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *price_deL;
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
    KAddNoti(@selector(textChange), UITextFieldTextDidEndEditingNotification);
    KAddNoti(@selector(moneyChage), KMMChange);
    self.customNavBar.hidden = 1;
//    [self.customNavBar wr_setRightButtonWithTitle:TLOCAL(@"购买规则") font:14];
//    [self.customNavBar wr_setRightButtonWithTitle:TLOCAL(@"购买规则") titleColor:kTextColor3];
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self getinfoData];
    [self moneyChage];
    
}

-(void)moneyChage
{
    _userdL.text = [JCTool removeZero:[JCTool getCanPay]];
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
    _nameL.text = _model.productname;
    _priceL.text = [NSString stringWithFormat:@"$%@/T",[JCTool removeZero:_model.price]];
    _apriceL.attributedText = [NSString addRemoveLineOnString:[NSString stringWithFormat:@"%@:$%@/T",TLOCAL(@"优惠价"),[JCTool removeZero:_model.aprice]]];
    
    _price_deL.text = [NSString stringWithFormat:@"%dT%@",_model.mincount_peruser,TLOCAL(@"起售")];
    _totalL.text = [NSString stringWithFormat:@"%@T",[JCTool removeZero:_model.totalcount]];
    _zjL.text = [JCTool removeZero:_model.price*[_numberF.text intValue]];
    _totL.text = [NSString stringWithFormat:@"$%@",_zjL.text];
    _name2.text = _nameL.text;
    _price2.text = _priceL.text;
    _numL.text = [NSString stringWithFormat:@"%@T",_numberF.text];
    _snumL.text = _numL.text;
    
    
    
    _price2L.text = _priceL.text;
    _pricea2L.attributedText = [NSString addRemoveLineOnString:[NSString stringWithFormat:@"%@:$%@/T",TLOCAL(@"优惠价"),[JCTool removeZero:_model.aprice]]];
    
    [SVProgressHUD dismiss];
}





@end
