//
//  BaseViewController.h
//  PUT
//
//  Created by mac on 2019/1/17.
//  Copyright © 2019年 TNP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRCustomNavigationBar.h"
@interface BaseViewController : UIViewController
@property (strong, nonatomic) WRCustomNavigationBar* customNavBar;
@property(nonatomic,copy)NSString *t_tilte;
@end
