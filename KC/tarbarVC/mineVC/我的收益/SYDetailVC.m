//
//  SYDetailVC.m
//  KC
//
//  Created by jian on 2019/10/31.
//  Copyright © 2019 jian. All rights reserved.
//

#import "SYDetailVC.h"

@interface SYDetailVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (assign, nonatomic)int page;
@property (weak, nonatomic) IBOutlet UILabel *titL;
@property (weak, nonatomic) IBOutlet UILabel *numberL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UIView *emptyV;

@end

@implementation SYDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.hidden = 1;
    _numberL.text = _number;
    _titL.text = _titles;
    _timeL.text = @"";
    if (_exinfo) {
        _timeL.text = _exinfo;
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
    [parms setValue:[NSString stringWithFormat:@"%d",_page] forKey:@"pageindex"];
    if (_exinfo) {
        [parms setValue:_exinfo forKey:@"exinfo"];
    }
    if (_orderid) {
        [parms setValue:_orderid forKey:@"orderid"];
    }
    [NetTool getDataWithInterface:_interf Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                NSInteger totalPage = [[dic valueForKey:@"PageCount"] intValue];
                NSArray *modeA = [SYModel mj_objectArrayWithKeyValuesArray:list];
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
                weakSelf.emptyV.hidden = weakSelf.dataArray.count;
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
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_type==1 ||_type==2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        SYModel *mm = _dataArray[indexPath.row];
        UILabel *l1 = [cell.contentView viewWithTag:10];
        UILabel *l2 = [cell.contentView viewWithTag:11];
        UILabel *l3 = [cell.contentView viewWithTag:12];
        l1.text = [NSString stringWithFormat:@"%@",[JCTool removeZero:mm.rewardamount]];
        l2.text = mm.linklevel;
        l3.text = mm.stateStr;
        return cell;
    }
    if (_type==10) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        SYModel *mm = _dataArray[indexPath.row];
        UILabel *l1 = [cell.contentView viewWithTag:10];
        UILabel *l2 = [cell.contentView viewWithTag:11];
        UILabel *l3 = [cell.contentView viewWithTag:12];
        l1.text = [NSString stringWithFormat:@"%@-%@-%@",[mm.exinfo substringToIndex:4],[mm.exinfo substringWithRange:NSMakeRange(4, 2)],[mm.exinfo substringWithRange:NSMakeRange(6, 2)]];
        l2.text = [NSString stringWithFormat:@"+%@",[JCTool removeZero:mm.rewardamount]];
        l3.text = mm.stateStr;
        return cell;
        
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    SYModel *mm = _dataArray[indexPath.row];
    UILabel *l1 = [cell.contentView viewWithTag:10];
    UILabel *l2 = [cell.contentView viewWithTag:11];
    UILabel *l3 = [cell.contentView viewWithTag:12];
    l1.text = [NSString stringWithFormat:@"%@",[JCTool removeZero:mm.rewardamount]];
    NSString *number = [mm.exinfo stringByAppendingString:[JCTool sixNumber:mm.orderid]];
    l2.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"单号"),number];
    l3.text = mm.stateStr;
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:1];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:1];
}
@end
