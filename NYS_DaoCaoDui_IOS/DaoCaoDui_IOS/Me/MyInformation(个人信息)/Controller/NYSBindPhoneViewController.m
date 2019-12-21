//
//  NYSBindPhoneViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/4.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSBindPhoneViewController.h"

@interface NYSBindPhoneViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *oneTimeCodeField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *affirmPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *oneTimeCodeBtn;

@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;

@property (weak, nonatomic) IBOutlet UIView *passwordView;

@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign) NSInteger countDownNum;
@property (nonatomic, strong) NSString *oneTimeCode;
@end

@implementation NYSBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机号绑定";
    
    [self addNavigationItemWithTitles:@[@"确认"] isLeft:NO target:self action:@selector(sureBtnClicked) tags:@[@"1111"]];
    
    self.phoneField.delegate = self;
    self.oneTimeCodeField.delegate = self;
    self.passwordField.delegate = self;
    self.affirmPasswordField.delegate = self;
    
    self.oneTimeCodeBtn.layer.cornerRadius = 5.0;
    self.oneTimeCodeBtn.layer.borderColor = NNavBgColor.CGColor;
    self.oneTimeCodeBtn.layer.borderWidth = 1.0f;
    
    self.passwordView.hidden = _isShowPasswordView ? NO : YES;
}

- (void)sureBtnClicked {
    if (self.oneTimeCode != self.oneTimeCodeField.text || self.oneTimeCode == nil) {
        [SVProgressHUD showInfoWithStatus:@"验证码错误"];
        [SVProgressHUD dismissWithDelay:.7f];
        return;
    }
    if (![self.passwordField.text isEqualToString:self.affirmPasswordField.text]) {
        [SVProgressHUD showInfoWithStatus:@"密码不一致"];
        [SVProgressHUD dismissWithDelay:.7f];
        return;
    }
    NSDictionary *parameters = _isShowPasswordView ? @{@"phone":self.phoneField.text, @"password":self.passwordField.text} : @{@"phone":self.phoneField.text};
    [NYSRequest UpdateUserInfoWithResMethod:POST
                                 parameters:parameters
                                    success:^(id response) {
        [SVProgressHUD showSuccessWithStatus:response[@"msg"]];
        [SVProgressHUD dismissWithDelay:.7f completion:^{
            [NUserManager saveUserInfo:response[@"data"]];
            [NUserManager loadUserInfo];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(NSError *error) {
        
    } isCache:NO];
}

- (IBAction)oneTimeCodeBtnClicked:(id)sender {
    [NYSRequest SendOneTimeCodeWithResMethod:GET parameters:@{@"phone":_phoneField.text} success:^(id response) {
        self.oneTimeCodeBtn.userInteractionEnabled = NO;
        self.countDownNum = 60;
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTriggerMethon) userInfo:nil repeats:YES];
        self.oneTimeCode = [response objectForKey:@"data"];
    } failure:^(NSError *error) {
        
    } isCache:NO];
}

/** 验证码倒计时显示 */
- (void)timerTriggerMethon {
    self.countDownNum --;
    [self.oneTimeCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重发", (long)self.countDownNum] forState:UIControlStateNormal];
    if (self.countDownNum <= 0) {
        [self.countDownTimer invalidate];
        [self.oneTimeCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.oneTimeCodeBtn.userInteractionEnabled = YES;
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= 11) {
        [NYSTools shakeAnimationWithLayer:textField.layer];
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // 准备开始输入  文本字段将成为第一响应者
    switch (textField.tag) {
        case 101:
            self.line1.backgroundColor = NNavBgColor;
            break;
            
        case 102:
            self.line2.backgroundColor = NNavBgColor;
            break;
            
        case 103:
            self.line3.backgroundColor = NNavBgColor;
            break;
            
        case 104:
            self.line4.backgroundColor = NNavBgColor;
            break;
            
        default:
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // 文本彻底结束编辑时调用
    switch (textField.tag) {
        case 101:
            self.line1.backgroundColor = UIColorFromHex(0xE2E2E3);
            break;
            
        case 102:
            self.line2.backgroundColor = UIColorFromHex(0xE2E2E3);
            break;
            
        case 103:
            self.line3.backgroundColor = UIColorFromHex(0xE2E2E3);
            break;
            
        case 104:
            self.line4.backgroundColor = UIColorFromHex(0xE2E2E3);
            break;
            
        default:
            break;
    }
}

@end
