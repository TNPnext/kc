//
//  XMGKVC.m
//  KC
//
//  Created by jian on 2019/10/31.
//  Copyright © 2019 jian. All rights reserved.
//

#import "XMGKVC.h"

@interface XMGKVC ()<UIScrollViewDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIWebView *contentV;

@end

@implementation XMGKVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    self.customNavBar.hidden = 1;
    [self.customNavBar setTitleLabelColor:[UIColor whiteColor]];
    [self.customNavBar wr_setLeftButtonWithImage:TimageName(@"back_white")];
    
    [self getxmgk];
    
}

-(void)getxmgk
{
    TParms;
    kWeakSelf;
    [parms setValue:@"xmgk" forKey:@"code"];
    [NetTool getDataWithInterface:@"rzq.news.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSArray *list = [dic valueForKey:@"List"];
                NSDictionary *jianD = [list firstObject];
                
                weakSelf.titleL.text = [jianD valueForKey:[NSString stringWithFormat:@"title_%@",[JCTool getCurrLan]]];
                int idx = [[jianD valueForKey:@"idx"] intValue];
                [weakSelf getcontent:idx];
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

-(void)getcontent:(int)idx
{
    TParms;
    kWeakSelf;
    [parms setValue:[NSString stringWithFormat:@"%d",idx] forKey:@"newsid"];
    [NetTool getDataWithInterface:@"rzq.newsinfo.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                //[dic valueForKey:[NSString stringWithFormat:@"content_%@",[JCTool getCurrLan]]];
                [weakSelf.contentV loadHTMLString:[dic valueForKey:[NSString stringWithFormat:@"content_%@",[JCTool getCurrLan]]] baseURL:nil];
            
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



-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:1];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<=0) {
        [scrollView setContentOffset:CGPointZero animated:0];
    }
}


- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:1];
}


- (IBAction)btnClick:(UIButton *)sender
{
    if (sender.tag==10) {
        //官网
        WebViewController *webV = [WebViewController new];
        
        webV.t_tilte = TLOCAL(@"基金会官网");
        NSDictionary *dic = [[JCTool share].configDic valueForKey:@"501"];
        webV.reqUrl = [dic valueForKey:@"val"];
        
        [self.navigationController pushViewController:webV animated:1];
    }else
    {
        UIViewController *vc = [JCTool getViewControllerWithID:@"SugReVC" name:@"Login"];
        [self.navigationController pushViewController:vc animated:1];
    }
}


@end
