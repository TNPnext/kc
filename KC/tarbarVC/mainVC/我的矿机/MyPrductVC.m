//
//  MyPrductVC.m
//  KC
//
//  Created by jian on 2019/10/30.
//  Copyright © 2019 jian. All rights reserved.
//

#import "MyPrductVC.h"
#import "SYDetailVC.h"
@interface MyPrductVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (assign, nonatomic)int page;
@property (weak, nonatomic) IBOutlet UIView *emptyV;



@end

@implementation MyPrductVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.hidden = 1;
    TInitArray;
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

- (IBAction)historyClick:(UIButton *)sender {
    UIViewController *vc = [JCTool getViewControllerWithID:@"MyYYReVC"];
    [self.navigationController pushViewController:vc animated:1];
}


- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:1];
}

-(void)getData
{
    TParms;
    kWeakSelf;
    [parms setValue:[NSString stringWithFormat:@"%d",_page] forKey:@"pageindex"];
    [parms setValue:@"1" forKey:@"state"];
    [NetTool getDataWithInterface:@"rzq.tradeorder.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                NSInteger totalPage = [[dic valueForKey:@"PageCount"] intValue];
                NSArray *modeA = [MyPrudctModel mj_objectArrayWithKeyValuesArray:list];
                [weakSelf.dataArray addObjectsFromArray:modeA];
                [weakSelf.tableView reloadData];
                if (totalPage == weakSelf.page) {
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
//    return 10;
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //MyPrudctModel *mm = _dataArray[indexPath.row];
    //if ([mm.day intValue]>0) {
        return 195;
    //}
   // return 210;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPrudctModel *mm = _dataArray[indexPath.row];
    MyPrductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.model = mm;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPrudctModel *mm = _dataArray[indexPath.row];
    if (mm.state ==1) {
        SYDetailVC *vc = [JCTool getViewControllerWithID:@"SYDetailVC"];
        vc.number = [JCTool removeZero:mm.rewardtotal];
        vc.titles = mm.productname;
        vc.orderid = mm.orderid;
        vc.type = 10;
        vc.interf = @"rzq.tradecreditorder.get";
        [self.navigationController pushViewController:vc animated:1];
    }
    
}
- (IBAction)buyBtn:(UIButton *)sender {
}
@end
