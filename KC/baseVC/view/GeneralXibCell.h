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





@interface SugCell : UITableViewCell
@property (strong, nonatomic)SugModel *model;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;


@end



@interface MainHqCell : UITableViewCell
@property (strong, nonatomic)CoinModel *model;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *cnyL;


@end


@interface WalletCell : UITableViewCell
@property (strong, nonatomic)MoneyModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *coinName;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
//@property (weak, nonatomic) IBOutlet UILabel *label3;


@end






@interface MShareCell : UITableViewCell
@property (strong, nonatomic)UserModel *model;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;


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
@property (weak, nonatomic) IBOutlet UIButton *showImg;

@end;

@interface IMGRightCell : UITableViewCell
@property(nonatomic,strong)SugModel *model;
@property (weak, nonatomic) IBOutlet UIButton *showImg;

@end;

//收益
@interface SYCell : UITableViewCell
@property(nonatomic,strong)SYModel *model;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *stateL;
@property (weak, nonatomic) IBOutlet UILabel *numberL;

@end

//我的矿机
@interface MyPrductCell : UITableViewCell
@property(nonatomic,strong)MyPrudctModel *model;
@property(nonatomic,strong)MyYYReModel *ymodel;
@property(nonatomic,strong)MyPrudctModel *hismodel;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *reL;
@property (weak, nonatomic) IBOutlet UILabel *cosetL;
@property (weak, nonatomic) IBOutlet UILabel *slL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *orderidL;

@property (weak, nonatomic) IBOutlet UILabel *chakan1;
@property (weak, nonatomic) IBOutlet UILabel *chakan2;
@property (weak, nonatomic) IBOutlet UILabel *chakan3;



@property (weak, nonatomic) IBOutlet UILabel *stimeL;
@property (weak, nonatomic) IBOutlet UILabel *etimeL;


//yuyue
@property (weak, nonatomic) IBOutlet UILabel *num1;
@property (weak, nonatomic) IBOutlet UILabel *num2;
@property (weak, nonatomic) IBOutlet UILabel *num3;
@property (weak, nonatomic) IBOutlet UILabel *num4;
@property (weak, nonatomic) IBOutlet UILabel *num5;


@end

