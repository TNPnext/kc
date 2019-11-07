//
//  AboutVC.m
//  OBS
//
//  Created by jian on 2019/9/11.
//  Copyright © 2019 jian. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC ()
@property (weak, nonatomic) IBOutlet UILabel *verL;
@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _verL.text = [NSString stringWithFormat:@"%@:V%@",TLOCAL(@"版本号"),[NSString appVersion]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}


@end
