//
//  TNPButton.h
//  RZQRose
//
//  Created by jian on 2019/5/15.
//  Copyright © 2019 jian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface TNPXIBButton : UIButton

@property(nonatomic,assign)IBInspectable double cornerRadius;
@property(nonatomic,strong)IBInspectable UIColor *borColor;
@end

NS_ASSUME_NONNULL_END
