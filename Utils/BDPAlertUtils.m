//
//  SDBAlertUtils.m
//  sdbao
//
//  Created by ygj on 2017/7/19.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "BDPAlertUtils.h"
#import "AppDelegate.h"

@implementation BDPAlertUtils

+ (void)presentAlertWithMessage:(NSString *)msg ctrl:(UIViewController *)ctrl {
  // 危险操作:弹框提醒
  // 1.UIAlertView
  // 2.UIActionSheet
  // iOS8开始:UIAlertController == UIAlertView + UIActionSheet
  if (!ctrl) {
    ctrl = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
  }
  if (ctrl) {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
      NSLog(@"点击了确定按钮--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
      NSLog(@"点击了取消按钮");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"其它" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      NSLog(@"点击了其它按钮");
    }]];
//
//    // 添加文本框
//    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//      textField.textColor = [UIColor redColor];
//      textField.text = @"123";
//      [textField addTarget:self action:@selector(usernameDidChange:) forControlEvents:UIControlEventEditingChanged];
//      //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(usernameDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
//    }];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//      textField.secureTextEntry = YES;
//      textField.text = @"123";
//    }];
    [ctrl presentViewController:alert animated:YES completion:nil];
  }
}

+ (void)genTestButtonInView:(UIView *)view method:(id)method {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [button setTitle:@"Go to App Store" forState:UIControlStateNormal];
  [button setFrame:CGRectMake(0.0, 0.0, 200.0, 44.0)];
  [button setCenter:view.center];
  [view addSubview:button];
  [button addTarget:self action:@selector(method) forControlEvents:UIControlEventTouchUpInside];
}

@end
