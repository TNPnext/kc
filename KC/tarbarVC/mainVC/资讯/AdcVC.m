//
//  AdcVC.m
//  XHSJ
//
//  Created by jian on 2019/9/3.
//  Copyright © 2019 jian. All rights reserved.
//

#import "AdcVC.h"
#import "AdcDVC.h"
@interface AdcVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *emptyV;
@end

@implementation AdcVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    TInitArray;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getAd)];
    [self getAd];
    
}

-(void)getAd
{
    kWeakSelf;
    TParms;
    NSString *interf = @"/api/querynotice";
    NSString *ss = @"0,0";
    if (_isMessage) {
        interf = @"/api/querusermessage";
        ss = [NSString stringWithFormat:@"%@,0,0",[JCTool getMaxDate:@[]]];
        ss = TSEC(ss);
    }
    [parms setValue:[JCTool share].user.username forKey:@"username"];
    [parms setValue:ss forKey:@"parm"];
    [parms setValue:[JCTool getLanguage] forKey:@"locale"];
    [parms setValue:@"2" forKey:@"platform"];
    
    [NetTool getDataWithInterface:interf Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSArray *arr = [[responseObject valueForKey:@"data"] mj_JSONObject];
                NSArray *sorA;
                if (weakSelf.isMessage) {
                    //通知消息
                    sorA = [JCTool sortUpdataArray:arr sortDateString:@"sendtime"];
                }else
                {
                    //公告
                    sorA = [JCTool sortUpdataArray:arr sortString:@"idx"];
                    AdModel *lastm = [AdModel mj_objectWithKeyValues:[sorA lastObject]];
                    KSaveObj(lastm.idx, @"adMax");
                    
                }
                NSArray *revA = [[sorA reverseObjectEnumerator] allObjects];
                weakSelf.dataArray = [AdModel mj_objectArrayWithKeyValuesArray:revA];
                weakSelf.emptyV.hidden = weakSelf.dataArray.count;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header  endRefreshing];
            }
                break;
                
            default:
                [weakSelf.tableView.mj_header  endRefreshing];
                break;
        }
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header  endRefreshing];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    UILabel *l1 = [cell.contentView viewWithTag:10];
    UILabel *l2 = [cell.contentView viewWithTag:11];
    UILabel *l3 = [cell.contentView viewWithTag:12];
    AdModel *mm = _dataArray[indexPath.row];
    if (_isMessage) {
        l1.text = mm.title;
        l2.text = mm.subject;
        NSString *dt = [mm.sendtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        l3.text = [dt substringToIndex:10];
    }else
    {
       NSDictionary *land = KOutObj(Klanguage);
        l1.text = mm.title;
        l2.text = mm.subject;
        if ([[land valueForKey:@"app"] isEqualToString:@"en"])
        {
            l1.text = mm.titleen;
            l2.text = mm.subjecten;
        }
        NSString *dt = [mm.showtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        l3.text = [dt substringToIndex:10];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdModel *mm = _dataArray[indexPath.row];
    if (_isMessage) {
        AdcDVC *vc = [JCTool getViewControllerWithID:@"AdcDVC"];
        vc.model = mm;
        [self.navigationController pushViewController:vc animated:1];
        return;
    }
    WebViewController *vc = [WebViewController new];
    NSDictionary *land = KOutObj(Klanguage);
    
    if ([[land valueForKey:@"app"] isEqualToString:@"en"])
    {
        vc.t_tilte = mm.titleen;
        vc.reqUrl = mm.linkurlen;
    }else
    {
        vc.t_tilte = mm.title;
        vc.reqUrl = mm.linkurl;
    }
    [self.navigationController pushViewController:vc animated:1];
}
@end
