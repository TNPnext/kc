//
//  GeneralXibCell.h
//  RZQRose
//
//  Created by jian on 2019/5/22.
//  Copyright © 2019 jian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"


@interface GeneralXibCell : UITableViewCell

@end

@interface HomeCell : UITableViewCell
@property (strong, nonatomic)HomeListModel *model;
@property (weak, nonatomic) IBOutlet UIView *leftV;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UIView *czV;
@property (weak, nonatomic) IBOutlet UIView *btnBg;
@property (strong, nonatomic) UILabel *currL;
@property (weak, nonatomic) IBOutlet UILabel *lunciL;
@property (weak, nonatomic) IBOutlet UILabel *cnL;
@property (weak, nonatomic) IBOutlet UILabel *jtL;
@property (weak, nonatomic) IBOutlet UILabel *dtL;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;
@property (weak, nonatomic) IBOutlet UIView *comV;
@property (weak, nonatomic) IBOutlet UILabel *comjtL;
@property (weak, nonatomic) IBOutlet UILabel *comdtL;

@end






@interface DListCell : UITableViewCell
@property (strong, nonatomic)GameDModel *model;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic)UILabel *currL;
@property (strong, nonatomic)UILabel *labelbg;
@property (weak, nonatomic) IBOutlet UIView *contentV;

@end

@interface SugCell : UITableViewCell
@property (strong, nonatomic)SugModel *model;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;


@end

@interface YJCell : UITableViewCell
@property (strong, nonatomic)NSArray *array;
@property (strong, nonatomic)NSString *lunci;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;



@end

@interface YJDCell : UITableViewCell
@property (strong, nonatomic)YJModel *model;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@end

@interface MainHqCell : UITableViewCell
@property (strong, nonatomic)CoinModel *model;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@end


@interface WalletCell : UITableViewCell
@property (strong, nonatomic)MoneyModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *coinName;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
//@property (weak, nonatomic) IBOutlet UILabel *label3;


@end


@interface WalletOutCell : UITableViewCell
@property (strong, nonatomic)WalletReOutModel *model;
@property (weak, nonatomic) IBOutlet UILabel *coinNameL;
@property (weak, nonatomic) IBOutlet UILabel *numberL;
@property (weak, nonatomic) IBOutlet UILabel *feeL;
@property (weak, nonatomic) IBOutlet UILabel *stateL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *hashL;

@end

@interface WalletInCell : UITableViewCell
@property (strong, nonatomic)WalletReInModel *model;
@property (weak, nonatomic) IBOutlet UILabel *coinNameL;
@property (weak, nonatomic) IBOutlet UILabel *numberL;
@property (weak, nonatomic) IBOutlet UILabel *stateL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *hashL;

@end


@interface MShareCell : UITableViewCell
@property (strong, nonatomic)UserModel *model;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;


@end


@interface JoinReCell : UITableViewCell
@property (strong, nonatomic)NSIndexPath *indexp;
@property (strong, nonatomic)HomeListModel *model;
@property (weak, nonatomic) IBOutlet UILabel *lunciL;
@property (weak, nonatomic) IBOutlet UILabel *cnL;
@property (weak, nonatomic) IBOutlet UILabel *jtL;
@property (weak, nonatomic) IBOutlet UILabel *dtL;
@property (weak, nonatomic) IBOutlet UILabel *jtTipL;
@property (weak, nonatomic) IBOutlet UILabel *dtTipL;
@property (weak, nonatomic) IBOutlet UILabel *dtstateL;
@property (weak, nonatomic) IBOutlet UILabel *jtstateL;
@property (weak, nonatomic) IBOutlet UILabel *threeL;


@property (weak, nonatomic) IBOutlet UIButton *cellBtn;
@property (weak, nonatomic) IBOutlet UIButton *tipBtn;
@property (weak, nonatomic) IBOutlet UIView *tipV;

@end


//奖励
@interface JLCell : UITableViewCell
@property (strong, nonatomic)RewardModel *model;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *sdlabel;
@end


//账本
@interface ZBCell1 : UITableViewCell
@property (strong, nonatomic)HomeListModel *model;
@property (weak, nonatomic) IBOutlet UILabel *qiL;
@property (weak, nonatomic) IBOutlet UILabel *stateL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *amountL;
@property (weak, nonatomic) IBOutlet UILabel *jtnumL;
@property (weak, nonatomic) IBOutlet UILabel *dtnumL;

@end
//账本
@interface ZBCell2 : UITableViewCell
@property (strong, nonatomic)GRZBModel *model;
@property (strong, nonatomic)OETModel *omodel;
@property (weak, nonatomic) IBOutlet UILabel *qiL;
@property (weak, nonatomic) IBOutlet UILabel *numberL0;
@property (weak, nonatomic) IBOutlet UILabel *numberL1;
@property (weak, nonatomic) IBOutlet UILabel *numberL2;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@end

@interface MyZCCell : UITableViewCell
@property (strong, nonatomic)GameDModel *model;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *futouL;

@end


@interface OETCell : UITableViewCell
@property (strong, nonatomic)GameDModel *model;
@property (weak, nonatomic) IBOutlet UILabel *qiL;
@property (weak, nonatomic) IBOutlet UILabel *totalL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *numL1;
@property (weak, nonatomic) IBOutlet UILabel *numL2;
@property (weak, nonatomic) IBOutlet UILabel *numL3;
@property (weak, nonatomic) IBOutlet UILabel *numL4;


@end

//预约记录
@interface YYCell : UITableViewCell
@property (strong, nonatomic)JoinModel *model;
@property (strong, nonatomic)SugModel *ymodel;
@property (strong, nonatomic)SugModel *zmodel;
@property (strong, nonatomic)RGModel *rgModel;
@property (strong, nonatomic)BBHZModel *hzModel;
@property (weak, nonatomic) IBOutlet UILabel *numL1;
@property (weak, nonatomic) IBOutlet UILabel *numL2;
@property (weak, nonatomic) IBOutlet UILabel *numL3;
@property (weak, nonatomic) IBOutlet UILabel *hashL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIView *hashV;


@property (weak, nonatomic) IBOutlet UILabel *ll1;
@property (weak, nonatomic) IBOutlet UILabel *ll2;
@property (weak, nonatomic) IBOutlet UILabel *ll3;

@property (weak, nonatomic) IBOutlet UIButton *ziyaBtn;

@property (weak, nonatomic) IBOutlet UILabel *stateL;


@end


//提现记录
@interface TXCell : UITableViewCell
@property (strong, nonatomic)TXModel *model;
@property (weak, nonatomic) IBOutlet UILabel *qiL;
@property (weak, nonatomic) IBOutlet UILabel *amountL;
@property (weak, nonatomic) IBOutlet UILabel *feeL;
@property (weak, nonatomic) IBOutlet UILabel *stateL;
@property (weak, nonatomic) IBOutlet UILabel *typeL;
@end

//委托记录
@interface WTCell : UITableViewCell
@property (strong, nonatomic)WTModel *model;
@property (strong, nonatomic)WTModel *cdModel;
@property (weak, nonatomic) IBOutlet UILabel *l1;
@property (weak, nonatomic) IBOutlet UILabel *l2;
@property (weak, nonatomic) IBOutlet UILabel *l3;
@property (weak, nonatomic) IBOutlet UILabel *l4;
@property (weak, nonatomic) IBOutlet UILabel *l5;
@property (weak, nonatomic) IBOutlet UILabel *l6;
@property (weak, nonatomic) IBOutlet UILabel *l7;
@property (weak, nonatomic) IBOutlet UILabel *l8;
@property (weak, nonatomic) IBOutlet UILabel *l9;
@property (weak, nonatomic) IBOutlet UIButton *chedanBtn;

@end



@interface ChartLeftCell : UITableViewCell
@property(nonatomic,strong)SugModel *model;

@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UIImageView *contentBg;
@property (weak, nonatomic) IBOutlet UILabel *contentL;

@end;

@interface ChartRightCell : UITableViewCell
@property(nonatomic,strong)SugModel *model;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UIImageView *contentBg;
@property (weak, nonatomic) IBOutlet UILabel *contentL;


@end;

@interface IMGLeftCell : UITableViewCell
@property(nonatomic,strong)SugModel *model;
@property (weak, nonatomic) IBOutlet UIButton *showImg;;

@end;

@interface IMGRightCell : UITableViewCell
@property(nonatomic,strong)SugModel *model;
@property (weak, nonatomic) IBOutlet UIButton *showImg;;

@end;
