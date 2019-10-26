//
//  BaseViewController.m
//  PUT
//
//  Created by mac on 2019/1/17.
//  Copyright © 2019年 TNP. All rights reserved.
//

#import "BaseViewController.h"
#import "Header.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
    
    
}

- (void)setupNavBar
{
    
    [self.view addSubview:self.customNavBar];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    self.customNavBar.barBackgroundColor = [UIColor clearColor];
    [self.customNavBar wr_setBottomLineHidden:YES];
    if (self.navigationController.childViewControllers.count > 1) {
        [self.customNavBar wr_setLeftButtonWithImage:TimageName(@"find_pass_back")];
        
    }
    if (self.t_tilte.length>0)
    {
        self.customNavBar.title = self.t_tilte;
    }
}


- (WRCustomNavigationBar *)customNavBar {
    if (!_customNavBar) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //[SVProgressHUD dismiss];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
