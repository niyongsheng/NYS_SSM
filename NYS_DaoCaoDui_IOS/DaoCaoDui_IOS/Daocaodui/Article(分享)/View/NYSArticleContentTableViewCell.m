//
//  NYSArticleContentTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/15.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSArticleContentTableViewCell.h"

@interface NYSArticleContentTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation NYSArticleContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = NFontSize17;
}

- (void)setContentString:(NSString *)contentString {
    _contentString = contentString;
    
    self.contentLabel.text = contentString;
}

@end
