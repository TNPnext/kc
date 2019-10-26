//
//  HMainVC.m
//  XHSJ
//
//  Created by jian on 2019/9/6.
//  Copyright © 2019 jian. All rights reserved.
//

#import "HMainVC.h"
#import "AdcVC.h"
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
@property(nonatomic,strong)NSDictionary *advDic;
@property (weak, nonatomic) IBOutlet UILabel *advTitleL;
@property (weak, nonatomic) IBOutlet UIView *advView;


@end

@implementation HMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TInitArray;
    lan_str = [JCTool getCurrLan];
    _advDic = [NSDictionary new];
    self.customNavBar.hidden = 1;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    for (UIButton *btn in _itemBg.subviews) {
        [btn layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleTop) imageTitleSpace:20];
    }
    [_advView addTapGestureWithTarget:self selector:@selector(advClick:)];
    _tableHeader.size = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/2+165);
    
    [self getBannerData];
    [self getxwggData];
}

- (IBAction)advClick:(UIButton *)sender
{
    UIViewController *vc = [JCTool getViewControllerWithID:@"ZXVC" name:@"Login"];
    [self.navigationController pushViewController:vc animated:1];
    
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
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    UIButton *btn = [cell.contentView viewWithTag:10];
    btn.backgroundColor = ColorWithHex(@"#00B88E");
    if (indexPath.row==1 ) {
        btn.backgroundColor = ColorWithHex(@"#F5353D");
    }
    return cell;
}



- (IBAction)itemBtnClick:(UIButton *)sender {

//     AdcVC*vc;
//    switch (sender.tag) {
//        case 10:
//        {
//            vc = [JCTool getViewControllerWithID:@"JoinReVC"];
//        }
//            break;
//        case 11:
//        {
//            vc = [JCTool getViewControllerWithID:@"AdcVC"];
//            vc.t_tilte = TLOCAL(@"公告中心");
//
//
//        }
//            break;
//        case 12:
//        {
//            vc = [JCTool getViewControllerWithID:@"HCurrVC"];
//        }
//            break;
//        default:
//            break;
//    }
//    [self.navigationController pushViewController:vc animated:1];

}



@end
