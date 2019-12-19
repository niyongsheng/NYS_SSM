//
//  NYSMeModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/1.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSMeModel : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *titleText;
/** 图标 */
@property (nonatomic, copy) NSString *titleIcon;
/** 内容 */
@property (nonatomic, copy) NSString *detailText;
/** 副图标(箭头) */
@property (nonatomic, copy) NSString *subIcon;

@end

NS_ASSUME_NONNULL_END
