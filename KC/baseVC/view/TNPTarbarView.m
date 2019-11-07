//
//  TNPTarbarView.m
//  RZQRose
//
//  Created by jian on 2019/5/16.
//  Copyright © 2019 jian. All rights reserved.
//

#import "TNPTarbarView.h"
@interface TNPTarbarView()
{
    UIView *_contentV;
    UIButton *btns;
}
@end
@implementation TNPTarbarView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        KAddNoti(@selector(tabClick), @"tabClick");
        self.backgroundColor = [UIColor whiteColor];
        
        NSArray *imA = @[@"tab_icon_11",@"tab_icon_3",@"tab_icon_4",@"tab_icon_2"];
        NSArray *titA = @[TLOCAL(@"首页"),TLOCAL(@"矿机"),TLOCAL(@"钱包"),TLOCAL(@"我的")];
        CGFloat ww = SCREEN_WIDTH/imA.count;
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _contentV.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentV];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = ColorWithHex(@"#F4F4F4");
        [_contentV addSubview:line];
        
        for (int i = 0; i<imA.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*ww, 0.5, ww, 49);
            [btn setImage:TimageName(imA[i]) forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [btn setTitle:titA[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:ColorWithHex(@"#969696") forState:(UIControlStateNormal)];
            btn.titleLabel.font = fontSize(12);
            [btn layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleTop) imageTitleSpace:10];
            btn.tag = i+10;
            if (i==0)
            {
                btns = btn;
                [btn setTitleColor:ColorWithHex(@"#3F92FC") forState:(UIControlStateNormal)];
            }
            [_contentV addSubview:btn];
        }
        
    }
    
    return self;
}

-(void)tabClick
{
    [self btnClick:btns];
}

-(void)btnClick:(UIButton *)sender
{
    for (UIButton *btn in _contentV.subviews)
    {
        if (btn.tag>9)
        {
            if (btn.tag == sender.tag)
            {
                NSArray *imA = @[@"tab_icon_11",@"tab_icon_33",@"tab_icon_44",@"tab_icon_22"];
                
                [btn setImage:TimageName(imA[btn.tag-10]) forState:(UIControlStateNormal)];
                [btn setTitleColor:ColorWithHex(@"#3F92FC") forState:(UIControlStateNormal)];
                if (self.tarSeletBlock)
                {
                    self.tarSeletBlock(btn.tag-10);
                }
            }else
            {
                NSArray *nimA = @[@"tab_icon_1",@"tab_icon_3",@"tab_icon_4",@"tab_icon_2"];
                [btn setTitleColor:ColorWithHex(@"#969696") forState:(UIControlStateNormal)];
                [btn setImage:TimageName(nimA[btn.tag-10]) forState:(UIControlStateNormal)];
            }
            
        }
    }
    
}

@end
