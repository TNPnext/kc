//
//  HMainVC.m
//  XHSJ
//
//  Created by jian on 2019/9/6.
//  Copyright © 2019 jian. All rights reserved.
//

#import "HMainVC.h"
#import "Header.h"
#import "SGAdvertScrollView.h"
@interface HMainVC ()<SDCycleScrollViewDelegate,SGAdvertScrollViewDelegate>
{
    NSString *lan_str;
}
@property (weak, nonatomic) IBOutlet UIView *itemBg;
@property (weak, nonatomic) IBOutlet UIView *tableHeader;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bannerV;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSArray *ggDataArray;
@property(nonatomic,strong)NSArray *hyDataArray;
@property(nonatomic,strong)NSDictionary *advDic;
@property (weak, nonatomic) IBOutlet UILabel *advTitleL;
@property (weak, nonatomic) IBOutlet UIView *advView;
@property (weak, nonatomic) IBOutlet UIView *SXView;
@property (weak, nonatomic) IBOutlet UIButton *zxBtn;
@property (strong, nonatomic)SGAdvertScrollView *advertV;

@end

@implementation HMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SocketTool share]initSocketsocket];
    
    TInitArray;
    _ggDataArray = [NSArray array];
    _hyDataArray = [NSArray array];
    lan_str = [JCTool getCurrLan];
    _advDic = [NSDictionary new];
    self.customNavBar.hidden = 1;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
   
    [_zxBtn setTitle:TLOCAL(@"查看更多") forState:(UIControlStateNormal)];
    [_zxBtn layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleRight) imageTitleSpace:5];
    
    
    //[_advView addTapGestureWithTarget:self selector:@selector(advClick:)];
    _tableHeader.size = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/2+165+30+10);
    
    _advertV = [[SGAdvertScrollView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 36)];
    _advertV.backgroundColor = [UIColor clearColor];
    _advertV.advertScrollViewStyle = SGAdvertScrollViewStyleNormal;
    _advertV.delegate = self;
    _advertV.titleFont = fontSize(14);
    _advertV.titleColor = kTextColor3;
    //_advertV.signImages = @[@"gonggao"];
    [_advView addSubview:_advertV];
    
   
    [self getBannerData];
    [self getxwggData];
    [self gethyxxData];
     
}




- (IBAction)advClick:(UIButton *)sender
{
    UIViewController *vc = [JCTool getViewControllerWithID:@"ZXVC" name:@"Login"];
    [self.navigationController pushViewController:vc animated:1];
    
}


- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index
{
    NSDictionary *dic = _ggDataArray[index];
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


-(void)initBanner
{
    SDCycleScrollView *t_banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2) delegate:self placeholderImage:TimageName(@"bannerp")];
    t_banner.backgroundColor = [UIColor whiteColor];
    t_banner.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    t_banner.autoScrollTimeInterval = 4;
    t_banner.pageControlBottomOffset = 0;
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *mm in _dataArray) {
        [arr addObject:[mm valueForKey:[NSString stringWithFormat:@"picurl_%@",[JCTool getCurrLan]]]];
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
    [parms setValue:@"3" forKey:@"pagesize"];
    [parms setValue:@"1" forKey:@"pageindex"];
    [NetTool getDataWithInterface:@"rzq.news.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                NSMutableArray *daA = [NSMutableArray array];
                if (list.count>0) {
                    for (NSDictionary *dd in list) {
                        NSString *tit = [dd valueForKey:[NSString stringWithFormat:@"title_%@",self->lan_str]];
                        if (kStringIsEmpty(tit)) {
                            tit = @"";
                        }
                        
                        [daA addObject:tit];
                    }
                    [weakSelf.advertV setTitles:daA];
                    weakSelf.ggDataArray = list;
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

-(void)gethyxxData
{
    kWeakSelf;
     TParms;
    [parms setValue:@"xwgg" forKey:@"code"];
    [parms setValue:@"5" forKey:@"pagesize"];
    [parms setValue:@"1" forKey:@"pageindex"];
    [NetTool getDataWithInterface:@"rzq.news.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                if (list.count>0) {
                    weakSelf.hyDataArray = list;
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
    return _hyDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _hyDataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    UIView *vv = [cell.contentView viewWithTag:120];
    UILabel *l1 = [vv viewWithTag:10];
    UILabel *l2 = [vv viewWithTag:11];
    UILabel *l3 = [vv viewWithTag:13];
    UIImageView *img = [vv viewWithTag:12];
    [img cornerRadius:3];
    NSString *tit = [dic valueForKey:[NSString stringWithFormat:@"title_%@",lan_str]];
    if (kStringIsEmpty(tit)) {
        tit = @"";
    }
    l1.text = tit;
    NSString *dt = [dic valueForKey:@"createtime"];
    dt = [dt stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    l2.text = [dt substringToIndex:10];
    NSString *url = [dic valueForKey:[NSString stringWithFormat:@"picurl_%@",lan_str]];
    if (kStringIsEmpty(url)) {
        url = @"";
    }
    NSString *zai = [dic valueForKey:[NSString stringWithFormat:@"abstract_%@",lan_str]];
    if (kStringIsEmpty(zai)) {
        zai = @"";
    }
    l3.text = zai;
    [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:TPlaceIMg];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _hyDataArray[indexPath.row];
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


- (IBAction)itemBtnClick:(UIButton *)sender {

    NSArray *vcA = @[@"SLZLVC",@"XMGKVC"];
    BaseViewController *vc = [JCTool getViewControllerWithID:vcA[sender.tag-10]];
    [self.navigationController pushViewController:vc animated:1];

}



@end
