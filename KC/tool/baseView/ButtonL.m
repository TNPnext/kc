//
//  ButtonL.m
//  RZQRose
//
//  Created by jian on 2019/8/19.
//  Copyright © 2019 jian. All rights reserved.
//

#import "ButtonL.h"

@implementation ButtonL

-(void)awakeFromNib
{
    [super awakeFromNib];
    if (self.titleLabel.text.length>0)
    {
        [self setTitle:TLOCAL(self.titleLabel.text) forState:(UIControlStateNormal)];
    }
    
}

@end
