
//
//  NYSAboutFooterView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/21.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSAboutFooterView.h"

@interface NYSAboutFooterView ()
@property (weak, nonatomic) IBOutlet UILabel *copyrightZH;
@property (weak, nonatomic) IBOutlet UILabel *copyrightEN;

@end

@implementation NYSAboutFooterView

- (void)drawRect:(CGRect)rect {
    self.copyrightZH.text = @"稻草堆 版权所有";
    // APP版权
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy"];
    self.copyrightEN.text = [NSString stringWithFormat:@"Copyright © %@ Daocaodui.All Rights Reserved", [format stringFromDate:date]];
}

@end
