//
//  TarbarViewController.m
//  RZQRose
//
//  Created by jian on 2019/5/16.
//  Copyright © 2019 jian. All rights reserved.
//

#import "TarbarViewController.h"
#import "TNPTarbarView.h"
#import "Header.h"

@interface TarbarViewController ()
{
    NSMutableArray *_viewControllers;
}
@property(nonatomic,strong)TNPTarbarView *coustomTabar;
@end

@implementation TarbarViewController

-(void)viewDidDisappear:(BOOL)animated
{
    _coustomTabar.hidden = 1;
    KPostNoti(@"viewDidDisappear");
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:1];
    _coustomTabar.hidden = 0;
    [JCTool querybalance];

    KPostNoti(@"viewWillAppear");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    _coustomTabar = [[TNPTarbarView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT)];
    kWeakSelf;
    _coustomTabar.tarSeletBlock = ^(NSInteger index) {
        [weakSelf tableS:index];
    };
    [JCTool share].tarbarV = _coustomTabar;
    [self.view addSubview:_coustomTabar];
    
    [self setupChildViewControllers];
    [self tableS:0];//默认选择1
    
    
}


-(void)tableS:(NSInteger)index
{
    for (int i = 0;i<_viewControllers.count;i++)
    {
        UIViewController *vc = _viewControllers[i];
        if (i==index)
        {
            vc.view.hidden = 0;
        }else
        {
            vc.view.hidden = 1;
        }
    }
}

- (void)setupChildViewControllers
{
    _viewControllers = [NSMutableArray array];
    NSArray *vcA = @[@"HMainVC",@"MineVC"];
    for (int i = 0; i<vcA.count; i++)
    {
        BaseViewController *vc = [JCTool getViewControllerWithID:vcA[i]];
        vc.view.hidden = 1;
        [_viewControllers addObject:vc];
        [self addChildViewController:vc];
        vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT);
        [self.view insertSubview:vc.view belowSubview:_coustomTabar];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
