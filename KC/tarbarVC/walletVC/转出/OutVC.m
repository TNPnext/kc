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
    self.customNavBar.title = TLOCAL(@"转出");
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
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *arr = [dic valueForKey:@"List"];
                for (NSDictionary *dd in arr) {
                    NSString *coinid = [NSString stringWithFormat:@"%@",[dd valueForKey:@"coinid"]];
                    if ([coinid isEqualToString:[JCTool share].money.coinid]) {
                        NSString *fee = [dd valueForKey:@"fee"];
//                        NSString *logourl = [dd valueForKey:@"logourl"];
                        weakSelf.feeL.text = fee;
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
    
    _kL.text = [JCTool removeZero:[JCTool share].money.balance-[JCTool share].money.lockcount];
    
    
}

- (IBAction)chooseBtnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 10:
        {
            
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
            CGFloat userd = [JCTool share].money.balance-[JCTool share].money.lockcount;
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
