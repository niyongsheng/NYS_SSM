//
//  NYSRegisterViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSRegisterViewController.h"

@interface NYSRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *oneTimeCode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *close;
@property (weak, nonatomic) IBOutlet UIView *getCodeView;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
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
    
    UIScreenEdgePanGestureRecognizer *gobackRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(closeBtnClicked:)];
    gobackRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gobackRecognizer];
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
    [self.getCodeButton setTitle:[NSString stringWithFormat:@"%lds后重发", self.secondsCountDownInput] forState:UIControlStateNormal];
    if (self.secondsCountDownInput <= 0) {
        [self.countDownTimer invalidate];
        [self.getCodeButton setTitle:@"Get Code" forState:UIControlStateNormal];
        self.getCodeView.backgroundColor = NNavBgColor;
        self.getCodeButton.userInteractionEnabled = YES;
    }
}

- (IBAction)registerButtonClicked:(id)sender {
    [NYSTools zoomToShow:sender];
    NSDictionary *param = @{@"fellowship":@"1",
                            @"phone":_phone.text,
                            @"onceCode":_oneTimeCode.text,
                            @"password":_password.text};
    [NYSRequest RegistWithResMethod:POST parameters:param success:^(id response) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        
    } isCache:NO];
}

@end
