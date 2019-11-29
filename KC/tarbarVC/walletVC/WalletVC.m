//
//  WalletVC.m
//  OBS
//
//  Created by jian on 2019/9/9.
//  Copyright © 2019 jian. All rights reserved.
//

#import "WalletVC.h"
#import "WalletListVC.h"

@interface WalletVC()<SPPageMenuDelegate>
{
    NSInteger _seletedIndex;
    NSInteger _typeSeleted;
}
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UILabel *l1;
@property (weak, nonatomic) IBOutlet UILabel *l2;
@property (weak, nonatomic) IBOutlet UILabel *l3;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UIView *chooseV;

@property (weak, nonatomic) IBOutlet UIView *btnBgV;
@property (strong, nonatomic) SPPageMenu* pageMenu;

@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) NSMutableArray* controllers;
@end
static int hh = 40;
#define SSHH (SCREEN_HEIGHT -BOTTOM_SAFE_SPACE-NAV_HEIGHT -180-70-40)
@implementation WalletVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:1];
}

- (IBAction)tcBtnClick:(UIButton *)sender {
    NSArray *vcA = @[@"OutVC",@"HChongVC"];
    UIViewController *vc = [JCTool getViewControllerWithID:vcA[sender.tag-10]];
    [self.navigationController pushViewController:vc animated:1];
    
}

- (IBAction)clickAddress:(UIButton *)sender {
    [UIPasteboard generalPasteboard].string = [JCTool share].money.address;
    TShowMessage(@"地址已复制到粘贴板");
    
}

- (IBAction)hiddenChoseV:(UIButton *)sender {
    _chooseV.hidden = 1;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    KAddNoti(@selector(reloadUI), KMMChange);
    _typeSeleted = 0;
    _seletedIndex = 0;
    for (UIButton *btn in _btnBgV.subviews) {
        if (btn.tag>9) {
            [btn setTitle:TLOCAL(btn.titleLabel.text) forState:(UIControlStateNormal)];
            [btn layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleLeft) imageTitleSpace:5];
        }
        
    }
    
    
    [self reloadUI];
    [self initView];
    
    
}

-(void)reloadUI
{
    _l1.text = [JCTool removeZero:[JCTool share].money.balance];
    _l2.text = [JCTool removeZero:[JCTool getCanPay]];
    _l3.text = [JCTool removeZero:[JCTool share].money.lockcount];
    _addressL.text = [JCTool share].money.address;
}

-(void)seletViewShow
{
    _chooseV.hidden = 0;
}

-(void)initView
{
    //JCLog(@"----%f",_contentV.size.height);
    [_contentV addSubview:self.pageMenu];
    [_contentV addSubview:self.scrollView];
    
    
    NSMutableArray* titles = [NSMutableArray array];
    NSArray *arr = @[@"全部",@"充币",@"提币",@"收益",@"购买"];
    NSArray *type = @[@"0",@"1",@"2",@"3,4,5",@"6"];
    kWeakSelf;
    for (int i = 0;i<arr.count;i++)
    {
        NSString *name = arr[i];
        [titles addObject:TLOCAL(name)];
        WalletListVC *vc = [JCTool getViewControllerWithID:@"WalletListVC"];
        vc.btnBlock = ^{
            [weakSelf seletViewShow];
        };
        vc.type = type[i];
        vc.index = i;
        [self.controllers addObject:vc];
    }
    
    [self.pageMenu setItems:titles selectedItemIndex:0];
    
    self.pageMenu.bridgeScrollView = self.scrollView;
    
    if (self.pageMenu.selectedItemIndex < self.controllers.count) {
        UIViewController* vc = self.controllers[self.pageMenu.selectedItemIndex];
        [self.scrollView addSubview:vc.view];
        vc.view.frame = CGRectMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0, SCREEN_WIDTH, SSHH);
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0);
        self.scrollView.contentSize = CGSizeMake(self.controllers.count*SCREEN_WIDTH, 0);
    }
}

#pragma mark - SPPageMenuDelegate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _typeSeleted = toIndex;
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * toIndex, 0) animated:YES];
    }
    if (self.controllers.count <= toIndex) {return;}
    
    UIViewController* vc = self.controllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([vc isViewLoaded]) return;
    
    vc.view.frame = CGRectMake(SCREEN_WIDTH * toIndex, 0, SCREEN_WIDTH, SSHH);
    [self.scrollView addSubview:vc.view];
}

#pragma mark - getter
-(SPPageMenu *)pageMenu {
    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, hh) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
        _pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
        _pageMenu.selectedItemTitleColor = ColorWithHex(@"#5193F4");
        _pageMenu.backgroundColor = [UIColor whiteColor];
        _pageMenu.unSelectedItemTitleColor = kTextColor6;;
        _pageMenu.tracker.backgroundColor = ColorWithHex(@"#5193F4");
        _pageMenu.itemTitleFont = Font(14);
        _pageMenu.delegate = self;
    }
    return _pageMenu;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 124, SCREEN_WIDTH, SSHH)];
        _scrollView.pagingEnabled = YES;
        //_scrollView.backgroundColor = [UIColor redColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

-(NSMutableArray *)controllers {
    if (!_controllers) {
        _controllers = [NSMutableArray array];
    }
    return _controllers;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = @[@"所有收益",@"矿机收益",@"节点分红",@"社区奖励"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    UILabel *l1 = [cell.contentView viewWithTag:10];
    l1.text = TLOCAL(arr[indexPath.row]);
    l1.textColor = kTextColor3;
    if (indexPath.row ==_seletedIndex) {
        l1.textColor = ColorWithHex(@"#5193F4");
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _seletedIndex = indexPath.row;
    NSArray *sA = @[@"3,4,5",@"3",@"5",@"4"];
    NSArray *arr = @[@"所有收益",@"矿机收益",@"节点分红",@"社区奖励"];
    WalletListVC *vc = _controllers[_typeSeleted];
    [vc reload:TLOCAL(arr[indexPath.row]) type:sA[indexPath.row]];
    [tableView reloadData];
    _chooseV.hidden = 1;
}
@end
