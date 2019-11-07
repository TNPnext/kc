//
//  WalletListVC.m
//  KC
//
//  Created by jian on 2019/10/31.
//  Copyright © 2019 jian. All rights reserved.
//

#import "WalletListVC.h"

@interface WalletListVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (assign, nonatomic)int page;
@property (weak, nonatomic) IBOutlet UIView *headerV;
@property (weak, nonatomic) IBOutlet UILabel *choseTitle;
@property (weak, nonatomic) IBOutlet UIView *emytyV;

@end

@implementation WalletListVC

- (IBAction)headerBtnClick:(UIButton *)sender {
    if (self.btnBlock) {
        self.btnBlock();
    }
    
}

-(void)reload:(NSString *)str type:(NSString *)type
{
    _type = type;
    _page = 1;
    _choseTitle.text = str;
    [_dataArray removeAllObjects];
    [self getData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    if (_index == 3) {
         _headerV.hidden = 0;
    }else
    {
       _headerV.hidden = 1;
        [_headerV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeZero);
        }];
    }
    
    _page = 1;
    kWeakSelf;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf getData];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf getData];
    }];
    TInitArray;
    [SVProgressHUD showWithStatus:@"loading..."];
    [self getData];
}

-(void)getData
{
    TParms;
    kWeakSelf;
    [parms setValue:_type forKey:@"tradetype"];
    [parms setValue:[NSString stringWithFormat:@"%d",_page] forKey:@"pageindex"];
    [NetTool getDataWithInterface:@"rzq.tradecoindetail.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                NSInteger totalPage = [[dic valueForKey:@"PageCount"] intValue];
                NSArray *modeA = [WalletListModel mj_objectArrayWithKeyValuesArray:list];
                [weakSelf.dataArray addObjectsFromArray:modeA];
                [weakSelf.tableView reloadData];
                if (totalPage==weakSelf.page) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                    [weakSelf.tableView.mj_header endRefreshing];
                }else
                {
                    [weakSelf.tableView.mj_footer endRefreshing];
                    [weakSelf.tableView.mj_header endRefreshing];
                }
                weakSelf.emytyV.hidden = weakSelf.dataArray.count;
                [SVProgressHUD dismiss];
            }
                break;
                
            default:
            {
                [SVProgressHUD dismiss];
                [weakSelf.tableView.mj_footer endRefreshing];
                [weakSelf.tableView.mj_header endRefreshing];
            }
                break;
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    WalletListModel *mm = _dataArray[indexPath.row];
    UILabel *l1 = [cell.contentView viewWithTag:10];
    UILabel *l2 = [cell.contentView viewWithTag:11];
    UILabel *l3 = [cell.contentView viewWithTag:12];
    UILabel *l4 = [cell.contentView viewWithTag:13];
    UILabel *l5 = [cell.contentView viewWithTag:14];
    l1.text = mm.typeStr;
    l2.text = [mm.dtime substringToIndex:10];
    l3.text = [NSString stringWithFormat:@"+%@",[JCTool removeZero:mm.inamount]];
    
    if (mm.outamount>0) {
       l3.text = [NSString stringWithFormat:@"-%@",[JCTool removeZero:mm.outamount]];
    }
    
    l4.text = mm.stateStr;
    l5.hidden = !mm.fee;
    l5.text = [NSString stringWithFormat:@"%@:%@USDT",TLOCAL(@"手续费"),[JCTool removeZero:mm.fee]];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

@end
