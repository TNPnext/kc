//
//  SYDetailVC.h
//  KC
//
//  Created by jian on 2019/10/31.
//  Copyright © 2019 jian. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYDetailVC : BaseViewController
@property(nonatomic,copy)NSString *exinfo;
@property(nonatomic,copy)NSString *orderid;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *titles;
@property(nonatomic,copy)NSString *interf;
@property(nonatomic,assign)int type;
@end

NS_ASSUME_NONNULL_END
