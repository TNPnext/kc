//
//  FUWUVC.m
//  KC
//
//  Created by jian on 2019/11/14.
//  Copyright © 2019 jian. All rights reserved.
//

#import "FUWUVC.h"

@interface FUWUVC ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation FUWUVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TInitArray;
    NSArray *titA = @[@"矿机服务",@"流转服务",@"金融服务",@"信息服务",@"生态服务"];
    NSArray *contentA = @[@"Miner X平台是依托于矿场、矿机及相应的算力和存储空间而成立的，算力服务和存储服务是Miner X最核心也是最根本的业务，用户可通过平台享受矿机定制、交易及托管的多元化的矿机服务。",@"Miner X平台上的所有矿工可以通过平台将其矿机及矿场等固定资产在特定条件下，在平台内部以及二级市场进行流转，从而增加矿工们的资产流动性，同时也能让更多想要参与区块链矿业的用户参与其中。",@"Miner X平台将在近期随着亚洲市场的开放推出质押借币、套期保值等金融服务，并在此基础上不断拓展新的金融业务及金融衍生品。",@"Miner X平台将会在发展过程中，逐步整合行业的头部资源加入到整个生态系统中来，让所有矿工能够从平台上获得可靠的信息与资源，建立一个权威、专业、准确的信息发布及信息共享平台。",@"Miner X平台在为用户提供矿机、流转、金融及信息服务的基础上，逐步建立并完善平台的数字资产钱包、数字资产交易、区块链商城、区块链游戏等更多的商业生态，安全、高效的服务于平台全球用户。"];
    self.customNavBar.title = TLOCAL(@"Miner X服务");
    if (_isYS) {
        self.customNavBar.title = TLOCAL(@"Miner X优势");
        titA = @[@"自有矿机多",@"扩展潜力大",@"产业生态完善",@"抗风险能力强"];
        contentA = @[@"Miner X平台目前自有算力矿机及存储矿机约三万余台，累计算力和存储空间达500P。",@"在现有的矿场基础上，Miner X平台预期到2021年底自建矿场和联合矿场数量将达到20家，预计累计算力和空间将达到30E。",@"Miner X平台生态完善、业务广泛，在现有的矿机定制、交易及托管的基础上，将会逐步为平台用户提供数字钱包、资产交易、质押借币、套期保值、链商扶持等相关产业综合服务。",@"Miner X平台矿场主要分布在美国、加拿大、中国、委内瑞拉、俄罗斯、挪威、埃塞俄比亚等国家和地区，资源配置合理，抗风险能力强。"];
    }
    
    
    
    for (int i = 0; i<titA.count; i++) {
        NSMutableDictionary *dd = [NSMutableDictionary dictionary];
        [dd setValue:TLOCAL(titA[i]) forKey:@"tit"];
        [dd setValue:TLOCAL(contentA[i]) forKey:@"content"];
        [_dataArray addObject:dd];
    }
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _dataArray[indexPath.row];
    NSString *content = [dic valueForKey:@"content"];
    return getRectWithStr(content, 13, 0, SCREEN_WIDTH-30).size.height+50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cell1";
    NSDictionary *dic = _dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    UIView *vv = cell.contentView;
    UILabel *l1 = [vv viewWithTag:10];
    UILabel *l2 = [vv viewWithTag:11];
    NSString *content = [dic valueForKey:@"content"];
    NSString *tit = [dic valueForKey:@"tit"];
    
    l1.text = tit;
    l2.text = content;
    return cell;
}

@end
