//
//  WalletReVC.m
//  OBS
//
//  Created by jian on 2019/9/17.
//  Copyright © 2019 jian. All rights reserved.
//

#import "WalletReVC.h"

@interface WalletReVC ()

@property (weak, nonatomic) IBOutlet UIView *segV;
@property (weak, nonatomic) IBOutlet UIView *segV2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *emptyV;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (strong, nonatomic)NSMutableArray *dataArray2;
@property (strong, nonatomic)NSMutableArray *dataArray3;
@property (assign, nonatomic)NSInteger segIndex;


@end

@implementation WalletReVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = TLOCAL(@"账单");
    if ([_coinid intValue]==1) {
        _segV2.hidden = 0;
    }
    TInitArray;
    _dataArray2 = [NSMutableArray array];
    _dataArray3 = [NSMutableArray array];
    _segIndex = 0;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self getData];
    
}

-(void)getData
{
    
    TParms;
    kWeakSelf;
    [parms setValue:[JCTool share].user.username forKey:@"username"];
    NSString *ss = [NSString stringWithFormat:@"%@,0,0",_coinid];
    [parms setValue:[JCTool getLanguage] forKey:@"locale"];
    [parms setValue:@"2" forKey:@"platform"];
    NSString *inter = @"/api/querytransout";
    if (_segIndex==1) {
        inter = @"/api/querytransin";
    }
    if (_segIndex==2) {
        inter = @"/api/queryqueue";
        ss = [NSString stringWithFormat:@"0,0"];
    }
    [parms setValue:TSEC(ss) forKey:@"parm"];
    [NetTool getDataWithInterface:inter Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSArray *arr = [[responseObject valueForKey:@"data"] mj_JSONObject];
                
                
                if (weakSelf.segIndex==1) {
                    weakSelf.dataArray2 = [WalletReInModel mj_objectArrayWithKeyValuesArray:arr];
                    weakSelf.emptyV.hidden = weakSelf.dataArray2.count;
                }else if(weakSelf.segIndex==0)
                {
                   weakSelf.dataArray = [WalletReOutModel mj_objectArrayWithKeyValuesArray:arr];
                    weakSelf.emptyV.hidden = weakSelf.dataArray.count;
                }else
                {
                    weakSelf.dataArray3 = [JoinModel mj_objectArrayWithKeyValuesArray:arr];
                    weakSelf.emptyV.hidden = weakSelf.dataArray3.count;
                }
                [weakSelf.tableView reloadData];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_segIndex==1) {
        return _dataArray2.count;
    }
    if (_segIndex==2) {
        return _dataArray3.count;
    }
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WalletReInModel *model ;
    if (_segIndex==1) {
        model = _dataArray2[indexPath.row];
    }else if(_segIndex==0)
    {
        model = _dataArray[indexPath.row];
    }else
    {
        model = _dataArray3[indexPath.row];
        if (model.tradehash.length>0) {
            return 140;
        }
        return 105;
    }
    
    if (model.tradehash.length<1) {
        return 130;
    }
    return 140;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_segIndex==1) {
        WalletOutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.model = _dataArray2[indexPath.row];
        return cell;
    }
    if (_segIndex==2) {
        YYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.model = _dataArray3[indexPath.row];
        return cell;
    }
    WalletInCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(IBAction)btnClick:(UIButton *)sender
{
    _segIndex = sender.tag-10;
    UIView *fuV = _segV;
    if ([_coinid intValue]==1) {
        fuV = _segV2;
    }
    for (UIButton *btn in fuV.subviews)
    {
        if (btn.tag>9) {
            if (btn.tag == sender.tag) {
                [btn setBackgroundImage:TimageName(@"lun_top_s") forState:(UIControlStateNormal)];
                [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                
            }else
            {
                [btn setBackgroundImage:TimageName(@"lun_top_n") forState:(UIControlStateNormal)];
                [btn setTitleColor:ColorWithHex(@"#6D7DFE") forState:(UIControlStateNormal)];
            }
        }
    }
    [self getData];
    
}
@end
