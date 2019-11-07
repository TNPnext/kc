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
{
    BOOL checkXY;
}

@property (weak, nonatomic) IBOutlet UITextField *inputF1;
@property (weak, nonatomic) IBOutlet UITextField *inputF2;
@property (weak, nonatomic) IBOutlet UITextField *inputF3;
@property (weak, nonatomic) IBOutlet UITextField *inputF4;
@property (weak, nonatomic) IBOutlet UITextField *inputF5;
@property (weak, nonatomic) IBOutlet UIButton*seBtn;
@property (nonatomic,strong) NSDictionary *xieyiDic;

@end

@implementation RegistVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    [self getzlxy];
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

-(void)getzlxy
{
    TParms;
    kWeakSelf;
    [parms setValue:@"zcxy" forKey:@"code"];
    [NetTool getDataWithInterface:@"rzq.news.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                weakSelf.xieyiDic = [list firstObject];
                
            }
                break;
            default:
            {
            }
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}



- (IBAction)nextBtnClick:(UIButton *)sender
{
    [self regisUP];
}

-(IBAction)backBtnClick
{
    [self.navigationController popViewControllerAnimated:1];
}

- (IBAction)xieyiClick:(UIButton *)sender {
    //xuanzhong_yes
    switch (sender.tag) {
        case 10:
        {
            sender.selected = !sender.selected;
            checkXY = sender.selected;
            if (sender.selected) {
                [_seBtn setImage:TimageName(@"xuanzhong_yes") forState:(UIControlStateNormal)];
            }else
            {
                [_seBtn setImage:TimageName(@"xuanzhong_no") forState:(UIControlStateNormal)];
            }
        }
        break;
        case 11:
        {
           WebViewController *web = [WebViewController new];
            NSDictionary *dic = self.xieyiDic;
           NSString *url = [dic valueForKey:[NSString stringWithFormat:@"linkurl_%@",[JCTool getCurrLan]]];
            if (kStringIsEmpty(url)) {
                url = @"";
            }
            web.reqUrl = url;
            web.t_tilte = TLOCAL(@"注册协议");
            [self.navigationController pushViewController:web animated:1];
        }
        break;
        default:
            break;
    }
    
    
}


-(void)regisUP
{
    if (!checkXY) {
        TShowMessage(@"请先勾选同意注册协议");
        return;
    }
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
