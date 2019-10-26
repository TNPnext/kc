//
//  TiXianReVC.m
//  OBS
//
//  Created by jian on 2019/9/26.
//  Copyright © 2019 jian. All rights reserved.
//

#import "TiXianReVC.h"

@interface TiXianReVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *emptyV;
@property (strong, nonatomic)NSMutableArray *dataArray;
@end

@implementation TiXianReVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TInitArray;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self getData];
    
}

-(void)getData
{
    
    TParms;
    kWeakSelf;
    NSString *ss = @"0,0";
    [parms setValue:[JCTool share].user.username forKey:@"username"];
    [parms setValue:TSEC(ss) forKey:@"parm"];
    [parms setValue:[JCTool getLanguage] forKey:@"locale"];
    [parms setValue:@"2" forKey:@"platform"];
    NSString *interf = @"/api/querysendqueen";
    [NetTool getDataWithInterface:interf Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                [SVProgressHUD dismiss];
                NSArray *arr = [[responseObject valueForKey:@"data"] mj_JSONObject];
                NSArray *sorA = [JCTool sortUpdataArray:arr sortString:@"roundid"];
                NSArray *revA = [[sorA reverseObjectEnumerator]allObjects];
                weakSelf.dataArray = [TXModel mj_objectArrayWithKeyValuesArray:revA];
                weakSelf.emptyV.hidden = weakSelf.dataArray.count;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header endRefreshing];
            }
                break;
                
            default:
            {
                [weakSelf.tableView.mj_header endRefreshing];
                TShowResMsg;
            }
                break;
        }
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        TShowNetError;
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    TXCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
