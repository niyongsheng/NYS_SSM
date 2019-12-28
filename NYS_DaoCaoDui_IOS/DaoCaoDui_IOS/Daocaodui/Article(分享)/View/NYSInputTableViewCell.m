//
//  NYSInputTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/24.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSInputTableViewCell.h"

@implementation NYSInputTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.requiredLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

}

@end
