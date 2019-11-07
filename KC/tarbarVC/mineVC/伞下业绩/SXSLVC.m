//
//  SXSLVC.m
//  KC
//
//  Created by jian on 2019/10/30.
//  Copyright © 2019 jian. All rights reserved.
//

#import "SXSLVC.h"

@interface SXSLVC ()
{
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *auid;
@property (weak, nonatomic) IBOutlet UILabel *atotal;
@property (weak, nonatomic) IBOutlet UILabel *buid;
@property (weak, nonatomic) IBOutlet UILabel *btotal;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *sqL;
@property (weak, nonatomic) IBOutlet UILabel *xqL;

@property (weak, nonatomic) IBOutlet UIView *emptyV;

@property(nonatomic,assign)int page;
@end

@implementation SXSLVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = TLOCAL(@"社区矿机");
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
    [self getTopData];
    [SVProgressHUD showWithStatus:@"loading..."];
    [self getCenterData];
    [self getData];
}

-(void)getData
{
    TParms;
    kWeakSelf;
    [parms setValue:[NSString stringWithFormat:@"%d",_page] forKey:@"pageindex"];
    [NetTool getDataWithInterface:@"rzq.tradeteamtotal.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                NSInteger totalPage = [[dic valueForKey:@"PageCount"] intValue];
                [weakSelf.dataArray addObjectsFromArray:list];
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

-(void)getCenterData
{
    TParms;
    kWeakSelf;
    [NetTool getDataWithInterface:@"rzq.tradeteamtotal.sum.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                if (dic.count>0) {
                    CGFloat sqsl = [[dic valueForKey:@"sqsl"] doubleValue];
                    CGFloat sumall = [[dic valueForKey:@"sumall"] doubleValue];
                    weakSelf.xqL.text = [JCTool removeZero:sqsl];
                    weakSelf.sqL.text = [JCTool removeZero:sumall];
                }
            }
                break;
                
            default:
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)getTopData
{
    TParms;
    kWeakSelf;
    [NetTool getDataWithInterface:@"rzq.tradeteam_ab.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                if (dic.count>0) {
                    CGFloat atotal = [[dic valueForKey:@"atotal"] doubleValue];
                    CGFloat btotal = [[dic valueForKey:@"btotal"] doubleValue];
                    if (!kStringIsEmpty([dic valueForKey:@"acode"])) {
                         weakSelf.auid.text = [NSString stringWithFormat:@"UID:%@",[dic valueForKey:@"acode"]];
                    }
                    if (!kStringIsEmpty([dic valueForKey:@"bcode"])) {
                        weakSelf.buid.text = [NSString stringWithFormat:@"UID:%@",[dic valueForKey:@"bcode"]];
                    }
                   
                    
                    weakSelf.atotal.text = [JCTool removeZero:atotal];
                    weakSelf.btotal.text = [JCTool removeZero:btotal];
                }
            }
                break;
                
            default:
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = _dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    UIView *vv = cell.contentView;
    //selfadded  totaladded userlevel userid
    UILabel *l1 = [vv viewWithTag:10];
    UILabel *l2 = [vv viewWithTag:11];
    UILabel *l3 = [vv viewWithTag:12];
    UILabel *l4 = [vv viewWithTag:13];
    l1.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"mycode"]];
    l2.text = [NSString stringWithFormat:@"M%@",[dic valueForKey:@"userlevel"]];
    l3.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"selfadded"]];
    l4.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"totaladded"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
