//
//  VerificationVC.m
//  RZQRose
//
//  Created by jian on 2019/8/13.
//  Copyright © 2019 jian. All rights reserved.
//

#import "ChangePEVC.h"

@interface ChangePEVC ()

@property (weak, nonatomic) IBOutlet UITextField *inputF1;
@property (weak, nonatomic) IBOutlet UITextField *inputF2;
@property (weak, nonatomic) IBOutlet UILabel *titleL;


@end

@implementation ChangePEVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.customNavBar.title = TLOCAL(@"修改手机");
    if (!_isPhone) {
        _inputF1.placeholder = TLOCAL(@"请输入新的邮箱");
        self.customNavBar.title = TLOCAL(@"修改邮箱");
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}

-(IBAction)backPage
{
    [self.navigationController popViewControllerAnimated:1];
}

-(IBAction)btnClick:(UIButton *)sender
{
    [self.view endEditing:1];
    if (![self.inputF1.text isPhoneNumber]&&_isPhone) {
        TShowMessage(@"请输入正确的手机号");
        return;
    }
    if (![self.inputF1.text isEmail]&&!_isPhone) {
        TShowMessage(@"请输入正确的邮箱");
        return;
    }
    if (_inputF2.text.length!=6)
    {
        TShowMessage(@"验证码不正确");
        return;
    }
    kWeakSelf;
    TParms;
    if (_isPhone) {
        [parms setValue:_inputF1.text forKey:@"mobile"];
    }else
    {
      [parms setValue:_inputF1.text forKey:@"mail"];
    }
    [parms setValue:_inputF2.text forKey:@"code"];
    [NetTool getDataWithInterface:@"rzq.user.update_m" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                TShowMessage(@"修改成功！");
                if (weakSelf.isPhone) {
                    [JCTool share].user.mobile = weakSelf.inputF1.text;
                }else
                {
                  [JCTool share].user.mail = weakSelf.inputF1.text;
                }
                [weakSelf backPage];
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

- (IBAction)sendMarkClick:(UIButton *)sender {
    if (![self.inputF1.text isPhoneNumber]&&_isPhone) {
        TShowMessage(@"请输入正确的手机号");
        return;
    }
    if (![self.inputF1.text isEmail]&&!_isPhone) {
        TShowMessage(@"请输入正确的邮箱");
        return;
    }
    
    if (sender.selected) {
        return;
    }
    sender.selected = !sender.selected;
    NSString *types = _isPhone?@"3":@"2";
    kWeakSelf;
    TParms;
    [parms setValue:_inputF1.text forKey:@"acount"];
    [parms setValue:types forKey:@"type"];//1注册，2绑定邮箱，3绑定手机号，4找回密码,5找回/重置交易密码
    [NetTool getDataWithInterface:@"rzq.user.sendcode" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                TShowResMsg;
                [weakSelf btnTime:sender];
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

-(void)btnTime:(UIButton *)btn
{
   __block int count = 60;
   [SocketTool share].loadingBlock = ^{
       static int a = 0;
       a++;
       if (a%10==0) {
           count --;
           if (count<=0) {
               btn.selected = 0;
               [btn setTitle:TLOCAL(@"获取验证码") forState:(UIControlStateNormal)];
           }else
           {
               [btn setTitle:[NSString stringWithFormat:@"%02dS",count] forState:(UIControlStateNormal)];
           }
           
       }
   };
}

@end
