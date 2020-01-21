//
//  NYSRegisterViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSRegisterViewController.h"
#import <SafariServices/SafariServices.h>
#import "NYSProtoclViewController.h"
#import "KHAlertPickerController.h"
#import "NYSFellowshipModel.h"
#import "NYSEmitterUtil.h"

@interface NYSRegisterViewController ()
@property (strong, nonatomic) NSMutableArray *fellowshipArray;

@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *oneTimeCode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *close;
@property (weak, nonatomic) IBOutlet UIView *getCodeView;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *fellowshipBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeProtocolBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)closeBtnClicked:(id)sender;
- (IBAction)getCodeButtonClicked:(id)sender;
- (IBAction)registerButtonClicked:(id)sender;

@property (nonatomic,assign) NSInteger secondsCountDownInput;
@property (nonatomic,strong) NSTimer *countDownTimer;

@end

@implementation NYSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.close.layer.cornerRadius = 15;
    self.getCodeView.layer.cornerRadius = 7;
    self.registerBtn.layer.cornerRadius = 7;
    self.fellowshipBtn.layer.cornerRadius = 7;
//    CALayer *layer = [self.fellowshipBtn layer];
//    layer.borderColor = [UIColor colorWithRed:0.26 green:0.74 blue:0.34 alpha:1.00].CGColor;
//    layer.borderWidth = 1.0f;
    
    UIScreenEdgePanGestureRecognizer *gobackRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(closeBtnClicked:)];
    gobackRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gobackRecognizer];
    
    // 加载团契列表
    [self loadFellowshipList];
}

- (IBAction)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)getCodeButtonClicked:(id)sender {
    [NYSRequest SendOneTimeCodeWithResMethod:GET parameters:@{@"phone":_phone.text} success:^(id response) {  
        self.getCodeView.backgroundColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00];
        self.getCodeButton.userInteractionEnabled = NO;
        self.secondsCountDownInput = 60;
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTriggerMethon) userInfo:nil repeats:YES];
    } failure:^(NSError *error) {
        
    } isCache:NO];
}

- (void)timerTriggerMethon {
    self.secondsCountDownInput --;
    [NYSTools animateTextChange:1.f withLayer:self.getCodeButton.layer];
    [self.getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒过期", self.secondsCountDownInput] forState:UIControlStateNormal];
    if (self.secondsCountDownInput <= 0) {
        [self.countDownTimer invalidate];
        [self.getCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
        self.getCodeView.backgroundColor = NNavBgColor;
        self.getCodeButton.userInteractionEnabled = YES;
    }
}

- (IBAction)registerButtonClicked:(id)sender {
    [NYSTools zoomToShow:sender];
    NSDictionary *param = @{@"fellowship" : @(self.fellowshipBtn.tag),
                            @"phone" : _phone.text,
                            @"onceCode" : _oneTimeCode.text,
                            @"password" : _password.text};
    [NYSRequest RegistWithResMethod:POST parameters:param success:^(id response) {
        [SVProgressHUD showSuccessWithStatus:[response objectForKey:@"msg"]];
        [SVProgressHUD dismissWithDelay:1.f completion:^{
            [NYSEmitterUtil showEmitterType:EmitterAnimationFire onView:self.view durationTime:5.f];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    } failure:^(NSError *error) {
        
    } isCache:NO];
}

- (IBAction)agreeProtocolBtnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.registerBtn.enabled = !sender.selected;
    self.registerBtn.backgroundColor = !sender.selected ? [UIColor clearColor] : [[UIColor lightGrayColor] colorWithAlphaComponent:0.1f];
}

- (IBAction)userProtoclClicked:(UIButton *)sender {
//    NYSProtoclViewController *protoclVC = NYSProtoclViewController.new;
//    protoclVC.protoclPDFFileName = @"UserPrivacyAgreement";
//    [self presentViewController:protoclVC animated:YES completion:nil];
    
    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:APPUserProtoclURL]];
    [self presentViewController:safariVc animated:YES completion:nil];
}

- (IBAction)fellowshipBtnClicked:(UIButton *)sender {
    if (!(self.fellowshipArray.count > 0)) {
        [self loadFellowshipList];
        [SVProgressHUD showWithStatus:@"loading..."];
        [SVProgressHUD dismissWithDelay:0.5f completion:^{
            [NYSTools shakToShow:sender];
        }];
        return;
    }
    NSMutableArray *titleArray = [NSMutableArray array];
    for (NYSFellowshipModel *fellowship in self.fellowshipArray) {
        [titleArray addObject:fellowship.fellowshipName];
    }
    
    KHAlertPickerController *alertPicker = [KHAlertPickerController  alertPickerWithTitle:@"选择团契" Separator:nil SourceArr:titleArray];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        for (NYSFellowshipModel *fellowship in self.fellowshipArray) {
            if ([fellowship.fellowshipName isEqualToString:alertPicker.contentStr]) {
                sender.tag = fellowship.idField;
            }
        }
        [self.fellowshipBtn setTitle:[NSString stringWithFormat:@"@%@", alertPicker.contentStr] forState:UIControlStateNormal];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"其他团契" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", @"18853936112"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
    [alertPicker addCompletionAction:sureAction];
    [alertPicker addCompletionAction:otherAction];
    [self presentViewController:alertPicker animated:YES completion:nil];
}

- (void)loadFellowshipList {
    WS(weakSelf);
    [NYSRequest GetFellowshipListWithResMethod:GET
                                    parameters:nil success:^(id response) {
        [NYSFellowshipModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        weakSelf.fellowshipArray = [NYSFellowshipModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        // 设置默认注册的团契（稻草堆：1）
        weakSelf.fellowshipBtn.tag = [[weakSelf.fellowshipArray firstObject] idField];
    } failure:^(NSError *error) {
        
    } isCache:YES];
}

@end
