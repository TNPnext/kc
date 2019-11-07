//
//  ChartViewController.m
//  RZQRose
//
//  Created by jian on 2019/5/21.
//  Copyright © 2019 jian. All rights reserved.
//

#import "ChartViewController.h"
#import <IQKeyboardManager.h>

@interface ChartViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic)IBOutlet UIView *bottomV;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)UIImage *seletimg;
@property (weak, nonatomic) IBOutlet UILabel *titleL;


@end

@implementation ChartViewController

-(void)viewWillAppear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = 0;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [IQKeyboardManager sharedManager].enable = 1;
}

-(IBAction)backClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:1];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customNavBar.hidden = 1;
    NSString *unc = [_model.title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _titleL.text = unc;
    kWeakSelf
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           weakSelf.page++;
           [weakSelf getMoreData];
       }];
    _page = 1;
    KAddNoti(@selector(keyboardWillShow:), UIKeyboardWillShowNotification);
    KAddNoti(@selector(keyboardWillHidden:), UIKeyboardWillHideNotification);
    
    TInitArray;
    
    [self initData];
    
}




-(void)getMoreData
{
    
    TParms;
    kWeakSelf;
    [parms setValue:@"20" forKey:@"pagesize"];
    [parms setValue:[NSString stringWithFormat:@"%d",_page] forKey:@"pageindex"];
    [parms setValue:_model.cid forKey:@"cmid"];
    [NetTool getDataWithInterface:@"rzq.reply.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dds = [responseObject valueForKey:@"data"];
                NSArray *arr = [dds valueForKey:@"List"];
                NSInteger totalPage = [[dds valueForKey:@"PageCount"] intValue];
                arr = [[arr reverseObjectEnumerator] allObjects];
                NSArray *mA = [SugModel mj_objectArrayWithKeyValuesArray:arr];
                [weakSelf.dataArray insertObjects:mA atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, mA.count)]];
                if (totalPage==weakSelf.page) {
                    SugModel *mm = [SugModel new];
                    mm.username = [JCTool share].user.username;
                    mm.content = weakSelf.model.content;
                    [weakSelf.dataArray insertObject:mm atIndex:0];
                    [weakSelf.tableView.mj_header endRefreshing];
                }else
                {
                    [weakSelf.tableView.mj_header endRefreshing];
                }
               [weakSelf.tableView reloadData];
                
            }
                break;
                
            default:
            {
                [weakSelf.tableView.mj_header endRefreshing];
            }
                break;
        }
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    
}

-(void)initData
{
    
    TParms;
    kWeakSelf;
    [parms setValue:@"20" forKey:@"pagesize"];
    [parms setValue:[NSString stringWithFormat:@"%d",_page] forKey:@"pageindex"];
    [parms setValue:_model.cid forKey:@"cmid"];
    [NetTool getDataWithInterface:@"rzq.reply.get" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                NSDictionary *dds = [responseObject valueForKey:@"data"];
                NSArray *arr = [dds valueForKey:@"List"];
                NSInteger totalPage = [[dds valueForKey:@"PageCount"] intValue];
                arr = [[arr reverseObjectEnumerator] allObjects];
                NSArray *mA = [SugModel mj_objectArrayWithKeyValuesArray:arr];
                [weakSelf.dataArray addObjectsFromArray:mA];
                
                if (totalPage==weakSelf.page) {
                    SugModel *mm = [SugModel new];
                    mm.username = [JCTool share].user.username;
                    mm.content = weakSelf.model.content;
                    [weakSelf.dataArray insertObject:mm atIndex:0];
                    [weakSelf.tableView reloadData];
                }
               [weakSelf.tableView reloadData];
                
            }
                break;
                
            default:
            
                break;
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0)
    {
       CGRect rect = getRectWithStr(textView.text, 14, 0, SCREEN_WIDTH-110);
        [_bottomV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rect.size.height+35);
        }];
    }else
    {
        [_bottomV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
        }];
    }
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        
        if (_textView.text.length<1)
        {
            TShowMessage(@"输入内容不能为空");
            return 0;
        }
        if (_textView.text.length>500)
        {
            TShowMessage(@"输入内容不能超过500个字符");
            return 0;
        }
        //发送消息
//        [self sendMessage];
        return 0;
    }
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SugModel *model = _dataArray[indexPath.row];
    switch (indexPath.row)
    {
        default:
        {
            NSString *unc = [model.content stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (model.picurl.length>0)
            {
                return 160;
            }
            CGFloat ww = SCREEN_WIDTH-180;
            CGRect rect = getRectWithStr(unc, 14, 3, ww);
            return rect.size.height+35;
        }
            break;
    }
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SugModel *model = _dataArray[indexPath.row];
    NSString *username = [JCTool share].user.username;
    NSString *unc = [model.content stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([username isEqualToString:model.username])
    {
        if (model.picurl.length>0)
        {
            IMGRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
            cell.model = model;
            return cell;
        }else
        {
            ChartRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell.model = model;
            return cell;
        }

    }
    else
    {
        if (model.picurl.length>0)
        {
            IMGLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            cell.model = model;
            return cell;
        }else
        {
            ChartRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.model = model;
            return cell;
        }
    }
}


/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{

    NSDictionary *useInfo = [note userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    
    CGRect rect = [value CGRectValue];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0];
    [self.bottomV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-rect.size.height);
    }];
    [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:0];
}

- (void)keyboardWillHidden:(NSNotification *)note
{

    [self.bottomV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(0);
    }];

    
}

- (IBAction)senderMessage:(UIButton *)sender {
    
    if (sender.tag==10) {
        [self sendMessage];
    }else
    {
        //选择图片
        [self openLibrary];
    }
    
}

-(void)sendMessage
{
 
    if (_textView.text.length<1)
    {
        TShowMessage(@"输入内容不能为空");
        return ;
    }
    if (_textView.text.length>500)
    {
        TShowMessage(@"输入内容不能超过500个字符");
        return;
    }
    
    TParms;
    kWeakSelf;
    NSString *uft1 = [_textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [parms setValue:_model.cid forKey:@"cmid"];
    [parms setValue:uft1 forKey:@"content"];
    [NetTool getDataWithInterface:@"rzq.reply.set" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                SugModel *mm = [SugModel new];
                mm.username = [JCTool share].user.username;
                mm.content = uft1;
                [weakSelf.dataArray addObject:mm];
                [weakSelf.tableView reloadData];
                weakSelf.textView.text = @"";
                [weakSelf textViewDidChange:weakSelf.textView];
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

-(void)openLibrary
{
    UIImagePickerController *pickV = [[UIImagePickerController alloc]init];
    pickV.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickV.delegate = self;
    [self presentViewController:pickV animated:1 completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info
{
    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
    _seletimg = img;
    kWeakSelf;
    [picker dismissViewControllerAnimated:1 completion:^{
        [weakSelf uploadingImg];
    }];
    
}

-(void)uploadingImg
{
    kWeakSelf;
    [SVProgressHUD showWithStatus:TLOCAL(@"上传中...")];
    NSData *imgd = UIImagePNGRepresentation(_seletimg);
    NSString *base = [imgd base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
    NSString *pp = [NSString stringWithFormat:@"data:image/png;base64,%@",base];
    TParms;
    [parms setValue:pp forKey:@"filedata"];
    [NetTool getDataWithInterface:@"rzq.sys.uploadfile" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                TShowResMsg;
                NSDictionary *dic = [responseObject valueForKey:@"data"];
                NSString *url = [dic valueForKey:@"url"];
                [weakSelf sendImg:url];
                
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

-(void)sendImg:(NSString *)string
{
    TParms;
    kWeakSelf;
    [parms setValue:_model.cid forKey:@"cmid"];
    [parms setValue:string forKey:@"picurl"];
    [NetTool getDataWithInterface:@"rzq.reply.set" Parameters:parms success:^(id  _Nullable responseObject) {
        switch (TResCode) {
            case 1:
            {
                SugModel *mm = [SugModel new];
                mm.username = [JCTool share].user.username;
                mm.picurl = string;
                [weakSelf.dataArray addObject:mm];
                [weakSelf.tableView reloadData];
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

@end
