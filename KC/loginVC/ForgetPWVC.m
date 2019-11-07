//
//  ForgetPWVC.m
//  RZQRose
//
//  Created by jian on 2019/8/12.
//  Copyright © 2019 jian. All rights reserved.
//

#import "ForgetPWVC.h"

@interface ForgetPWVC ()

@property (weak, nonatomic) IBOutlet UITextField *inputF1;
@property (weak, nonatomic) IBOutlet UITextField *inputF2;
@property (weak, nonatomic) IBOutlet UITextField *inputF3;
@property (weak, nonatomic) IBOutlet UITextField *inputF4;

@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;
@property (nonatomic,assign)BOOL isEmail;
@property(nonatomic,copy)NSString *mycode;

@property (weak, nonatomic) IBOutlet UIView *succesV;

@end

@implementation ForgetPWVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.customNavBar.title = TLOCAL(@"找回密码");
    _isEmail = 0;
    if ([JCTool isLogin]) {
        _inputF1.userInteractionEnabled = 0;
        if ([JCTool share].user.mobile.length>0) {
            _inputF1.text = [JCTool share].user.mobile;
        }
    }
}



- (IBAction)nextBtnClick:(UIButton *)sender
{
    if (![self.inputF1.text isPhoneNumber]&&![self.inputF1.text isEmail]) {
        TShowMessage(@"请输入正确的手机号或邮箱");
        return;
    }
    if (_inputF2.text.length!=6)
    {
        TShowMessage(@"验证码不正确");
        return;
    }
    if (![_inputF3.text isPassWord])
    {
        TShowMessage(@"密码6-16字母或数字组合");
        return;
    }
    if (![_inputF3.text isEqualToString:_inputF4.text])
    {
        TShowMessage(@"两次输入的密码不一致");
        return;
    }
    //登录找回交易或密码
    if ([JCTool isLogin]) {
        _mycode = [JCTool share].user.mycode;
        [self findRequset];
        return;
    }
    //未登录找回
    [self getMycodeRequest];
}

-(void)getMycodeRequest
{
    TParms;
    kWeakSelf;
    [parms setValue:_inputF1.text forKey:@"username"];
    [NetTool getDataWithInterface:@"rzq.user.chick" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                weakSelf.mycode = [dic valueForKey:@"mycode"];
                [weakSelf findRequset];
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

-(void)findRequset
{
    kWeakSelf;
    TParms;
    NSString *shapass = [NSString stringWithFormat:@"%@:%@",_mycode,_inputF3.text];
    [parms setValue:_inputF1.text forKey:@"username"];
    
    [parms setValue:_inputF2.text forKey:@"code"];
    NSString *interf = @"rzq.user.backpwd";
    if (_isPay) {
        interf = @"rzq.paypwd.back";
        [parms setValue:[shapass sha256String] forKey:@"paypassword"];
    }else
    {
        [parms setValue:[shapass sha256String] forKey:@"newpassword"];
    }
    //
    [NetTool getDataWithInterface:interf Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                weakSelf.succesV.hidden = 0;
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

- (IBAction)succesClick:(UIButton *)sender {
    if ([JCTool isLogin]) {
        if (_isPay) {
            [self.navigationController popToRootViewControllerAnimated:1];
        }else
        {
            [JCTool goLoginPage];
        }
    }else
    {
        [self backPage];
    }
    
}


-(IBAction)backPage
{
    [self.navigationController popViewControllerAnimated:1];
}

- (IBAction)segBtnClick:(UIButton *)sender {
    _phoneBtn.hidden = sender.tag==10?0:1;
    _emailBtn.hidden = sender.tag==10?1:0;
    _isEmail = sender.tag==10?0:1;
    NSString *placeS = TLOCAL(@"请输入手机号");
    if (sender.tag!=10) {
        placeS = TLOCAL(@"请输入邮箱号");
    }
    _inputF1.placeholder = placeS;
    if ([JCTool isLogin]) {
        _inputF1.userInteractionEnabled = 0;
        if (_isEmail &&[JCTool share].user.mail.length>0) {
            _inputF1.text = [JCTool share].user.mail;
        }else
        {
            _inputF1.text = [JCTool share].user.mobile;
        }
    }
    
    
}

- (IBAction)getcodeClick:(UIButton *)sender {
    
    
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
    NSString *type = @"4";
    if ([JCTool isLogin]) {
        type = @"5";
    }
    [parms setValue:type forKey:@"type"];//1注册，2绑定邮箱，3绑定手机号，4找回密码,5找回/重置交易密码
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
