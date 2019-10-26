//
//  XIBView.m
//  RZQRose
//
//  Created by jian on 2019/8/14.
//  Copyright © 2019 jian. All rights reserved.
//

#import "XIBView.h"

@implementation XIBView


-(void)drawRect:(CGRect)rect
{
    self.clipsToBounds = 1;
    self.layer.cornerRadius = _cornerRadius;
    [self.layer setBorderWidth:_borW];
    [self.layer setBorderColor:[_borColor CGColor]];
}
@end
