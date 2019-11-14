//
//  XMGKVC.m
//  KC
//
//  Created by jian on 2019/10/31.
//  Copyright © 2019 jian. All rights reserved.
//

#import "XMGKVC.h"
#import "FUWUVC.h"
@interface XMGKVC ()<UIScrollViewDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;




@end

@implementation XMGKVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    self.customNavBar.title = TLOCAL(@"项目概况");
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}




- (IBAction)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:
        {
           UIViewController *vc = [JCTool getViewControllerWithID:@"WHATVC"];
            [self.navigationController pushViewController:vc animated:1];
        }
            break;
        case 11:
        {
            FUWUVC *vc = [JCTool getViewControllerWithID:@"FUWUVC"];
            vc.isYS = 1;
            [self.navigationController pushViewController:vc animated:1];
        }
            break;
        case 12:
        {
            UIViewController *vc = [JCTool getViewControllerWithID:@"FUWUVC"];
            [self.navigationController pushViewController:vc animated:1];
        }
            break;
        case 13:
        {
            UIViewController *vc = [JCTool getViewControllerWithID:@"FZLXVC"];
            [self.navigationController pushViewController:vc animated:1];
        }
            break;
        case 14:
        {
            //官网
            WebViewController *webV = [WebViewController new];
            
            webV.t_tilte = TLOCAL(@"基金会官网");
            NSDictionary *dic = [[JCTool share].configDic valueForKey:@"501"];
            webV.reqUrl = [dic valueForKey:@"val"];
            
            [self.navigationController pushViewController:webV animated:1];
        }
            break;
        default:
            break;
    }
    
}


@end
