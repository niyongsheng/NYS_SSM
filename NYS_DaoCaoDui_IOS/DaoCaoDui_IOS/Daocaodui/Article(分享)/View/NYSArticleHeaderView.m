//
//  NYSArticleHeaderView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/15.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSArticleHeaderView.h"

@interface NYSArticleHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroudImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleContraint;

@end
@implementation NYSArticleHeaderView

- (void)drawRect:(CGRect)rect {
    self.backgroudImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.titleContraint.constant = NStatusBarHeight + 15;
}

- (void)setArticleModel:(NYSArticleModel *)articleModel {
    _articleModel = articleModel;
    
    [self.backgroudImageView setImageWithURL:[NSURL URLWithString:articleModel.icon] placeholder:[UIImage imageNamed:@"placeholder"]];
    [self.title setText:articleModel.title];
    [self.subtitle setText:articleModel.subtitle];
}

@end
