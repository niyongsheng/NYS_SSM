//
//  NYSFellowshipModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/19.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSFellowshipModel : NSObject
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSObject * commemorationDay;
@property (nonatomic, strong) NSString * fellowshipLogo;
@property (nonatomic, strong) NSString * fellowshipName;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModify;
@property (nonatomic, strong) NSString * gps;
@property (nonatomic, assign) NSInteger grade;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * introduction;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSString * userIcon;
@end

NS_ASSUME_NONNULL_END
