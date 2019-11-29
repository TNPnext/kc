//
//  HelpVC.m
//  OBS
//
//  Created by jian on 2019/9/11.
//  Copyright © 2019 jian. All rights reserved.
//

#import "UserInfoVC.h"
#import "ChangePEVC.h"
@interface UserInfoVC ()
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UILabel *emailL;
@property (weak, nonatomic) IBOutlet UILabel *uidL;
@property (weak, nonatomic) IBOutlet UILabel *userNameL;

@end

@implementation UserInfoVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
    NSString *p1 = TLOCAL(@"未绑定");
    if ([JCTool share].user.mobile>0) {
        p1 = [JCTool share].user.mobile;
        p1 = [NSString stringWithFormat:@"%@****%@",[p1 substringToIndex:3],[p1 substringFromIndex:p1.length-4]];
        
        
    }
    NSString *p2 = TLOCAL(@"未绑定");
    if ([JCTool share].user.mail.length>0) {
        p2 = [JCTool share].user.mail;
    }
    
    _phoneL.text = p1;
    _emailL.text = p2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = TLOCAL(@"个人信息");
    _uidL.text = [JCTool share].user.mycode;
    _userNameL.text = [JCTool share].user.username;
    
    
}





- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:1];
}


- (IBAction)listClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            
        }
            break;
        case 2:
        case 3:
        {
            ChangePEVC *vc = [JCTool getViewControllerWithID:@"ChangePEVC" name:@"Login"];
            vc.isPhone = (sender.tag==2)?1:0;
            [self.navigationController pushViewController:vc animated:1];
        }
            break;
        default:
            break;
    }
    
    
    
}

@end
