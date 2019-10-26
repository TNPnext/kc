//
//  LanguageChooseViewController.m
//  RZQRose
//
//  Created by jian on 2019/5/16.
//  Copyright © 2019 jian. All rights reserved.
//

#import "LanguageVC.h"

@interface LanguageVC ()
{
    NSMutableArray *_dataArray;
    int _seletIndex;
}
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation LanguageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.hidden = 1;
    NSArray *arr = @[
        @{@"name":@"简体中文",@"vaule":@"zhcn",@"app":@"zh-Hans",@"idx":@"0"},
                     @{@"name":@"繁体中文",@"vaule":@"zhtw",@"app":@"zh-Hant",@"idx":@"1"},
                     @{@"name":@"English",@"vaule":@"en",@"app":@"en",@"idx":@"2"}
                   ];
     _backBtn.hidden = 1;
    if (self.navigationController.viewControllers.count>1) {
        _backBtn.hidden = 0;
    }
    NSDictionary *dic =  KOutObj(Klanguage);
    _seletIndex = [[dic valueForKey:@"idx"] intValue];
    _dataArray = arr.mutableCopy;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *d = _dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    UILabel *tt = [cell.contentView viewWithTag:10];
    tt.text = TLOCAL([d valueForKey:@"name"]);
    UIImageView *img = [cell.contentView viewWithTag:11];
    img.hidden = 1;
    int index = [[d valueForKey:@"idx"] intValue];
    if (index==_seletIndex) {
        img.hidden = 0;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *d = _dataArray[indexPath.row];
    _seletIndex = [[d valueForKey:@"idx"] intValue];
    [tableView reloadData];
}

-(IBAction)saveBtnClick:(UIButton *)sender
{
    NSDictionary *d = _dataArray[_seletIndex];
    KSaveObj(d, Klanguage);
    [SVProgressHUD showWithStatus:TLOCAL(@"语言设置中...")];
    [self performSelector:@selector(languageSetting) withObject:nil afterDelay:1];
}


-(void)languageSetting
{
    [SVProgressHUD dismiss];
    LoadVC *loadVc = [JCTool getViewControllerWithID:@"LoadVC"];
    [JCTool getWindow].rootViewController = loadVc;
}

-(IBAction)backClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:1];
}

@end
