//
//  HChongVC.m
//  RZQRose
//
//  Created by jian on 2019/8/15.
//  Copyright © 2019 jian. All rights reserved.
//

#import "HChongVC.h"

@interface HChongVC ()
{
    MoneyModel *_sModel;
}

@property (weak, nonatomic) IBOutlet UIImageView *codeImg;
@property (weak, nonatomic) IBOutlet UILabel *addresL;

@end

@implementation HChongVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    KAddNoti(@selector(reloadData), KMMChange);
    self.customNavBar.title = TLOCAL(@"转入");
    [self reloadView];
   
    
    
    
    
}


- (IBAction)tapClick:(id)sender {
    
    [UIPasteboard generalPasteboard].string = [JCTool share].money.address;
    TAlertShow(@"地址已复制到粘贴板");
}



-(void)reloadView
{
    _codeImg.image = [UIImage qrImageForString:[JCTool share].money.address imageSize:_codeImg.width];
    _addresL.text = [JCTool share].money.address;
    
    
}



@end
