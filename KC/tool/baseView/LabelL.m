//
//  LabelL.m
//  RZQRose
//
//  Created by jian on 2019/8/19.
//  Copyright © 2019 jian. All rights reserved.
//

#import "LabelL.h"

@implementation LabelL

-(void)awakeFromNib
{
    [super awakeFromNib];
    if (self.text.length>0) {
        self.text = TLOCAL(self.text);
    }
    
}

@end
