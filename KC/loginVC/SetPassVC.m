//
//  SetPassVC.m
//  OBS
//
//  Created by jian on 2019/9/16.
//  Copyright © 2019 jian. All rights reserved.
//

#import "SetPassVC.h"

@interface SetPassVC ()
@property (weak, nonatomic) IBOutlet UITextField *inputF1;
@property (weak, nonatomic) IBOutlet UITextField *inputF2;
@property (weak, nonatomic) IBOutlet UIView *succesV;
@end

@implementation SetPassVC

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = TLOCAL(@"设置交易密码");
    kWeakSelf;
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf backPage];
    };
}


- (IBAction)btnClick:(UIButton *)sender {
    
     if(![_inputF1.text isPassWord])
    {
        TShowMessage(@"密码格式为6-16位数字或字母组合");
        return;
    }
     if(![_inputF1.text isEqualToString:_inputF2.text])
    {
        TShowMessage(@"两次输入的密码不一致");
        return;
    }
    kWeakSelf;
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    NSString *shapass = [NSString stringWithFormat:@"%@:%@",[JCTool share].user.mycode,_inputF1.text];
    [parm setValue:[shapass sha256String] forKey:@"paypassword"];
    
    [NetTool getDataWithInterface:@"rzq.paypwd.set" Parameters:parm success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSMutableDictionary *dd = [[JCTool getJsonWithPath:Kimportant] mutableCopy];
                [dd setValue:@"1" forKey:@"transcodeseted"];
                [JCTool saveJsonWithData:dd path:Kimportant];
                [JCTool share].user.transcodeseted = 1;
                TShowMessage(@"交易密码设置成功");
                [weakSelf dismissViewControllerAnimated:1 completion:nil];
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

-(IBAction)backPage
{
    [self dismissViewControllerAnimated:1 completion:nil];
}


@end
