//
//  AppDelegate.m
//  birdplanOC
//
//  Created by ygj on 2017/4/14.
//  Copyright © 2017年 zhoushijie. All rights reserved.
//

#import "AppDelegate.h"
#import "BDPMainTabViewController.h"
#import "NSString+BDPExtend.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (UIWindow *)mainWindow {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.window;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSString *str = @"  TESTT  ";
    NSSLog(@"%@",[str trim]);
    
    BDPMainTabViewController *mainController = [[BDPMainTabViewController alloc] init];
    mainController.view.backgroundColor = bdp_color_white;
    [mainController setNeedsStatusBarAppearanceUpdate];
    self.window.rootViewController = mainController;
    [self.window makeKeyAndVisible];
    
    
    //    UIViewController *mainController = [[UIViewController alloc] init];
    //    UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.medlinker.com/h5/interlocution/index.html?med_channel=shuidi3"]]];
    //    mainController.view = webView;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
