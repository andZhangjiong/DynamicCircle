//
//  HXTool.m
//  DynamicCircle
//
//  Created by 张炯 on 2018/7/2.
//  Copyright © 2018年 张炯. All rights reserved.
//

#import "HXTool.h"

@implementation HXTool

//text 高度
+ (CGFloat)calculateTextHeightWithWidth:(CGFloat)width andText:(NSString *)text andFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size.height;
}

+ (CGFloat)calculateTextHeightWithWidth:(CGFloat)width andText:(NSString *)text attributes:(NSDictionary *)attribute
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size.height;
}

//text 宽度
+ (CGFloat)calculateTextWidthWithText:(NSString *)text andFont:(UIFont *)font
{
    if (!text || !font) {
        return 0.0f;
    }
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size.width + 2;
}

/**
 *  复制到剪切板
 *
 */
+ (void)generalPasteboard:(NSString *)location
{
    [UIPasteboard generalPasteboard].string = location;
}

@end
