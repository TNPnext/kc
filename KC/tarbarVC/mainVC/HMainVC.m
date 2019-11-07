//
//  HMainVC.m
//  XHSJ
//
//  Created by jian on 2019/9/6.
//  Copyright © 2019 jian. All rights reserved.
//

#import "HMainVC.h"
#import "Header.h"
@interface HMainVC ()<SDCycleScrollViewDelegate>
{
    NSString *lan_str;
}
@property (weak, nonatomic) IBOutlet UIView *itemBg;
@property (weak, nonatomic) IBOutlet UIView *tableHeader;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bannerV;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *hqDataArray;
@property(nonatomic,strong)NSDictionary *advDic;
@property (weak, nonatomic) IBOutlet UILabel *advTitleL;
@property (weak, nonatomic) IBOutlet UIView *advView;
@property (weak, nonatomic) IBOutlet UIView *SXView;


@end

@implementation HMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SocketTool share]initSocketsocket];
    TInitArray;
    _hqDataArray = [NSMutableArray array];
    lan_str = [JCTool getCurrLan];
    _advDic = [NSDictionary new];
    self.customNavBar.hidden = 1;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    NSArray *tAA = @[@"我的矿机",@"项目概况",@"疑问解答"];
    for (UIButton *btn in _itemBg.subviews) {
        [btn setTitle:TLOCAL(tAA[btn.tag-10]) forState:(UIControlStateNormal)];
        [btn layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleTop) imageTitleSpace:20];
    }
    tAA = @[@"币种",@"最新价",@"涨幅度"];
    for (UIButton *btn in _SXView.subviews) {
        [btn setTitle:TLOCAL(tAA[btn.tag-1]) forState:(UIControlStateNormal)];
        [btn layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleRight) imageTitleSpace:0];
    }
    [_advView addTapGestureWithTarget:self selector:@selector(advClick:)];
    _tableHeader.size = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/2+165+30);
    
    [self getBannerData];
    [self getxwggData];
    [self getHangQingList];
}

- (IBAction)advClick:(UIButton *)sender
{
    UIViewController *vc = [JCTool getViewControllerWithID:@"ZXVC" name:@"Login"];
    [self.navigationController pushViewController:vc animated:1];
    
}

- (IBAction)sxbtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
    
    
}



-(void)initBanner
{
    SDCycleScrollView *t_banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2) delegate:self placeholderImage:TimageName(@"bannerp")];
    t_banner.backgroundColor = [UIColor whiteColor];
    t_banner.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    t_banner.autoScrollTimeInterval = 4;
    t_banner.pageControlBottomOffset = 15;
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *mm in _dataArray) {
        [arr addObject:[mm valueForKey:@"picurl"]];
    }
    t_banner.imageURLStringsGroup = arr;
    
    [_bannerV addSubview:t_banner];
    [_tableView reloadData];
    
}

-(void)getHangQingList
{
    kWeakSelf;
     TParms;
    [NetTool getDataWithInterface:@"rzq.marketdetail.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSArray *list = [responseObject valueForKey:@"data"];
                if (list.count>0) {
                    
                    NSArray *arr = [JCTool sortUpdataArray:list sortString:@"coinid"];
                    
                    weakSelf.hqDataArray = [CoinModel mj_objectArrayWithKeyValuesArray:arr];
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


-(void)getxwggData
{
    kWeakSelf;
     TParms;
    [parms setValue:@"xwgg" forKey:@"code"];
    [parms setValue:@"1" forKey:@"pagesize"];
    [parms setValue:@"1" forKey:@"pageindex"];
    [NetTool getDataWithInterface:@"rzq.news.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                if (list.count>0) {
                    weakSelf.advDic = [list firstObject];
                    NSString *tit = [weakSelf.advDic valueForKey:[NSString stringWithFormat:@"title_%@",self->lan_str]];
                    if (kStringIsEmpty(tit)) {
                        tit = @"";
                    }
                    weakSelf.advTitleL.text = tit;
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

-(void)getBannerData
{
    kWeakSelf;
    TParms;
   [parms setValue:@"homenanner" forKey:@"code"];
   [NetTool getDataWithInterface:@"rzq.news.get" Parameters:parms success:^(id  _Nullable responseObject) {
       switch (TResCode) {
           case 1:
           {
               NSDictionary *dic = [responseObject valueForKey:@"data"];
               NSArray *list = [dic valueForKey:@"List"];
               if (list.count>0) {
                   weakSelf.dataArray = list.mutableCopy;
                   
                   [weakSelf initBanner];
               }
           }
               break;
           default:
                break;
       }
   } failure:^(NSError *error) {
      
   }];
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSDictionary *dic = _dataArray[index];
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _hqDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainHqCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];

    cell.model = _hqDataArray[indexPath.row];
    return cell;
}



- (IBAction)itemBtnClick:(UIButton *)sender {

    
    NSArray *vcA = @[@"MyPrductVC",@"XMGKVC",@"SugReVC"];
    BaseViewController *vc = [JCTool getViewControllerWithID:vcA[sender.tag-10]];
    [self.navigationController pushViewController:vc animated:1];

}



@end
