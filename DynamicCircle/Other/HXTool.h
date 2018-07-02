//
//  HXTool.h
//  DynamicCircle
//
//  Created by 张炯 on 2018/7/2.
//  Copyright © 2018年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXTool : NSObject

/**
 *  text 高度
 */
+ (CGFloat)calculateTextHeightWithWidth:(CGFloat)width andText:(NSString *)text andFont:(UIFont *)font;

/**
 *  text 高度
 *
 *  attribute
 */
+ (CGFloat)calculateTextHeightWithWidth:(CGFloat)width andText:(NSString *)text attributes:(NSDictionary *)attribute;

/**
 *  text 宽度
 */
+ (CGFloat)calculateTextWidthWithText:(NSString *)text andFont:(UIFont *)font;

/**
 *  复制到剪切板
 *
 */
+ (void)generalPasteboard:(NSString *)location;

@end
