//
//  XibView.h
//  RZQRose
//
//  Created by jian on 2019/5/18.
//  Copyright © 2019 jian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "SPPageMenu.h"


@class GameModel;

@interface GeneralView : UIView

@end


typedef void(^reloadDate)(void);
@interface HSView : UIView

@property(nonatomic,copy)reloadDate reloadDateBlock;
@property(nonatomic,strong)HomeListModel *model;

@property (strong, nonatomic)NSDictionary *dataDic;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *tipsL;

@end


