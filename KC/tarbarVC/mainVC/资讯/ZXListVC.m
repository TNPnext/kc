//
//  ZXListVC.m
//  KC
//
//  Created by jian on 2019/10/23.
//  Copyright © 2019 jian. All rights reserved.
//

#import "ZXListVC.h"

@interface ZXListVC ()
{
    NSString *lan_str;
}
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int pageNumber;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *emptyV;

@end

@implementation ZXListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lan_str = [JCTool getCurrLan];
    
    kWeakSelf;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMore];
    }];
    TInitArray;
    _page = 1;
    _pageNumber = 20;
    [self getListData];
    
}

-(void)refreshData
{
    _page = 1;
    [_dataArray removeAllObjects];
    [self getListData];
}

-(void)loadMore
{
    _page++;
    [self getListData];
}


-(void)getListData
{
    kWeakSelf;
    TParms;
    [parms setValue:[NSString stringWithFormat:@"%d",_pageNumber] forKey:@"pagesize"];
    [parms setValue:_code forKey:@"code"];
    [parms setValue:[NSString stringWithFormat:@"%d",_page] forKey:@"pageindex"];
    [NetTool getDataWithInterface:@"rzq.news.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                if (list.count>0) {
                    //NSArray *modeA = [ZXModel mj_objectArrayWithKeyValuesArray:list];
                    [weakSelf.dataArray addObjectsFromArray:list];
                    [weakSelf.tableView reloadData];
                    if (list.count<20) {
                        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                        [weakSelf.tableView.mj_header endRefreshing];
                    }else
                    {
                        [weakSelf.tableView.mj_footer endRefreshing];
                        [weakSelf.tableView.mj_header endRefreshing];
                    }
                }
                else
                {
                    [weakSelf.tableView.mj_footer endRefreshing];
                    [weakSelf.tableView.mj_header endRefreshing];
                }
               
            }
                break;
                
            default:
            {
                [weakSelf.tableView.mj_footer endRefreshing];
                [weakSelf.tableView.mj_header endRefreshing];
            }
                break;
        }
    } failure:^(NSError *error) {
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
    if ([_code isEqualToString:@"xwgg"]) {
        return 80;
    }
    return 105;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //ZXModel createtime
    NSDictionary *dic = _dataArray[indexPath.row];
    if ([_code isEqualToString:@"xwgg"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        UIView *vv = [cell.contentView viewWithTag:120];
        UILabel *l1 = [vv viewWithTag:10];
        UILabel *l2 = [vv viewWithTag:11];
        
        NSString *tit = [dic valueForKey:[NSString stringWithFormat:@"title_%@",lan_str]];
        if (kStringIsEmpty(tit)) {
            tit = @"";
        }
        l1.text = tit;
        NSString *dt = [dic valueForKey:@"createtime"];
        dt = [dt stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        l2.text = dt;
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    UIView *vv = [cell.contentView viewWithTag:120];
    UILabel *l1 = [vv viewWithTag:10];
    UILabel *l2 = [vv viewWithTag:11];
    UIImageView *l3 = [vv viewWithTag:12];
    
    NSString *tit = [dic valueForKey:[NSString stringWithFormat:@"title_%@",lan_str]];
    if (kStringIsEmpty(tit)) {
        tit = @"";
    }
    l1.text = tit;
    NSString *dt = [dic valueForKey:@"createtime"];
    dt = [dt stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    l2.text = dt;
    NSString *url = [dic valueForKey:@"picurl"];
    if (kStringIsEmpty(url)) {
        url = @"";
    }
    [l3 sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:TPlaceIMg];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _dataArray[indexPath.row];
    WebViewController *webV = [WebViewController new];
    NSString *tit = [dic valueForKey:[NSString stringWithFormat:@"title_%@",lan_str]];
    if (kStringIsEmpty(tit)) {
        tit = @"";
    }
    webV.t_tilte = tit;
    NSString *url = [dic valueForKey:[NSString stringWithFormat:@"linkurl_%@",lan_str]];
    if (kStringIsEmpty(url)) {
        url = @"";
    }
    webV.reqUrl = url;
    
    
    [self.navigationController pushViewController:webV animated:1];
    
}

@end
