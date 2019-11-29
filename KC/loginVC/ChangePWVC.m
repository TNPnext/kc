//
//  ChangePWVC.m
//  RZQRose
//
//  Created by jian on 2019/8/12.
//  Copyright © 2019 jian. All rights reserved.
//

#import "ChangePWVC.h"

@interface ChangePWVC ()

@property (weak, nonatomic) IBOutlet UITextField *inputF1;
@property (weak, nonatomic) IBOutlet UITextField *inputF2;
@property (weak, nonatomic) IBOutlet UITextField *inputF3;
@property (weak, nonatomic) IBOutlet UIView *showSuccesV;


@end

@implementation ChangePWVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.customNavBar.title = TLOCAL(@"修改密码");
    
}

- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:1];
}

- (IBAction)nextBtnClick:(UIButton *)sender
{
    [self panduan];
}

-(void)panduan
{
    if (![_inputF1.text isPassWord]) {
        TShowMessage(@"原密码格式不正确");
        return;
    }
    if (![_inputF2.text isPassWord]) {
        TShowMessage(@"新密码格式为6-16位数字或字母组合");
        return;
    }
    if (![_inputF2.text isEqualToString:_inputF3.text])
    {
        TShowMessage(@"两次输入的密码不一致");
        return;
    }
    [self requestUp];
}

-(void)requestUp
{
    TParms;
    kWeakSelf;
    NSString *shapass = [NSString stringWithFormat:@"%@:%@",[JCTool share].user.mycode,_inputF1.text];
    NSString *shapass1 = [NSString stringWithFormat:@"%@:%@",[JCTool share].user.mycode,_inputF2.text];
    
    
    NSString *interf = @"rzq.user.updatepwd";
    if (_isPay)
    {
        interf = @"rzq.paypwd.update";
        [parms setValue:[shapass sha256String] forKey:@"oldpaypassword"];
        [parms setValue:[shapass1 sha256String] forKey:@"paypassword"];
    }else
    {
        [parms setValue:[shapass1 sha256String] forKey:@"newpassword"];
       [parms setValue:[shapass sha256String] forKey:@"oldpassword"];
    }
    [NetTool getDataWithInterface:interf Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                weakSelf.showSuccesV.hidden = 0;
            }
                break;
                
            default:
                TShowResMsg;
                break;
        }
    } failure:^(NSError *error) {
        TShowNetError;
    }];
}


- (IBAction)showBtnClick:(UIButton *)sender {
    
    if (self.isPay)
    {
        [self.navigationController popToRootViewControllerAnimated:1];
        return;
    }
    [JCTool goLoginPage];
    
}



- (IBAction)forgetBtnClick:(id)sender {
    
    ForgetPWVC *vc = [JCTool getViewControllerWithID:@"ForgetPWVC" name:@"Login"];
    if (_isPay) {
        vc.isPay = 1;
    }
    [self.navigationController pushViewController:vc animated:1];
}


@end
