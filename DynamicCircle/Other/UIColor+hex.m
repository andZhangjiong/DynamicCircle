//
//  UIColor+hex.m
//  seafishing2
//
//  Created by zhaoyk10 on 13-4-23.
//  Copyright (c) 2013年 Szfusion. All rights reserved.
//

#import "UIColor+hex.h"

@implementation UIColor (hex)

+ (UIColor*) colorWithHex:(long)hexColor {
    return [UIColor colorWithHex:hexColor alpha:1.0];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity {
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue alpha:(float)opacity {
    float _red = red / 255.0, _green = green / 255.0, _blue = blue / 255.0;
    return [UIColor colorWithRed:_red green:_green blue:_blue alpha:opacity];
}
 
+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue {
    return [UIColor colorWithIntRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)colorWithHexString: (NSString *)color {
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
@end
