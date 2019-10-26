//
//  RegistVC.m
//  RZQRose
//
//  Created by jian on 2019/8/12.
//  Copyright © 2019 jian. All rights reserved.
//

#import "RegistVC.h"
#import "Header.h"
@interface RegistVC ()


@property (weak, nonatomic) IBOutlet UITextField *inputF1;
@property (weak, nonatomic) IBOutlet UITextField *inputF2;
@property (weak, nonatomic) IBOutlet UITextField *inputF3;
@property (weak, nonatomic) IBOutlet UITextField *inputF4;
@property (weak, nonatomic) IBOutlet UITextField *inputF5;



@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
#ifdef DEBUG
    _inputF1.text = @"18983387045";
    _inputF4.text = @"p5pggs";
#endif
    
   
}

-(void)initViews
{
    self.customNavBar.title = TLOCAL(@"注册");
    [self.customNavBar setTitleLabelColor:[UIColor whiteColor]];
    [self.customNavBar wr_setLeftButtonWithImage:TimageName(@"back_white")];
}



- (IBAction)nextBtnClick:(UIButton *)sender
{
    [self regisUP];
}

-(IBAction)backBtnClick
{
    [self.navigationController popViewControllerAnimated:1];
}



-(void)regisUP
{

    
    if (![self.inputF1.text isPhoneNumber]&&![self.inputF1.text isEmail]) {
        TShowMessage(@"请输入正确的手机号或邮箱");
        return;
    }
    if (_inputF4.text.length!=6)
    {
        TShowMessage(@"验证码不正确");
        return;
    }
    if (![_inputF2.text isPassWord])
    {
        TShowMessage(@"密码6-16字母或数字组合");
        return;
    }
    if (![_inputF2.text isEqualToString:_inputF3.text])
    {
        TShowMessage(@"两次输入的密码不一致");
        return;
    }
    if (_inputF4.text.length<1)
    {
        TShowMessage(@"邀请码不正确");
        return;
    }
    kWeakSelf;
    TParms;
    [parms setValue:_inputF1.text forKey:@"username"];
    [parms setValue:_inputF2.text forKey:@"password"];
    [parms setValue:_inputF4.text forKey:@"invcode"];
    [parms setValue:_inputF5.text forKey:@"code"];
    [NetTool getDataWithInterface:@"rzq.user.signup" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode)
        {
            case 1:
            {
                TShowMessage(@"注册成功!");
                [weakSelf backBtnClick];
                
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

- (IBAction)scanClick:(UIButton *)sender {
    
    
    if (![self.inputF1.text isPhoneNumber]&&![self.inputF1.text isEmail]) {
        TShowMessage(@"请输入正确的手机号或邮箱");
        return;
    }
    if (sender.selected) {
        return;
    }
    sender.selected = !sender.selected;
    kWeakSelf;
    TParms;
    [parms setValue:_inputF1.text forKey:@"acount"];
    [parms setValue:@"1" forKey:@"type"];//1注册，2绑定邮箱，3绑定手机号，4找回密码,5找回/重置交易密码
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
