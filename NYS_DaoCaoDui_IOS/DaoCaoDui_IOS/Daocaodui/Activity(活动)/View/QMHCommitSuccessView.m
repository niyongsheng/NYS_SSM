//
//  QMHCommitSuccessView.m
//  安居公社
//
//  Created by 倪刚 on 2018/4/28.
//  Copyright © 2018年 QingMai. All rights reserved.
//

#import "QMHCommitSuccessView.h"

@interface QMHCommitSuccessView ()

@property (weak, nonatomic) IBOutlet UIView *popUPView;
@property (weak, nonatomic) IBOutlet UILabel *popTitle;
@property (weak, nonatomic) IBOutlet UILabel *popMessages;
@property (weak, nonatomic) IBOutlet UILabel *sucessTitle;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation QMHCommitSuccessView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 灰色遮罩
    self.frame = CGRectMake(0, 0, NScreenWidth, NScreenHeight);
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
}

- (void)drawRect:(CGRect)rect {
    self.popUPView.layer.cornerRadius = 15.f;
    self.popUPView.clipsToBounds = YES;
}

- (void)setTitleString:(NSString *)popTitleString sucessTitleString:(NSString *)sucessTitleString popMessagesString:(NSString *)popMessagesString {
    self.popTitle.text = popTitleString;
    self.sucessTitle.text = sucessTitleString;
    self.popMessages.text = popMessagesString;
}

- (void)closeButtonForSendData:(id)target action:(SEL)action {
    [self.closeButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
