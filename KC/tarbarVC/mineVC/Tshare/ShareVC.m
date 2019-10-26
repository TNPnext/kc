//
//  ShareVC.m
//  XHSJ
//
//  Created by jian on 2019/8/28.
//  Copyright © 2019 jian. All rights reserved.
//

#import "ShareVC.h"

@interface ShareVC ()
@property (weak, nonatomic) IBOutlet UILabel *tinvtedL;
@property (weak, nonatomic) IBOutlet UIImageView *codeImg;



@end

@implementation ShareVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

-(void)initViews
{
    self.customNavBar.title = TLOCAL(@"推荐分享");
    NSString *ss = [NSString stringWithFormat:@"https://app.obstoken.io/#/?inv=%@",[JCTool share].user.userid];
    _tinvtedL.text = ss;
    _codeImg.image = [UIImage qrImageForString:ss imageSize:_codeImg.bounds.size.width];
}

- (IBAction)btnClick:(UIButton *)sender {
    NSString *ss = [NSString stringWithFormat:@"https://app.obstoken.io/#/?inv=%@",[JCTool share].user.userid];
    [UIPasteboard generalPasteboard].string = ss;
    TAlertShow(@"邀请链接已复制到粘贴板");
    
}




@end
