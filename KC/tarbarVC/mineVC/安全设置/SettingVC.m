//
//  SettingVC.m
//  OBS
//
//  Created by jian on 2019/9/11.
//  Copyright © 2019 jian. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableDictionary *dataDic;
@property (strong, nonatomic)NSMutableArray *dataArray;
@end

@implementation SettingVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)btnClick:(UIButton *)sender {
    
    if (sender.tag==1 &&[JCTool share].user.transcodeseted==0) {
        [JCTool settingPass];
        return;
    }
    ChangePWVC *vc = [JCTool getViewControllerWithID:@"ChangePWVC" name:@"Login"];
    vc.isPay = sender.tag;
    [self.navigationController pushViewController:vc animated:1];
}

- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:1];
}




@end
