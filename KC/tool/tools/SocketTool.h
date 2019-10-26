//
//  SocketTool.h
//  RZQRose
//
//  Created by jian on 2019/5/23.
//  Copyright © 2019 jian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^timeBlock)(void);
@interface SocketTool : NSObject
@property(nonatomic,strong)SRWebSocket *socket;
@property(nonatomic,copy)timeBlock timeblock;
@property(nonatomic,copy)timeBlock timeblock2;
@property(nonatomic,copy)timeBlock loadingBlock;

+(instancetype)share;

-(void)initSocket;

-(void)initSocketsocket;
@end

NS_ASSUME_NONNULL_END
