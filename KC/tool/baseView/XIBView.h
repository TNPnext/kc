//
//  XIBView.h
//  RZQRose
//
//  Created by jian on 2019/8/14.
//  Copyright © 2019 jian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface XIBView : UIView
@property(nonatomic,assign)IBInspectable double cornerRadius;
@property(nonatomic,strong)IBInspectable UIColor *borColor;
@property(nonatomic,assign)IBInspectable double borW;
@end

NS_ASSUME_NONNULL_END
