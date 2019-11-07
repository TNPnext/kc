//
//  WalletReVC.m
//  OBS
//
//  Created by jian on 2019/9/17.
//  Copyright © 2019 jian. All rights reserved.
//

#import "WalletReVC.h"

@interface WalletReVC ()

@property (weak, nonatomic) IBOutlet UIView *segV;
@property (weak, nonatomic) IBOutlet UIView *segV2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *emptyV;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (strong, nonatomic)NSMutableArray *dataArray2;
@property (strong, nonatomic)NSMutableArray *dataArray3;
@property (assign, nonatomic)NSInteger segIndex;


@end

@implementation WalletReVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = TLOCAL(@"账单");
    if ([_coinid intValue]==1) {
        _segV2.hidden = 0;
    }
    TInitArray;
    _dataArray2 = [NSMutableArray array];
    _dataArray3 = [NSMutableArray array];
    _segIndex = 0;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self getData];
    
}

-(void)getData
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_segIndex==1) {
        return _dataArray2.count;
    }
    if (_segIndex==2) {
        return _dataArray3.count;
    }
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 140;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(IBAction)btnClick:(UIButton *)sender
{
    _segIndex = sender.tag-10;
    UIView *fuV = _segV;
    if ([_coinid intValue]==1) {
        fuV = _segV2;
    }
    for (UIButton *btn in fuV.subviews)
    {
        if (btn.tag>9) {
            if (btn.tag == sender.tag) {
                [btn setBackgroundImage:TimageName(@"lun_top_s") forState:(UIControlStateNormal)];
                [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                
            }else
            {
                [btn setBackgroundImage:TimageName(@"lun_top_n") forState:(UIControlStateNormal)];
                [btn setTitleColor:ColorWithHex(@"#6D7DFE") forState:(UIControlStateNormal)];
            }
        }
    }
    [self getData];
    
}
@end
