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
#import <AuthenticationServices/AuthenticationServices.h>
#import "NYSSignHandleKeyChain.h"

API_AVAILABLE(ios(13.0))
@interface NYSLoginViewController () <UITextFieldDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>
@property (weak, nonatomic) IBOutlet UIView *thirdLoginView;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
/// SignInWithAppleBtn
@property (strong, nonatomic) ASAuthorizationAppleIDButton *appleIDBtn;

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
//    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customStatusBarStyle = UIStatusBarStyleDefault;
    self.account.delegate = self;
    
    UIScreenEdgePanGestureRecognizer *gobackRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPassword:)];
    gobackRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gobackRecognizer];
    
    UIScreenEdgePanGestureRecognizer *goforwardRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(regist:)];
    goforwardRecognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:goforwardRecognizer];

    [self.view addSubview:self.appleIDBtn];
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
    
    [NUserManager login:NUserLoginTypePwd
                 params:@{@"phone":_account.text, @"password":_password.text}
             completion:^(BOOL success, id description) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [SVProgressHUD dismissWithDelay:1.f];
            NPostNotification(NNotificationLoginStateChange, @YES)
        }
    }];
}

- (IBAction)wechatLogin:(id)sender {
    [NUserManager login:NUserLoginTypeWeChat completion:^(BOOL success, id description) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"QQ登录成功"];
            [SVProgressHUD dismissWithDelay:1.f];
            NPostNotification(NNotificationLoginStateChange, @YES)
        }
    }];
}

- (IBAction)qqLogin:(id)sender {
    [NUserManager login:NUserLoginTypeQQ completion:^(BOOL success, id description) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"微信登录成功"];
            [SVProgressHUD dismissWithDelay:1.f];
            NPostNotification(NNotificationLoginStateChange, @YES)
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

#pragma mark - Getter
- (ASAuthorizationAppleIDButton *)appleIDBtn API_AVAILABLE(ios(13.0)) {
    if (!_appleIDBtn) {
        _appleIDBtn = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhiteOutline];
        _appleIDBtn.frame = CGRectMake(NScreenWidth/2 - 65, CGRectGetMaxY(self.loginBtn.frame) + 10, 130, 35);
        [_appleIDBtn addTarget:self action:@selector(appleIDBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appleIDBtn;
}

- (void)appleIDBtnClicked:(ASAuthorizationAppleIDButton *)sender API_AVAILABLE(ios(13.0)) {
    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 在用户授权期间请求的联系信息
        appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        
        // 需要考虑已经登录过的用户，可以直接使用keychain密码来进行登录
        ASAuthorizationPasswordProvider *appleIDPasswordProvider = [ASAuthorizationPasswordProvider new];
        ASAuthorizationPasswordRequest *passwordRequest = appleIDPasswordProvider.createRequest;
        
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest]];
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
    }
}

#pragma mark - delegate
/// 授权成功地回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        // 用户登录使用ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *appleIDCredential = (ASAuthorizationAppleIDCredential *)authorization.credential;
        NSString *appleUserId = appleIDCredential.user;
        NSString *familyName = appleIDCredential.fullName.familyName;
        NSString *givenName = appleIDCredential.fullName.givenName;
        NSString *email = appleIDCredential.email;
        NSData *identityToken = appleIDCredential.identityToken;
        NSData *authorizationCode = appleIDCredential.authorizationCode;
        // 需要使用钥匙串的方式保存userIdentifier
        [NYSSignHandleKeyChain save:KEYCHAIN_IDENTIFIER(@"SignInWithApple") data:appleUserId];
        // 登录请求
        [NUserManager login:NUserLoginTypeApple
                     params:@{@"appleUserId" : appleUserId ? appleUserId : @"",
                              @"familyName" : familyName ? familyName : @"",
                              @"givenName" : givenName ? givenName : @"",
                              @"email" : email ? email : @""}
                 completion:^(BOOL success, id description) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"Apple登录成功"];
                [SVProgressHUD dismissWithDelay:1.f];
                NPostNotification(NNotificationLoginStateChange, @YES)
            }
        }];
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        // Sign in using an existing iCloud Keychain credential.
        // 用户登录使用现有的密码凭证
        ASPasswordCredential *passwordCredential = (ASPasswordCredential *)authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString *appleUserId = passwordCredential.user;
        // 密码凭证对象的密码
        NSString *appleUserPassword = passwordCredential.password;
        // 登录请求
        [NUserManager login:NUserLoginTypeApple
                     params:@{@"appleUserId" : appleUserId ? appleUserId : @"",
                              @"appleUserPassword" : appleUserPassword ? appleUserPassword : @""}
                 completion:^(BOOL success, id description) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"Apple登录成功"];
                [SVProgressHUD dismissWithDelay:1.f];
                NPostNotification(NNotificationLoginStateChange, @YES)
            }
        }];
    } else {
        [SVProgressHUD showInfoWithStatus:@"授权信息均不符"];
        [SVProgressHUD dismissWithDelay:1.f];
    }
}

/// 授权失败的回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    // Handle error.
    NSLog(@"Handle error：%@", error);
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
            
        default:
            break;
    }
    [MBProgressHUD showTopTipMessage:errorMsg isWindow:YES];
}

/// 通知代理在哪个window 展示内容给用户
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)) {
    // 返回window
    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
       if (windowScene.activationState == UISceneActivationStateForegroundActive)
       {
          UIWindow *window = windowScene.windows.firstObject;
          return window;
       }
    }
    return nil;
}

@end
