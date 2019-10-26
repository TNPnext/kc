//
//  WalletVC.m
//  OBS
//
//  Created by jian on 2019/9/9.
//  Copyright © 2019 jian. All rights reserved.
//

#import "WalletVC.h"
#import "WalletReVC.h"
@interface WalletVC()
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableDictionary *coinPriceDic;
@property (weak, nonatomic) IBOutlet UILabel *topNumL;
@property (assign, nonatomic)NSInteger types;
@property (weak, nonatomic) IBOutlet UIView *wallV1;
@property (weak, nonatomic) IBOutlet UIView *wallV2;


@end

@implementation WalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.hidden = 1;
    KAddNoti(@selector(reloadTopV), KMMChange);
    TInitArray;
    _coinPriceDic = [NSMutableDictionary dictionary];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    _types = 0;

    [self getData];
    
    
    
}


-(void)getData
{
    NSDate *detailDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    TParms;
    kWeakSelf;
    NSString *interf = @"/api/querybalance";
    if (_types==1) {
        interf = @"/api/querytradebalance";
    }
    [parms setValue:[JCTool share].user.username forKey:@"username"];
    [parms setValue:TSEC(currentDateStr) forKey:@"parm"];
    [parms setValue:[JCTool getLanguage] forKey:@"locale"];
    [parms setValue:@"2" forKey:@"platform"];
    [NetTool getDataWithInterface:interf Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSArray *arr = [[responseObject valueForKey:@"data"] mj_JSONObject];
                NSArray *sorA = [JCTool sortUpdataArray:arr sortString:@"coinid"];
                
                weakSelf.dataArray = [MoneyModel mj_objectArrayWithKeyValuesArray:sorA];
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                if (sorA.count>0) {
                    for (NSDictionary *mdic in sorA)
                    {
                        [dict setValue:mdic forKeyPath:[NSString stringWithFormat:@"%@",[mdic valueForKey:@"coinid"]]];
                    }
                }
                if (weakSelf.types==0) {
                    [JCTool share].moneyDic = dict;
                }else
                {
                    [JCTool share].tradeMoneyDic = dict;
                }
                [weakSelf getHangqing];
                [weakSelf.tableView.mj_header endRefreshing];
            }
                break;
                
            default:
                [weakSelf.tableView.mj_header endRefreshing];
                break;
        }
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}



-(void)getHangqing
{
    kWeakSelf;
    [NetTool getTypeDataWithInterface:@"/api/gettokenprice" Parameters:nil success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSArray *arr = [[responseObject valueForKey:@"data"] mj_JSONObject];
                
                NSArray *nA = [CoinModel mj_objectArrayWithKeyValuesArray:arr];
                for (CoinModel *mm in nA) {
                    [weakSelf.coinPriceDic setValue:mm forKey:[NSString stringWithFormat:@"%d",mm.coinid]];
                }
                [weakSelf reloadTopV];
            }
                break;
                
            default:
                
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)reloadTopV
{
    NSArray *dA = [[JCTool share].moneyDic allValues];
    if (_types==1) {
        dA = [[JCTool share].tradeMoneyDic allValues];
    }
    
    NSArray *sorA = [JCTool sortUpdataArray:dA sortString:@"coinid"];
    _dataArray = [MoneyModel mj_objectArrayWithKeyValuesArray:sorA];
    CGFloat total = 0.00;
    for (MoneyModel *mm in _dataArray)
    {
        if ([mm.coinid intValue]==1) {
            total +=mm.balance;
        }else
        {
            CoinModel *cm = [_coinPriceDic valueForKey:mm.coinid];
            total +=mm.balance*cm.price;
        }
    }
    _topNumL.text = [JCTool removeZero:total];
    [_tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WalletCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ss = @"WalletReVC";
    if (_types==1) {
        ss = @"BBWReVC";
    }
    WalletReVC *vc = [JCTool getViewControllerWithID:ss];
    MoneyModel *mm = _dataArray[indexPath.row];
    vc.coinid = mm.coinid;
    [self.navigationController pushViewController:vc animated:1];
}

- (IBAction)outBtnClick:(UIButton *)sender {
    
    
    NSArray *arr = @[@"HChongVC",@"OutVC",@"BBHZVC",@"BBZRVC",@"BBTXVC"];//BBHVC/BBHZVC
    UIViewController *vc = [JCTool getViewControllerWithID:arr[sender.tag-10]];
    [self.navigationController pushViewController:vc animated:1];
    
    
    
    
}


- (IBAction)navBtnClick:(UIButton *)sender
{
    [[JCTool share].leftVc openLeftView];
    
}


- (IBAction)segClick:(UIButton *)sender {
    _types = (sender.tag==10)?0:1;
    _wallV1.hidden = _types;
    _wallV2.hidden = !_types;
    
    [self getData];
    for (UIView *view in sender.superview.superview.subviews) {
        UILabel *l1 = [view viewWithTag:1];
        UILabel *line = [view viewWithTag:2];
        if (view.tag == sender.tag)
        {
            l1.textColor = [JCTool themColor];
            line.backgroundColor = [JCTool themColor];
        }else
        {
            l1.textColor = [UIColor whiteColor];
            line.backgroundColor = [UIColor clearColor];
        }
        
    }
}
@end
