//
//  ZXVC.m
//  KC
//
//  Created by jian on 2019/10/23.
//  Copyright © 2019 jian. All rights reserved.
//

#import "ZXVC.h"
#import "ZXListVC.h"
@interface ZXVC ()
{
    NSInteger _segIndex;
}


@property (weak, nonatomic) IBOutlet UIView *segV;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ZXVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _segIndex = 0;
    self.customNavBar.title = TLOCAL(@"资讯公告");
    TInitArray;
    NSArray *codeA = @[@"xwgg",@"hyxx",@"gjkx"];
    for (int i=0; i<codeA.count; i++) {
        ZXListVC *vc = [JCTool getViewControllerWithID:@"ZXListVC" name:@"Login"];
        vc.code = codeA[i];
        [self addChildViewController:vc];
        vc.view.frame = _contentV.bounds;
        vc.view.tag = i+10;
        vc.view.hidden = i;
        [_contentV addSubview:vc.view];
        
    }
    
    
    
}



-(IBAction)btnClick:(UIButton *)sender
{
    _segIndex = sender.tag-10;
    for (UIButton *btn in _segV.subviews)
    {
        if (btn.tag>9) {
            if (btn.tag == sender.tag) {
                [btn setBackgroundImage:TimageName(@"lun_top_s") forState:(UIControlStateNormal)];
                [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                
            }else
            {
                [btn setBackgroundImage:[UIImage new] forState:(UIControlStateNormal)];
                [btn setTitleColor:ColorWithHex(@"#B5B5B5") forState:(UIControlStateNormal)];
            }
        }
    }
    for (UIView *vv in _contentV.subviews) {
        if (vv.tag==sender.tag) {
            vv.hidden = 0;
        }else
        {
            vv.hidden = 1;
        }
    }
    
}






-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}

- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:1];
}
@end
