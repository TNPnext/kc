//
//  WalletListVC.h
//  KC
//
//  Created by jian on 2019/10/31.
//  Copyright © 2019 jian. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^btnClick)(void);
@interface WalletListVC : UIViewController
@property(nonatomic,copy)NSString *type;
@property(nonatomic,assign)int index;
@property(nonatomic,copy)btnClick btnBlock;
-(void)reload:(NSString *)str type:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
