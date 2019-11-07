//
//  SuggestVC.m
//  CSLH
//
//  Created by jian on 2019/8/24.
//  Copyright © 2019 jian. All rights reserved.
//

#import "SuggestVC.h"

@interface SuggestVC ()
@property (weak, nonatomic) IBOutlet UITextField *inputF1;
@property (weak, nonatomic) IBOutlet UITextView *contnetInput;
@property (weak, nonatomic) IBOutlet UILabel *placeL;


@end

@implementation SuggestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    KAddNoti(@selector(textChange), UITextViewTextDidChangeNotification);
    [self initViews];
}

-(void)initViews
{
    self.customNavBar.hidden = 1;
    
}


-(void)textChange
{
   
    _placeL.hidden = (_contnetInput.text.length>0)?1:0;
}

- (IBAction)commitBtnClick:(UIButton *)sender {
    
    if (_inputF1.text.length<2) {
        TShowMessage(@"标题过短");
        return;
    }
    if (_contnetInput.text.length<10)
    {
        TShowMessage(@"咨询内容最少10个字符");
        return;
    }
    [self commitUp];
    
}

-(void)commitUp
{
    TParms;
    NSString *uft1 = [_inputF1.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *uft2 = [_contnetInput.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [parms setValue:uft1 forKey:@"title"];
    [parms setValue:uft2 forKey:@"content"];
    
    [NetTool getDataWithInterface:@"rzq.customermsg.set" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                kWeakSelf;
                [NSObject showAlertWithTarget:self title:@"" message:TLOCAL(@"我们已收到您的回馈，将会尽快和您取得联系并回复处理结果。") actionWithTitle:TLOCAL(@"确定") handler:^(UIAlertAction *action) {
                    [weakSelf.navigationController popViewControllerAnimated:1];
                }];
                
            }
            break;
                
            default:
                TShowResMsg;
                break;
        }
    } failure:^(NSError *error) {
        TShowNetError;
    }];
}

-(IBAction)backClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:1];
}
@end
