//
//  NYSBibleChapterViewController.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/19.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYSBibleChapterViewController : NYSRootViewController
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) ONOXMLElement *book;
@property (nonatomic, strong) NSString *bookString;
@property (nonatomic, assign) NSInteger bookNumber;
@end

NS_ASSUME_NONNULL_END
