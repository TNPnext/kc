//
//  OutVC.m
//  OBS
//
//  Created by jian on 2019/9/10.
//  Copyright © 2019 jian. All rights reserved.
//

#import "OutVC.h"

@interface OutVC ()
{
    MoneyModel *_sModel;
    CGFloat minCount;
}

@property (strong, nonatomic)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *feeL;
@property (weak, nonatomic) IBOutlet UITextField *numberF;
@property (weak, nonatomic) IBOutlet UITextField *addressF;

@property (weak, nonatomic) IBOutlet UILabel *kL;
@property (weak, nonatomic) IBOutlet UILabel *dL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;


@end

@implementation OutVC

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic = [[JCTool share].configDic valueForKey:@"503"];
    minCount = [[dic valueForKey:@"val"] doubleValue];
    self.customNavBar.title = TLOCAL(@"提币");
    TInitArray;
    KAddNoti(@selector(reloadData), KMMChange);
   
    [self reloadData];
    
    [self getdata];
    
}

-(void)getdata
{
    TParms;
    kWeakSelf;
    [NetTool getDataWithInterface:@"rzq.coindefine.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                
                NSArray *arr = [responseObject valueForKey:@"data"];
                for (NSDictionary *dd in arr) {
                    NSString *ss = [NSString stringWithFormat:@"%@",[dd valueForKey:@"coinid"]];
                    if ([ss intValue]==1) {
                        NSString *fee = [dd valueForKey:@"fee"];
                        weakSelf.feeL.text = [JCTool removeZero:[fee doubleValue]];
                        break;
                    }
                }
            }
                break;
                
            default:
                
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)reloadData
{
    _dL.text = [JCTool removeZero:[JCTool share].money.lockcount];
    
    _kL.text = [JCTool removeZero:[JCTool getCanPay]];
    
    
}

- (IBAction)chooseBtnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 10:
        {
            //全部
            _numberF.text = [JCTool removeZero:[JCTool getCanPay]];
        }
            break;
        case 11:
        {
            //扫描
            ScanViewController *vc = [ScanViewController new];
            kWeakSelf;
            vc.scanFinishedBlock = ^(NSString * _Nullable scanString) {
                weakSelf.addressF.text = scanString;
            };
            [self.navigationController pushViewController:vc animated:1];
        }
            break;
        case 12:
        {
            //转出
            if (_addressF.text.length<1) {
                TShowMessage(@"请输入或扫描转出地址");
                return;
            }
            if ([_numberF.text doubleValue]<=0) {
                TShowMessage(@"转出数量不能小于等于0");
                return;
            }
            if ([_numberF.text doubleValue]<minCount) {
                NSString *ss = [NSString stringWithFormat:@"%@%@",TLOCAL(@"转出数量不能小于"),[JCTool removeZero:minCount]];
                TShowMessage(ss);
                return;
            }
            
            CGFloat userd = [JCTool getCanPay];
            if ([_numberF.text doubleValue]>userd)
            {
                TShowMessage(@"可用余额不足");
                return;
            }
            if (![JCTool share].user.transcodeseted) {
                [JCTool settingPass];
                return;
            }
            kWeakSelf;
            [JCTool inputPassWord:^(NSString *password) {
                [weakSelf pay:password];
            }];
            
            
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
    [parms setValue:_addressF.text forKey:@"address"];
    [parms setValue:_numberF.text forKey:@"amount"];
    [NetTool getDataWithInterface:@"rzq.transaction.out" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                TAlertShow(@"提币成功,到账情况请以主链处理结果为准");
                weakSelf.addressF.text = @"";
                weakSelf.numberF.text = @"";
                [JCTool querybalance];
            }
                break;
                
            default:
                TAlertShowResMsg;
                break;
        }
    } failure:^(NSError *error) {
        TAlertShowNetError;
    }];
}





@end
