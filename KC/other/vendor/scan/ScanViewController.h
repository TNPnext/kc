//
//  ViewController.h
//  ScanQRcode
//
//  Created by 王双龙 on 2018/1/24.
//  Copyright © 2018年 https://www.jianshu.com/u/e15d1f644bea All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRCustomNavigationBar.h"
typedef void(^ScanFinishedBlock)( NSString * _Nullable scanString);
@interface ScanViewController : UIViewController
@property (strong, nonatomic) WRCustomNavigationBar *customNavBar;
@property (nonatomic, copy) ScanFinishedBlock _Nullable scanFinishedBlock;
@end

