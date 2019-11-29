//
//  MySYVC.m
//  KC
//
//  Created by jian on 2019/10/30.
//  Copyright © 2019 jian. All rights reserved.
//

#import "MySYVC.h"
#import "SYListVC.h"
@interface MySYVC ()<
SPPageMenuDelegate
>
@property (weak, nonatomic) IBOutlet UILabel *zongL;
@property (weak, nonatomic) IBOutlet UILabel *wkL;
@property (weak, nonatomic) IBOutlet UILabel *jdL;
@property (weak, nonatomic) IBOutlet UILabel *kcL;
@property (weak, nonatomic) IBOutlet UILabel *fxL;

@property (strong, nonatomic) SPPageMenu* pageMenu;

@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) NSMutableArray* controllers;

@end
static int hh = 40;
#define SSH (SCREEN_HEIGHT - hh - NAV_HEIGHT-BOTTOM_SAFE_SPACE -190)
@implementation MySYVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = TLOCAL(@"我的收益");
//    [self.customNavBar wr_setRightButtonWithTitle:TLOCAL(@"收益规则") font:14];
//    [self.customNavBar wr_setRightButtonWithTitle:TLOCAL(@"收益规则") titleColor:kTextColor3];
    [self initView];
    [self getAllSY];
}

-(void)getAllSY
{
    self.fxL.text = [JCTool removeZero:_invitetotal];
    self.kcL.text = [JCTool removeZero:_abtotal];
    self.wkL.text = [JCTool removeZero:_jttotal];
    self.jdL.text = [JCTool removeZero:_stotal];
    self.zongL.text = [JCTool removeZero:_total];
}

-(void)initView
{
    
    [self.view addSubview:self.pageMenu];
    [self.view addSubview:self.scrollView];
    
    
    NSMutableArray* titles = [NSMutableArray array];
    NSArray *arr = @[@"挖矿收益",@"节点分红",@"矿池分红"];
    NSArray *type = @[@"rzq.tradecreditorder.get",@"rzq.order_sq.get",@"rzq.order_ab.get"];
    for (int i = 0;i<arr.count;i++)
    {
        NSString *name = TLOCAL(arr[i]);
        [titles addObject:name];
        SYListVC* vc = [JCTool getViewControllerWithID:@"SYListVC"];
        vc.interf = type[i];
        vc.type = i;
        [self.controllers addObject:vc];
    }
    
    [self.pageMenu setItems:titles selectedItemIndex:0];
    
    self.pageMenu.bridgeScrollView = self.scrollView;
    
    if (self.pageMenu.selectedItemIndex < self.controllers.count) {
        UIViewController* vc = self.controllers[self.pageMenu.selectedItemIndex];
        [self.scrollView addSubview:vc.view];
        vc.view.frame = CGRectMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0, SCREEN_WIDTH, SSH);
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0);
        self.scrollView.contentSize = CGSizeMake(self.controllers.count*SCREEN_WIDTH, 0);
    }
}

#pragma mark - SPPageMenuDelegate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * toIndex, 0) animated:YES];
    }
    if (self.controllers.count <= toIndex) {return;}
    
    UIViewController* vc = self.controllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([vc isViewLoaded]) return;
    
    vc.view.frame = CGRectMake(SCREEN_WIDTH * toIndex, 0, SCREEN_WIDTH, SSH);
    [self.scrollView addSubview:vc.view];
}

#pragma mark - getter
-(SPPageMenu *)pageMenu {
    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, NAV_HEIGHT+190, SCREEN_WIDTH, hh) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
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
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT + hh+190, SCREEN_WIDTH, SSH)];
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
@end
