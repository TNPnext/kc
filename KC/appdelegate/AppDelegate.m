//
//  AppDelegate.m
//  RZQRose
//
//  Created by jian on 2019/4/26.
//  Copyright © 2019 jian. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import "Header.h"
#import <JSPatchPlatform/JSPatch.h>
#import <JSPatchPlatform/JPEngine.h>
#import <AvoidCrash.h>
#import <UMCommon/UMCommon.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [JSPatch startWithAppKey:@"14a72f19b0b12504"];
    [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV23bjiocGpL/E/FuBnZCw+dku\na4raDYZ8/vs3wTUbNJrvuWN1lgKnhtbV3m08mSWU28ioIq2WFUtd0O4fVEIN38n3\nvP8Fy3ZMVEkc3UNolxJR7/fqnHSyVhdiPm9szUQtkwiNsk1iBG/QdgS5F53s/8G7\n1dIOkpq3zM8IQntQXQIDAQAB\n-----END PUBLIC KEY-----"];
#ifdef DEBUG
    [JSPatch setupDevelopment];
#endif
    [JSPatch sync];
    [[SocketTool share]initSocket];

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];


    [SVProgressHUD setMaximumDismissTimeInterval:2];

    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeClear)];
    IQKeyboardManager *mm =[IQKeyboardManager sharedManager];
    mm.enableAutoToolbar = 0;
    mm.shouldResignOnTouchOutside = 1;
    
    NSDictionary *dic = KOutObj(Klanguage);
    if (dic)
    {
        LoadVC *loadVC = [JCTool getViewControllerWithID:@"LoadVC"];
        self.window.rootViewController = loadVC;
    }else
    {
        NSDictionary *land = @{@"name":@"English",@"vaule":@"en",@"app":@"en",@"idx":@"2"};
        KSaveObj(land, Klanguage);
//        KSaveObj(@"en", @"AppleLanguages");
        
        UIViewController *vc = [JCTool getViewControllerWithID:@"LanguageVC" name:@"Login"];
        self.window.rootViewController = vc;
    }
    [self.window makeKeyAndVisible];
    [UMConfigure initWithAppkey:@"5dad170c4ca35793140003b0" channel:@"App Store"];
    [AvoidCrash becomeEffective];
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    [JSPatch sync];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
