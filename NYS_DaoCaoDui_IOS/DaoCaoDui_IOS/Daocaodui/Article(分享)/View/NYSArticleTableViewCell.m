//
//  NYSArticleTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/15.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSArticleTableViewCell.h"
#import "NYSSDImageCacheHeader.h"

#define Radius 15.f
@interface NYSArticleTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroudImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIImageView *isTopImageview;

@end
@implementation NYSArticleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0,0);
    self.bgView.layer.shadowOpacity = 0.7f;
    self.bgView.layer.shadowRadius = 5.0f;
    self.bgView.layer.cornerRadius = Radius;

    self.backgroudImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroudImageView.layer.cornerRadius = Radius;
    self.backgroudImageView.layer.masksToBounds = YES;
    
    self.subtitle.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6f];
}

- (void)setArticleModel:(NYSArticleModel *)articleModel {
    _articleModel = articleModel;
    
    // 异步下载image(分享时使用)
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.articleModel.icon]
                                                          options:0
                                                         progress:nil
                                                        completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (data && finished) {
            // 磁盘缓存image
            [[SDImageCache sharedImageCache] storeImageDataToDisk:data forKey:[NSString stringWithFormat:@"%@_%ld", ShareImageCacheKey, (long)articleModel.idField]];
        }
    }];
    [self.backgroudImageView setImageWithURL:[NSURL URLWithString:articleModel.icon] placeholder:[UIImage imageNamed:@"doulist_cover_122x122_"]];
    [self.title setText:articleModel.title];
    [self.subtitle setText:articleModel.subtitle];
    self.isTopImageview.hidden = !articleModel.isTop;
}

@end
