//
//  SugReVC.m
//  CSLH
//
//  Created by jian on 2019/8/24.
//  Copyright © 2019 jian. All rights reserved.
//

#import "SugReVC.h"
#import "ChartViewController.h"
@interface SugReVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *lan_str;
}
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (strong, nonatomic)NSArray *genArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int pageNumber;

@end

@implementation SugReVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    lan_str = [JCTool getCurrLan];
    [self initViews];
}

-(void)initViews
{
    TInitArray;
    self.customNavBar.hidden = 1;
    _page = 1;
    _pageNumber = 20;
    kWeakSelf;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    [self getData];
}

-(void)refreshData
{
    _page = 1;
    
    [self getData];
}

- (IBAction)upQuestionClick:(UIButton *)sender {
    UIViewController *vc = [JCTool getViewControllerWithID:@"SuggestVC" name:@"Login"];
    [self.navigationController pushViewController:vc animated:1];
    
}


-(void)getData
{
    TParms;
    kWeakSelf;
    [parms setValue:[NSString stringWithFormat:@"%d",_pageNumber] forKey:@"pagesize"];
    [parms setValue:[NSString stringWithFormat:@"%d",_page] forKey:@"pageindex"];
    [NetTool getDataWithInterface:@"rzq.customermsg.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dds = [responseObject valueForKey:@"data"];
                NSArray *arr = [dds valueForKey:@"List"];
                NSArray *mA = [SugModel mj_objectArrayWithKeyValuesArray:arr];
                weakSelf.dataArray = mA.mutableCopy;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header endRefreshing];
                   
                
            }
                break;
                
            default:
            {
                
                [weakSelf.tableView.mj_header endRefreshing];
            }
                break;
        }
    } failure:^(NSError *error) {
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    //常见问题
    [parms setValue:@"cjwt" forKey:@"code"];
    [NetTool getDataWithInterface:@"rzq.news.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                if (list.count>0) {
                    weakSelf.genArray = list;
                    [weakSelf.tableView reloadData];
                }
            }
                break;
                
            default:
                break;
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
       return _genArray.count;
    }
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NSDictionary *dic = _genArray[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        UILabel *label1 = [cell.contentView viewWithTag:10];
        NSString *tit = [dic valueForKey:[NSString stringWithFormat:@"title_%@",lan_str]];
        if (kStringIsEmpty(tit)) {
            tit = @"";
        }
        label1.text = tit;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    UILabel *label1 = [cell.contentView viewWithTag:10];
    UILabel *label2 = [cell.contentView viewWithTag:11];
    UIView *hongdian = [cell.contentView viewWithTag:12];
    SugModel *mm = _dataArray[indexPath.row];
    hongdian.hidden = !(mm.state==2);
    NSString *s1 = [mm.title stringByReplacingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)];
    //NSString *s2 = [mm.content stringByReplacingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)];
    NSString *dt = [mm.createtime componentsSeparatedByString:@"T"][0];
    label1.text = s1;
    label2.text = dt;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NSDictionary *dic = _genArray[indexPath.row];
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
        return;
    }
    SugModel *mm = _dataArray[indexPath.row];
    [self changeState:mm];
    ChartViewController *vc = [JCTool getViewControllerWithID:@"ChartViewController" name:@"Login"];
    vc.model = mm;
    [self.navigationController pushViewController:vc animated:1];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *titA = @[@"常见问题",@"历史提问"];
    UIView *view = [UIView new];
    view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 50);
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, SCREEN_WIDTH, 20)];
    label.text = TLOCAL(titA[section]);
    [view addSubview:label];
    
    
    return view;
}


-(IBAction)backClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:1];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:1];
    TParms;
    kWeakSelf;
    [parms setValue:[NSString stringWithFormat:@"%d",_pageNumber] forKey:@"pagesize"];
    [parms setValue:[NSString stringWithFormat:@"%d",_page] forKey:@"pageindex"];
    [NetTool getDataWithInterface:@"rzq.customermsg.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dds = [responseObject valueForKey:@"data"];
                NSArray *arr = [dds valueForKey:@"List"];
                NSArray *mA = [SugModel mj_objectArrayWithKeyValuesArray:arr];
                weakSelf.dataArray = mA.mutableCopy;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header endRefreshing];
                   
                
            }
                break;
                
            default:
            {
                
                [weakSelf.tableView.mj_header endRefreshing];
            }
                break;
        }
    } failure:^(NSError *error) {
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

-(void)changeState:(SugModel *)mm
{
    if (mm.state!=2) {
        return;
    }
    TParms;
    [parms setValue:mm.cid forKey:@"cmid"];
    [NetTool getDataWithInterface:@"rzq.customerstate.set" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                
            }
                break;
                
            default:
                break;
        }
    } failure:^(NSError *error) {
        
       
    }];
}
@end
