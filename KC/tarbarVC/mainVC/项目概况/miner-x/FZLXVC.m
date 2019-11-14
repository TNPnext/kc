//
//  FZLXVC.m
//  KC
//
//  Created by jian on 2019/11/14.
//  Copyright © 2019 jian. All rights reserved.
//

#import "FZLXVC.h"

@interface FZLXVC ()

@end

@implementation FZLXVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:1];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.hidden = 1;
}

-(IBAction)backBtnClick
{
    [self.navigationController popViewControllerAnimated:1];
}
@end
