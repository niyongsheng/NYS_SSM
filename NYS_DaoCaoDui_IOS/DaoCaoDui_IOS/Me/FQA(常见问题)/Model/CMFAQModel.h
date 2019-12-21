//
//  CMFAQ.h
//  CreditMoney
//
//  Created by 倪永胜 on 2019/4/29.
//  Copyright © 2019 QM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMFAQModel : NSObject
/** 序号 */
@property (nonatomic, copy) NSNumber *index;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 描述 */
@property (nonatomic, copy) NSString *desc;

/** 展开 */
@property (nonatomic, assign) BOOL expanded;

@end

NS_ASSUME_NONNULL_END
