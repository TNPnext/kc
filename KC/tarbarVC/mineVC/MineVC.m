//
//  MineVC.m
//  RZQRose
//
//  Created by jian on 2019/8/14.
//  Copyright © 2019 jian. All rights reserved.
//

#import "MineVC.h"
#import "MySYVC.h"
@interface MineVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
@property (weak, nonatomic) IBOutlet UILabel *invL;
@property (weak, nonatomic) IBOutlet UIView *infoV;
@property (weak, nonatomic) IBOutlet UILabel *allgetL;

@property(nonatomic,assign)CGFloat abtotal;
@property(nonatomic,assign)CGFloat invitetotal;
@property(nonatomic,assign)CGFloat jttotal;
@property(nonatomic,assign)CGFloat stotal;
@property(nonatomic,assign)CGFloat total;
@property (weak, nonatomic) IBOutlet UILabel *wkL;
@property (weak, nonatomic) IBOutlet UILabel *jdL;
@property (weak, nonatomic) IBOutlet UILabel *sqL;
@property (weak, nonatomic) IBOutlet UIView *btnV;


@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [JCTool querybalance];
   // KAddNoti(@selector(reloadUI), KMMChange);
    [_infoV addTapGestureWithTarget:self selector:@selector(infoClick)];
    
    [self initViews];
    [self initData];
    
    [self getAllSY];
}

- (IBAction)goWalletHome:(UIButton *)sender {
    MySYVC *VC = [JCTool getViewControllerWithID:@"MySYVC"];
    VC.abtotal = _abtotal;
    VC.total = _total;
    VC.invitetotal = _invitetotal;
    VC.stotal = _stotal;
    VC.jttotal = _jttotal;
    [self.navigationController pushViewController:VC animated:1];
    
}



-(void)getAllSY
{
    TParms;
    kWeakSelf;
    [NetTool getDataWithInterface:@"rzq.tradecredittotal.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                if (list.count>0) {
                    NSDictionary *redic = [list firstObject];
                     weakSelf.abtotal = [[redic valueForKey:@"abtotal"] doubleValue];
                    weakSelf.invitetotal = [[redic valueForKey:@"invitetotal"] doubleValue];
                    weakSelf.jttotal = [[redic valueForKey:@"jttotal"] doubleValue];
                    weakSelf.stotal = [[redic valueForKey:@"stotal"] doubleValue];
                    CGFloat count = weakSelf.abtotal+weakSelf.invitetotal+weakSelf.jttotal+weakSelf.stotal;
                    weakSelf.total = count;
                    weakSelf.wkL.text = [JCTool removeZero:weakSelf.jttotal];
                    weakSelf.jdL.text = [JCTool removeZero:weakSelf.abtotal];
                    weakSelf.sqL.text = [JCTool removeZero:weakSelf.stotal];
                    weakSelf.allgetL.text = [JCTool removeZero:count];
                }
            }
                break;
                
            default:
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)infoClick
{
    UIViewController *vc = [JCTool getViewControllerWithID:@"UserInfoVC" name:@"Login"];
    [self.navigationController pushViewController:vc animated:1];
}

-(void)initViews
{
    TInitArray;
    _dataArray = @[@"疑问解答",@"分享链接",@"语言设置",@"安全设置",@"关于我们",@"退出"].mutableCopy;
    NSArray *ttA = @[@"社区矿机",@"我的矿机",@"购买记录"];
    for (UIButton *btn in _btnV.subviews) {
        [btn setTitle:TLOCAL(ttA[btn.tag-10]) forState:(UIControlStateNormal)];
        [btn layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleTop) imageTitleSpace:10];
    }
    _invL.text = [NSString stringWithFormat:@"UID:%@",[JCTool share].user.mycode];
    [_levelBtn setTitle:[NSString stringWithFormat:@"M%d",[JCTool share].user.userlevel] forState:(UIControlStateNormal)];
    if ([JCTool share].user.userlevel>7) {
        [_levelBtn setTitle:@"MX" forState:(UIControlStateNormal)];
    }
    
   
}

-(void)initData
{
    
    TParms;
    //kWeakSelf;
    [NetTool getDataWithInterface:@"rzq.user.coin" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *arr = [dic valueForKey:@"List"];
                NSArray *dataA = [MoneyModel mj_objectArrayWithKeyValuesArray:arr];
                for (MoneyModel *mm in dataA) {
                    if ([mm.coinid intValue]==1) {
                        [JCTool share].money = mm;
                        break;
                    }
                }
                
            }
                break;
                
            default:
            
                break;
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (IBAction)shouyiClick:(UIButton *)sender
{
    
    NSArray *vcA = @[@"SXSLVC",@"MyPrductVC",@"MyYYReVC"];
    UIViewController *VC = [JCTool getViewControllerWithID:vcA[sender.tag-10]];
    [self.navigationController pushViewController:VC animated:1];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    UIView *bg = [cell.contentView viewWithTag:100];
    UILabel *l1 = [bg viewWithTag:10];
    UILabel *l2 = [bg viewWithTag:11];
    l1.text = TLOCAL(_dataArray[indexPath.row]);
    l2.hidden = 1;
    UIImageView *icon = [bg viewWithTag:15];
    NSArray *imgA = @[@"me_item6",@"me_item5",@"me_item3",@"me_item2",@"me_item1",@"me_item4"];
    icon.image = TimageName(imgA[indexPath.row]);
    if (indexPath.row==2) {
        l2.hidden = 0;
        NSDictionary *ld = KOutObj(Klanguage);
        l2.text = [ld valueForKey:@"name"];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==5) {
        [JCTool goLoginPage];
        return;
    }
    NSArray *vcs = @[@"SugReVC",@"ShareVC",@"LanguageVC",@"SettingVC",@"AboutVC",@""];
    ChangePWVC *vc = [JCTool getViewControllerWithID:vcs[indexPath.row] name:@"Login"];
    vc.t_tilte = TLOCAL(_dataArray[indexPath.row]);
    [self.navigationController pushViewController:vc animated:1];
}



@end
