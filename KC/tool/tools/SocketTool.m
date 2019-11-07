//
//  SocketTool.m
//  RZQRose
//
//  Created by jian on 2019/5/23.
//  Copyright © 2019 jian. All rights reserved.
//

#import "SocketTool.h"

#import "Header.h"
@interface SocketTool()<SRWebSocketDelegate>
{
    NSTimer *_timer;
}
@end
@implementation SocketTool
static SocketTool *scockTool = nil;

+(instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scockTool = [[SocketTool alloc]init];
    });
    return scockTool;
}

-(void)initSocket
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        self->_timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(sendData) userInfo:nil repeats:1];
        [[NSRunLoop currentRunLoop] addTimer:self->_timer forMode:NSRunLoopCommonModes];
    });
    
}

-(void)initSocketsocket
{
    NSString *host = @"ws://pool.minerx.org:8550/websocketXX";
//#ifdef DEBUG
//    host = @"ws://192.168.1.200:5002/WebSocketXX";
//#endif
    _socket = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",host]]];
    _socket.delegate = scockTool;
    [_socket open];
}


-(void)sendData
{
    static int number = 0;
    number ++;
    if (number%1800==0)
    {
        [JCTool querybalance];
    }

    if (self.timeblock)
    {
        self.timeblock();
    }
    if (self.timeblock2) {
        self.timeblock2();
    }
    if (self.loadingBlock) {
        self.loadingBlock();
    }
    
    if ([JCTool isLogin] &&number%200==0)
    {
       [self repConnet];
    }
    
}

-(void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    JCLog(@"socket--链接成功");
    
    [self repConnet];
}


-(void)repConnet
{
    if (![JCTool isLogin]) {
        return;
    }
    TParms;
    [parms setValue:[JCTool share].user.userid forKey:@"senderid"];
    [parms setValue:@"notifycoin" forKey:@"content"];//notifycoin/leftmachine
    NSString *ss = [parms mj_JSONString];
    NSData *data = [ss dataUsingEncoding:NSUTF8StringEncoding];
    if (_socket.readyState == SR_CONNECTING)
        return;
    if (_socket.readyState == SR_CLOSED) {
        [_socket open];
    }else if(_socket.readyState == SR_OPEN)
    {
//        [_socket sendPing:data];
        [_socket send:data];
    }
    
}


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    [self dealData:message];
    return;
    NSString *str = [[NSString alloc]initWithData:message encoding:(NSUTF8StringEncoding)];
    //    JCLog(@"收到了-----%@",str);
    if ([str containsString:@"\r\n"])
    {
        if ([JCTool share].tempStr.length>0)
        {
            str = [[JCTool share].tempStr stringByAppendingString:str];
        }
        NSArray *strA = [str componentsSeparatedByString:@"\r\n"];
        if ([str hasSuffix:@"\r\n"])
        {
            [JCTool share].tempStr = @"";
            //完整包
            for (NSString *restr in strA)
            {
                //处理数据
                [self dealData:restr];
            }
            
        }else
        {
            for (NSString *resut in strA)
            {
                if ([resut isEqualToString:[strA lastObject]])
                {
                    break;
                }
                [self dealData:resut];
            }
            //不完整
            [JCTool share].tempStr = [strA lastObject];
        }
        
    }
    else
    {
        [JCTool share].tempStr = str;
//        [_socket sendPing:data];
        return;
    }
//    [_socket sendPing:data];
    
}

-(void)dealData:(NSString *)dataStr
{
    
    if (dataStr.length<1)
    {
        return;
    }
    NSDictionary *dic = [dataStr mj_JSONObject];
    NSArray *arr = [[dic valueForKey:@"result"] mj_JSONObject];
    if ([[dic valueForKey:@"code"] isEqualToString:@"marketdetail"])
    {
        KPostNotiobj(@"reloadHQ", arr);
    }
    else if ([[dic valueForKey:@"code"] isEqualToString:@"leftmachine"])
    {
        
    }
    else if ([[dic valueForKey:@"code"] isEqualToString:@"notifycoin"])
    {
        
    }
    
    
}




@end
