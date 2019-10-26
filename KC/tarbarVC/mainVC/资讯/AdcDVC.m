//
//  AdcDVC.m
//  XHSJ
//
//  Created by jian on 2019/9/3.
//  Copyright © 2019 jian. All rights reserved.
//

#import "AdcDVC.h"

@interface AdcDVC ()
@property (weak, nonatomic) IBOutlet UILabel *l1;
@property (weak, nonatomic) IBOutlet UILabel *l2;
@property (weak, nonatomic) IBOutlet UILabel *l3;
@end

@implementation AdcDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = TLOCAL(@"详情");
    _l1.text = _model.title;
    _l2.text = _model.subject;
    NSString *dt = [_model.sendtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _l3.text = [dt substringToIndex:10];
    
    
}



@end
