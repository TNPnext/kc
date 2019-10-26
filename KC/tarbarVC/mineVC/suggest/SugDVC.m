//
//  SugDVC.m
//  CSLH
//
//  Created by jian on 2019/8/24.
//  Copyright © 2019 jian. All rights reserved.
//

#import "SugDVC.h"

@interface SugDVC ()
@property (weak, nonatomic) IBOutlet UILabel *myContentL;
@property (weak, nonatomic) IBOutlet UILabel *kefuContentL;
@end

@implementation SugDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

-(void)initViews
{
    self.customNavBar.title = TLOCAL(@"详情");
    NSString *s1 = [_model.content stringByReplacingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)];
    NSString *s2 = [_model.reply stringByReplacingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)];
    _myContentL.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"提交内容"),s1];
    _kefuContentL.text = [NSString stringWithFormat:@"%@:%@",TLOCAL(@"客服回复"),s2?s2:@""];
}

@end
