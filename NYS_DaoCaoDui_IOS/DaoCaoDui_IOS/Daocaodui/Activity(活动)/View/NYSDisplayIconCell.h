//
//  NYSUploadImageCell.h
//  28ChatRoom
//
//  Created by 倪永胜 on 2018/12/4.
//  Copyright © 2018 qingmai. All rights reserved.
//

#import <XLForm.h>
#import "XLFormBaseCell.h"

extern NSString *const XLFormRowDescriptorTypeDisplayIcon;

@interface NYSDisplayIconCell : XLFormBaseCell
@property (weak, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@end
