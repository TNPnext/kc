//
//  XIBLabel.m
//  RZQRose
//
//  Created by jian on 2019/8/14.
//  Copyright © 2019 jian. All rights reserved.
//

#import "XIBLabel.h"

@implementation XIBLabel

-(void)drawRect:(CGRect)rect
{
    self.clipsToBounds = 1;
    self.layer.cornerRadius = _cornerRadius;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    if (self.text.length>0) {
        self.text = TLOCAL(self.text);
    }
    
}

@end
