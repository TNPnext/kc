//
//  TNPTextField.m
//  RZQRose
//
//  Created by jian on 2019/5/15.
//  Copyright © 2019 jian. All rights reserved.
//

#import "TNPXIBTextField.h"

@implementation TNPXIBTextField

-(void)drawRect:(CGRect)rect
{
    if (self.placeholder.length>0) {
        self.attributedPlaceholder = [JCTool colorWithStr:self.placeholder Color:_placeHolderColor];
    }
    
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    if (self.placeholder.length>0) {
        self.placeholder = TLOCAL(self.placeholder);
    }
    
    
}

@end
