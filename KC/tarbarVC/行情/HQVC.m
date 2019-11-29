//
//  HQVC.m
//  KC
//
//  Created by jian on 2019/11/12.
//  Copyright © 2019 jian. All rights reserved.
//

#import "HQVC.h"

@interface HQVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *hqDataArray;
@property (weak, nonatomic) IBOutlet UIView *SXView;

@property(nonatomic,assign)NSInteger types;
@end

@implementation HQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _hqDataArray = [NSMutableArray array];
    KAddNoti(@selector(getHangQingList), @"reloadHQ");
    _types = 1;
   NSArray * tAA = @[@"币种",@"最新价",@"涨幅度"];
    for (UIButton *btn in _SXView.subviews) {
        [btn setTitle:TLOCAL(tAA[btn.tag-1]) forState:(UIControlStateNormal)];
        [btn layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleRight) imageTitleSpace:3];
    }
    [self getHangQingList];
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
                    [weakSelf sortPrice];
                }
            }
                break;
            default:
                 break;
        }
    } failure:^(NSError *error) {
       
    }];
}

- (IBAction)sxbtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            sender.selected = !sender.selected;
            _types = sender.selected?2:1;
            [sender setImage:sender.selected?TimageName(@"home_saixuan"):TimageName(@"home_saixuanf") forState:(UIControlStateNormal)];
        }
            break;
        case 2:
        {
            sender.selected = !sender.selected;
            _types = sender.selected?4:3;
            [sender setImage:sender.selected?TimageName(@"home_saixuan"):TimageName(@"home_saixuanf") forState:(UIControlStateNormal)];
            
        }
            break;
        case 3:
        {
            sender.selected = !sender.selected;
            _types = sender.selected?6:5;
            [sender setImage:sender.selected?TimageName(@"home_saixuan"):TimageName(@"home_saixuanf") forState:(UIControlStateNormal)];
        }
            break;
        default:
            break;
    }
    [self sortPrice];
    
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

-(void)sortPrice
{
    switch (_types) {
        case 1:
        case 2:
        {
            
            [_hqDataArray sortUsingComparator:^NSComparisonResult(CoinModel  * obj1, CoinModel  * obj2) {
                if (_types==2) {
                    return [obj1.coinname compare:obj2.coinname options:(NSNumericSearch)];
                }else
                {
                    return [obj2.coinname compare:obj1.coinname options:(NSNumericSearch)];
                }
            }];
            [_tableView reloadData];
        }
            break;
        case 3:
        case 4:
        {
            
            [_hqDataArray sortUsingComparator:^NSComparisonResult(CoinModel  * obj1, CoinModel  * obj2) {
                if (_types==4) {
                    return [[NSNumber numberWithDouble:obj2.price] compare:[NSNumber numberWithDouble:obj1.price]];
                }else
                {
                    return [[NSNumber numberWithDouble:obj1.price] compare:[NSNumber numberWithDouble:obj2.price]];
                }
            }];
            [_tableView reloadData];
        }
            break;
        case 5:
        case 6:
        {
            [_hqDataArray sortUsingComparator:^NSComparisonResult(CoinModel  * obj1, CoinModel  * obj2) {
                CGFloat pct1 = (obj1.price - obj1.open)/obj1.open;
                CGFloat pct2 = (obj2.price - obj2.open)/obj2.open;
                if (_types==6) {
                    
                    return [[NSNumber numberWithDouble:pct2] compare:[NSNumber numberWithDouble:pct1]];
                }else
                {
                    return [[NSNumber numberWithDouble:pct1] compare:[NSNumber numberWithDouble:pct2]];
                }
            }];
            [_tableView reloadData];
        }
            break;
        default:
            break;
    }
}
@end
