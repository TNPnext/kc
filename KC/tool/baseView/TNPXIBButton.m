//
//  TNPButton.m
//  RZQRose
//
//  Created by jian on 2019/5/15.
//  Copyright © 2019 jian. All rights reserved.
//

#import "TNPXIBButton.h"
@implementation TNPXIBButton

-(void)drawRect:(CGRect)rect
{
    self.clipsToBounds = 1;
    self.layer.cornerRadius = _cornerRadius;
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[_borColor CGColor]];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    if (self.titleLabel.text.length>0)
    {
        [self setTitle:TLOCAL(self.titleLabel.text) forState:(UIControlStateNormal)];
    }
    
}
@end
