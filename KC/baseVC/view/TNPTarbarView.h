//
//  TNPTarbarView.h
//  RZQRose
//
//  Created by jian on 2019/5/16.
//  Copyright © 2019 jian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TarbarViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^tarSeletBlock)(NSInteger index);
@interface TNPTarbarView : UIView
@property(nonatomic,copy)tarSeletBlock tarSeletBlock;
@end

NS_ASSUME_NONNULL_END
