//
//  NYSLoginViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSLoginViewController.h"
#import "NYSForgetPasswordViewController.h"
#import "NYSRegisterViewController.h"

@interface NYSLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)forgetPassword:(id)sender;
- (IBAction)regist:(id)sender;

- (IBAction)Login:(id)sender;
- (IBAction)wechatLogin:(id)sender;
- (IBAction)qqLogin:(id)sender;

@end

@implementation NYSLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.StatusBarStyle = UIStatusBarStyleDefault;
    self.account.delegate = self;
    
    UIScreenEdgePanGestureRecognizer *gobackRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPassword:)];
    gobackRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gobackRecognizer];
    
    UIScreenEdgePanGestureRecognizer *goforwardRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(regist:)];
    goforwardRecognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:goforwardRecognizer];
}

- (IBAction)forgetPassword:(id)sender {
    NYSForgetPasswordViewController *forgetVC = [[NYSForgetPasswordViewController alloc] init];
    forgetVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:forgetVC animated:YES completion:nil];
}

- (IBAction)regist:(id)sender {
    NYSRegisterViewController *registVC = [[NYSRegisterViewController alloc] init];
    registVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:registVC animated:YES completion:nil];
}

- (IBAction)Login:(id)sender {
    [NYSTools zoomToShow:sender];
    
    [NUserManager login:NUserLoginTypePwd params:@{@"phone":_account.text, @"password":_password.text} completion:^(BOOL success, id description) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [SVProgressHUD dismissWithDelay:1.f];
            NPostNotification(NNotificationLoginStateChange, @YES)
        } else {
//            [MBProgressHUD showErrorMessage:description];
        }
    }];
}

- (IBAction)wechatLogin:(id)sender {
    [NUserManager login:NUserLoginTypeWeChat completion:^(BOOL success, id description) {
        if (success) {
            NPostNotification(NNotificationLoginStateChange, @YES)
        } else {
            [MBProgressHUD showErrorMessage:description];
        }
    }];
}

- (IBAction)qqLogin:(id)sender {
    [NUserManager login:NUserLoginTypeQQ completion:^(BOOL success, id description) {
        if (success) {
            NPostNotification(NNotificationLoginStateChange, @YES)
        } else {
            [MBProgressHUD showErrorMessage:description];
        }
    }];
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= 11) {
        [NYSTools shakeAnimationWithLayer:textField.layer];
        return NO;
    }
    return YES;
}


@end
