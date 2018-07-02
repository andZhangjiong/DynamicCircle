//
//  NSString+SimpleModifier.m
//  ManagementSystem
//
//  Created by 俊欧巴 on 17/6/6.
//  Copyright © 2017年 俊欧巴. All rights reserved.
//

#import "NSString+SimpleModifier.h"

/*
 
 [囧]
 [愉快]
 [悠闲]
 
[嘴唇]
[跳跳][发抖][怄火][转圈]
*/

@implementation NSString (SimpleModifier)


+ (NSMutableDictionary *)retunTextDic
{
    NSMutableDictionary *mapper = [NSMutableDictionary new];
    mapper[@"[微笑]"] = @"im_ee_1";
    mapper[@"[撇嘴]"] = @"im_piezui";
    mapper[@"[色]"] = @"im_ee_3";
    mapper[@"[发呆]"] = @"im_ee_4";
    mapper[@"[得意]"] = @"im_ee_5";
    mapper[@"[流泪]"] = @"im_ee_6";
    mapper[@"[害羞]"] = @"im_ee_7";
    mapper[@"[闭嘴]"] = @"im_ee_8";
    mapper[@"[睡]"] = @"im_ee_9";
    mapper[@"[大哭]"] = @"im_ee_10";
    mapper[@"[尴尬]"] = @"im_ee_11";
    mapper[@"[发怒]"] = @"im_ee_12";
    mapper[@"[调皮]"] = @"im_ee_13";
    mapper[@"[龇牙]"] = @"im_ee_14";
    mapper[@"[惊讶]"] = @"im_ee_15";
    mapper[@"[难过]"] = @"im_ee_16";
    
    
    mapper[@"[酷]"] = @"im_ee_17";
    mapper[@"[冷汗]"] = @"im_ee_18";
    mapper[@"[抓狂]"] = @"im_ee_19";
    mapper[@"[吐]"] = @"im_ee_20";
    mapper[@"[偷笑]"] = @"im_ee_21";
    mapper[@"[可爱]"] = @"im_ee_22";
    mapper[@"[白眼]"] = @"im_ee_23";
    mapper[@"[傲慢]"] = @"im_ee_24";
    mapper[@"[饥饿]"] = @"im_ee_25";
    mapper[@"[困]"] = @"im_ee_26";
    mapper[@"[惊恐]"] = @"im_ee_27";
    mapper[@"[流汗]"] = @"im_ee_28";
    mapper[@"[憨笑]"] = @"im_ee_29";
    mapper[@"[大兵]"] = @"im_ee_30";
    mapper[@"[奋斗]"] = @"im_ee_31";
    mapper[@"[咒骂]"] = @"im_ee_32";
    mapper[@"[疑问]"] = @"im_ee_33";
    mapper[@"[嘘]"] = @"im_ee_34";
    mapper[@"[晕]"] = @"im_ee_35";
    mapper[@"[折磨]"] = @"im_ee_36";
    mapper[@"[衰]"] = @"im_ee_37";
    mapper[@"[骷髅]"] = @"im_ee_38";
    mapper[@"[敲打]"] = @"im_ee_39";
    mapper[@"[再见]"] = @"im_ee_40";
    mapper[@"[擦汗]"] = @"im_ee_41";
    mapper[@"[抠鼻]"] = @"im_ee_42";
    mapper[@"[鼓掌]"] = @"im_ee_43";
    mapper[@"[糗大了]"] = @"im_ee_44";
    mapper[@"[坏笑]"] = @"im_ee_45";
    mapper[@"[左哼哼]"] = @"im_ee_46";
    mapper[@"[右哼哼]"] = @"im_ee_47";
    mapper[@"[哈欠]"] = @"im_ee_48";
    mapper[@"[鄙视]"] = @"im_ee_49";
    mapper[@"[委屈]"] = @"im_ee_50";
    mapper[@"[快哭了]"] = @"im_ee_51";
    mapper[@"[阴险]"] = @"im_ee_52";
    mapper[@"[亲亲]"] = @"im_ee_53";
    mapper[@"[吓]"] = @"im_ee_54";
    mapper[@"[可怜]"] = @"im_ee_55";
    mapper[@"[菜刀]"] = @"im_ee_56";
    mapper[@"[西瓜]"] = @"im_ee_57";
    mapper[@"[啤酒]"] = @"im_ee_58";
    mapper[@"[篮球]"] = @"im_ee_59";
    mapper[@"[乒乓]"] = @"im_ee_60";
    mapper[@"[咖啡]"] = @"im_ee_61";
    mapper[@"[饭]"] = @"im_ee_62";
    mapper[@"[猪头]"] = @"im_ee_63";
    mapper[@"[玫瑰]"] = @"im_ee_64";
    mapper[@"[凋谢]"] = @"im_ee_65";
    mapper[@"[示爱]"] = @"im_ee_66";
    mapper[@"[爱心]"] = @"im_ee_67";
    mapper[@"[心碎]"] = @"im_ee_68";
    mapper[@"[蛋糕]"] = @"im_ee_69";
    mapper[@"[闪电]"] = @"im_ee_70";
    mapper[@"[炸弹]"] = @"im_ee_71";
    mapper[@"[刀]"] = @"im_ee_72";
    mapper[@"[足球]"] = @"im_ee_73";
    mapper[@"[瓢虫]"] = @"im_ee_74";
    mapper[@"[便便]"] = @"im_ee_75";
    mapper[@"[月亮]"] = @"im_ee_76";
    mapper[@"[太阳]"] =@"im_ee_77";
    mapper[@"[礼物]"] = @"im_ee_78";
    mapper[@"[拥抱]"] = @"im_ee_79";
    mapper[@"[强]"] = @"im_ee_80";
    mapper[@"[弱]"] = @"im_ee_81";
    mapper[@"[握手]"] = @"im_ee_82";
    mapper[@"[胜利]"] = @"im_ee_83";
    mapper[@"[抱拳]"] = @"im_ee_84";
    mapper[@"[勾引]"] = @"im_ee_85";
    mapper[@"[拳头]"] = @"im_ee_86";
    mapper[@"[差劲]"] = @"im_ee_87";
    mapper[@"[爱你]"] = @"im_ee_88";
    mapper[@"[NO]"] = @"im_ee_89";
    mapper[@"[OK]"] = @"im_ee_90";
    return mapper;
}

@end
