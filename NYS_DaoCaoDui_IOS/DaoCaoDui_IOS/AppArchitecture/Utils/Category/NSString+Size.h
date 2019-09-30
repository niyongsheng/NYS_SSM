//
//  NSString+Size.h
//  meituan
//
//  Created by jinzelu on 15/7/21.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

//+ (CGSize)boundingRectWithSize:(CGSize)size withFont:(UIFont *)font;

+ (CGFloat)getString:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont*)font width:(CGFloat)width;

+ (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width;

@end
