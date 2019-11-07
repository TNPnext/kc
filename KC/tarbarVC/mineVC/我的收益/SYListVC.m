//
//  SYListVC.m
//  KC
//
//  Created by jian on 2019/10/30.
//  Copyright © 2019 jian. All rights reserved.
//

#import "SYListVC.h"
#import "SYDetailVC.h"
@interface SYListVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (assign, nonatomic)int page;
@property (weak, nonatomic) IBOutlet UIView *emytyV;

@end

@implementation SYListVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = @[@"挖矿收益",@"节点分红",@"社区奖励"];
    SYModel *mm = _dataArray[indexPath.row];
    SYDetailVC *vc = [JCTool getViewControllerWithID:@"SYDetailVC"];
    vc.number = [JCTool removeZero:mm.dayamount];
    vc.titles = TLOCAL(arr[_type]);
    vc.exinfo = mm.exinfo;
    vc.interf = _interf;
    vc.type = _type;
    [[NSObject currentNavigationController] pushViewController:vc animated:1];
    
}


@end
