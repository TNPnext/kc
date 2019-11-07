//
//  LoginVC.m
//  RZQRose
//
//  Created by jian on 2019/8/12.
//  Copyright © 2019 jian. All rights reserved.
//

#import "LoginVC.h"
#import "Header.h"
@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *inputF1;
@property (weak, nonatomic) IBOutlet UITextField *inputF2;
@property(nonatomic,copy)NSString *mycode;
@end

@implementation LoginVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    
#ifdef DEBUG
//    _inputF1.text = @"1402436508@qq.com";
//    _inputF2.text = @"123456";
    _inputF1.text = @"18983387045";
    _inputF2.text = @"pppppp";
#endif
    
}

-(void)initViews
{
    self.customNavBar.hidden =  1;
    [_rightBtn layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleRight) imageTitleSpace:5];
    NSString *user = KOutObj(@"Tuser");
    if (user) {
        _inputF1.text = user;
    }
    
    NSDictionary *ld = KOutObj(Klanguage);
    [_rightBtn setTitle:[ld valueForKey:@"name"] forState:(UIControlStateNormal)];
    
    
}

-(IBAction)btnClick:(UIButton *)sender
{
    [self.view endEditing:1];
    if (sender.tag==100)
    {
        UIViewController *vc = [JCTool getViewControllerWithID:@"LanguageVC" name:@"Login"];
        [self.navigationController pushViewController:vc animated:1];
        return;
    }
    if (![self.inputF1.text isPhoneNumber]&&![self.inputF1.text isEmail]) {
        TShowMessage(@"请输入正确的手机号或邮箱");
        return;
    }
    if (![_inputF2.text isPassWord])
    {
        TShowMessage(@"密码格式不正确");
        return;
    }
    
    [self getMycodeRequest];
    
}

-(void)getMycodeRequest
{
     [SVProgressHUD showWithStatus:TLOCAL(@"登录中...")];
    TParms;
    kWeakSelf;
    [parms setValue:_inputF1.text forKey:@"username"];
    [NetTool getDataWithInterface:@"rzq.user.chick" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                weakSelf.mycode = [dic valueForKey:@"mycode"];
                [weakSelf loginRequest];
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

-(void)loginRequest
{
    TParms;
    NSString *shapass = [NSString stringWithFormat:@"%@:%@",_mycode,_inputF2.text];
    [parms setValue:_inputF1.text forKey:@"username"];
    [parms setValue:[shapass sha256String] forKey:@"password"];
    
    [NetTool getDataWithInterface:@"rzq.user.login" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
               NSDictionary *dd = [responseObject valueForKey:@"data"];
               UserModel *user = [UserModel mj_objectWithKeyValues:dd];
               user.login_uid = [JCTool share].login_uid;
               [JCTool share].user = user;
               NSMutableDictionary *impDic = [[NSMutableDictionary alloc]initWithDictionary:dd];
               [impDic setValue:user.login_uid forKey:@"login_uid"];
               [JCTool saveJsonWithData:impDic path:Kimportant];
               KSaveObj(user.username, @"Tuser");
               TShowMessage(@"登录成功!");
               [JCTool goHomePage];
                
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

//查询用户信息
-(void)getUserInfo:(NSString *)token username:(NSString *)usern
{
    [JCTool saveJsonWithData:token path:@"token"];
    NSDate *detailDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    TParms;
    [parms setValue:usern forKey:@"username"];
    [parms setValue:[SecurityUtil encryptAESData:currentDateStr Key:token] forKey:@"parm"];
    [parms setValue:[JCTool getLanguage] forKey:@"locale"];
    [parms setValue:@"2" forKey:@"platform"];
    [NetTool getDataWithInterface:@"/api/queryuserinfo" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSArray *arr = [[responseObject valueForKey:@"data"] mj_JSONObject];
                if (arr.count>0)
                {
                    NSDictionary *dd = arr[0];
                    UserModel *user = [UserModel mj_objectWithKeyValues:dd];
                    user.username = usern;
                    [JCTool share].user = user;
                    
                    NSMutableDictionary *impDic = [[NSMutableDictionary alloc]initWithDictionary:dd];
                    [impDic setValue:usern forKey:@"username"];
                    [JCTool saveJsonWithData:impDic path:Kimportant];
                    KSaveObj(usern, @"Tuser");
                    TShowMessage(@"登录成功!");
                    [JCTool goHomePage];
                }else
                {
                    TShowResMsg;
                }
                
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

-(IBAction)backBtnClick
{
    
}

@end
