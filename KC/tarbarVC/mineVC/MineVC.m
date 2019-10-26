//
//  MineVC.m
//  RZQRose
//
//  Created by jian on 2019/8/14.
//  Copyright © 2019 jian. All rights reserved.
//

#import "MineVC.h"

@interface MineVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIButton *gowalletBtn;
@property (weak, nonatomic) IBOutlet UILabel *walletCountL;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
@property (weak, nonatomic) IBOutlet UILabel *invL;



@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initViews];
    [self initData];
}

-(void)initViews
{
    TInitArray;
    _dataArray = @[@"语言设置",@"安全设置",@"关于我们",@"退出"].mutableCopy;
    [_gowalletBtn layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleRight) imageTitleSpace:5];

    _invL.text = [NSString stringWithFormat:@"UID:%@",[JCTool share].user.userid];
    [_levelBtn setTitle:[NSString stringWithFormat:@"M%d",[JCTool share].user.userlevel] forState:(UIControlStateNormal)];
   
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
                MoneyModel *mm = [MoneyModel mj_objectWithKeyValues:[arr firstObject]];
                [JCTool share].money = mm;
                
            }
                break;
                
            default:
            
                break;
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (IBAction)loginBtnClick:(UIButton *)sender {
    [JCTool goLoginPage];
}


- (IBAction)turnOutBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
        case 11:
        {
            NSArray *vcA = @[@"OutVC",@"HChongVC"];
            UIViewController *VC = [JCTool getViewControllerWithID:vcA[sender.tag-10]];
            [self.navigationController pushViewController:VC animated:1];
        }
            break;
        default:
            break;
    }
    
    
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
    NSArray *imgA = @[@"me_item3",@"me_item2",@"me_item1",@"me_item4"];
    icon.image = TimageName(imgA[indexPath.row]);
    if (indexPath.row==0) {
        l2.hidden = 0;
        NSDictionary *ld = KOutObj(Klanguage);
        l2.text = [ld valueForKey:@"name"];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        [JCTool goLoginPage];
        return;
    }
    NSArray *vcs = @[@"LanguageVC",@"SettingVC",@"AboutVC",@""];
    ChangePWVC *vc = [JCTool getViewControllerWithID:vcs[indexPath.row] name:@"Login"];
    vc.t_tilte = TLOCAL(_dataArray[indexPath.row]);
    [self.navigationController pushViewController:vc animated:1];
}



@end
