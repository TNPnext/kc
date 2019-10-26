//
//  XibView.m
//  RZQRose
//
//  Created by jian on 2019/5/18.
//  Copyright © 2019 jian. All rights reserved.
//

#import "GeneralView.h"
#import "AdcVC.h"
@implementation GeneralView

@end



@interface HSView()<UITableViewDelegate,UITableViewDataSource>
@property (assign, nonatomic)int isDTC;
@property (assign, nonatomic)int isJTC;
@property (strong, nonatomic)NSMutableDictionary *dic;
@end
@implementation HSView

-(void)awakeFromNib
{
    [super awakeFromNib];
    _tipsL.adjustsFontSizeToFitWidth = 1;
    [self cornerRadius:10];
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    _dic = [NSMutableDictionary dictionary];
    //    int num1 = [[dataDic valueForKey:@"jt"] intValue];
    //    int num2 = [[dataDic valueForKey:@"dt"] intValue];
    [_dic setValue:@[@{@"t":@"取消利息复投",@"code":@"1",@"z":@"注:取消后众筹收益提现,本金进行复投"},@{@"t":@"取消本利复投",@"code":@"3",@"z":@"注:取消后本金和众筹收益提现,不再享受社区奖励"}] forKey:@"静态操作"];
    //    switch (num1)
    //    {
    //        case 0:
    //
    //            //[_dic setValue:@[@{@"t":@"全部复投",@"code":@"0"},@{@"t":@"全部提现",@"code":@"1"}] forKey:@"静态操作"];
    //            break;
    ////        case 2:
    ////            [_dic setValue:@[@{@"t":_model.jtStr,@"code":[NSString stringWithFormat:@"%d",_model.jtopcode],@"able":@"1"}] forKey:@"静态操作"];
    ////            break;
    //        default:
    //            break;
    //    }
    //    switch (num2)
    //    {
    //        case 1:
    //            [_dic setValue:@[@{@"t":@"全部复投",@"code":@"0"},@{@"t":@"全部提现",@"code":@"1"}] forKey:@"动态操作"];
    //            break;
    //        case 2:
    //            [_dic setValue:@[@{@"t":_model.dtStr,@"code":[NSString stringWithFormat:@"%d",_model.dtopcode],@"able":@"1"}] forKey:@"动态操作"];
    //            break;
    //        default:
    //            break;
    //    }
    
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dic.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [_dic allValues];
    NSArray *da = arr[section];
    return da.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    NSArray *arr = [_dic allKeys];
    NSString *key = arr[indexPath.section];
    NSArray *dda = [_dic valueForKey:key];
    NSDictionary *dic = dda[indexPath.row];
    NSString *code = [dic valueForKey:@"code"];
    UILabel *labe = [cell.contentView viewWithTag:10];
    UIImageView *img = [cell.contentView viewWithTag:11];
    UILabel *labe2 = [cell.contentView viewWithTag:12];
    img.image = TimageName(@"xuan_n");
    labe.text = TLOCAL([dic valueForKey:@"t"]);
    labe2.text = TLOCAL([dic valueForKey:@"z"]);
    labe.adjustsFontSizeToFitWidth = 1;
    labe2.adjustsFontSizeToFitWidth = 1;
    labe.textColor = [UIColor whiteColor];
    if ([key isEqualToString:@"静态操作"])
    {
        if ([code intValue]== _model.jtopcode)
        {
            labe.textColor = [JCTool themColor];
            img.image = TimageName(@"xuan_z");
        }
    }else
    {
        if ([code intValue]== _model.dtopcode)
        {
            labe.textColor = [JCTool themColor];
            img.image = TimageName(@"xuan_z");
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [_dic allKeys];
    NSString *key = arr[indexPath.section];
    NSArray *dda = [_dic valueForKey:key];
    NSDictionary *dic = dda[indexPath.row];
    NSString *code = [dic valueForKey:@"code"];
    NSString *able = [dic valueForKey:@"able"];
    if (!able)
    {
        if ([key isEqualToString:@"静态操作"])
        {
            //[self request:code isJT:1];
            self.model.jtopcode = [code intValue];
            _isJTC = 1;
        }else
        {
            //[self request:code isJT:0];
            self.model.dtopcode = [code intValue];
            _isDTC = 1;
        }
        [tableView reloadData];
    }
}

-(void)setModel:(HomeListModel *)model
{
    _model = model;
}

-(IBAction)sureBtnCliclk
{
    NSString *code = @"";
    if (_isDTC)
    {
        code = [NSString stringWithFormat:@"%d",_model.dtopcode];
        [self request:code isJT:0];
    }
    if (_isJTC)
    {
        code = [NSString stringWithFormat:@"%d",_model.jtopcode];
        [self request:code isJT:1];
    }
    //    else
    //    {
    //        code = [NSString stringWithFormat:@"%d",_model.jtopcode];
    //    }
    
}


-(void)request:(NSString *)code isJT:(BOOL)isjt
{
    NSString *iterf = @"/api/setjtopcode";
    if (!isjt) {
        iterf = @"/api/setdtopcode";
    }
    NSString *ss = [NSString stringWithFormat:@"%@,%@,%@",_model.threadid,_model.roundid,code];
    TParms;
    kWeakSelf;
    [parms setValue:TSEC(ss) forKey:@"parm"];
    [parms setValue:[JCTool share].user.username forKey:@"username"];
    [parms setValue:[JCTool getLanguage] forKey:@"locale"];
    [parms setValue:@"2" forKey:@"platform"];
    [NetTool getDataWithInterface:iterf Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                if (weakSelf.isDTC) {
                    weakSelf.isDTC = 0;
                }
                if (weakSelf.isJTC) {
                    weakSelf.isJTC = 0;
                }
                TAlertShow(@"更改成功");
                self.superview.hidden = 1;
                if (weakSelf.reloadDateBlock) {
                    weakSelf.reloadDateBlock();
                }
            }
                break;
            default:
            {
                TAlertShowResMsg;
                self.superview.hidden = 1;
            }
                break;
        }
    } failure:^(NSError *error) {
        TAlertShowNetError;
        self.superview.hidden = 1;
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    NSArray *arr = [_dic allKeys];
//    UILabel *label = [[UILabel alloc]init];
//    label.text = [NSString stringWithFormat:@"    %@",TLOCAL(arr[section])];
//    label.textColor = kTextColor6;
//    label.font = fontSize(15);
//    return label;
//}

@end

