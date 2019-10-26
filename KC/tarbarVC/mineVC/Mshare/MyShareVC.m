//
//  MyShareVC.m
//  OBS
//
//  Created by jian on 2019/9/11.
//  Copyright © 2019 jian. All rights reserved.
//

#import "MyShareVC.h"

@interface MyShareVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *totalNum;
@property (weak, nonatomic) IBOutlet UILabel *xiaoquNum;
@property (weak, nonatomic) IBOutlet UIView *emptyL;
@end

@implementation MyShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TInitArray;
    _xiaoquNum.adjustsFontSizeToFitWidth = 1;
    _totalNum.adjustsFontSizeToFitWidth = 1;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self getData];
}

-(void)getData
{
    TParms;
    kWeakSelf;
    
    [parms setValue:[JCTool share].user.username forKey:@"username"];
    [parms setValue:@"" forKey:@"parm"];
    [parms setValue:[JCTool getLanguage] forKey:@"locale"];
    [parms setValue:@"2" forKey:@"platform"];
    [NetTool getDataWithInterface:@"/api/queryfriend" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSArray *arr = [[responseObject valueForKey:@"data"] mj_JSONObject];
                
                weakSelf.dataArray = [UserModel mj_objectArrayWithKeyValuesArray:arr];
                CGFloat num = 0;
                for (UserModel *mm in weakSelf.dataArray)
                {
                    num +=mm.totaladded;
                    num +=mm.selfadded;
                }
                if(arr.count>0)
                {
                    UserModel *mm = [weakSelf.dataArray firstObject];
                    CGFloat a1 = mm.totaladded;
                    CGFloat a2 = mm.selfadded;
                    CGFloat oo = num-a1-a2;
                    if (oo<=0) {
                        oo = 0;
                    }
                    weakSelf.xiaoquNum.text = [JCTool removeZero:oo];
                }
                weakSelf.totalNum.text = [JCTool removeZero:num];
               
                weakSelf.emptyL.hidden = weakSelf.dataArray.count;
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
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
