//
//  HXDynamic.m
//  DynamicCircle
//
//  Created by 张炯 on 2018/7/2.
//  Copyright © 2018年 张炯. All rights reserved.
//

#import "HXDynamic.h"

#import "RegexKitLite.h"
#import "NSString+SimpleModifier.h"

#define     WIDTH_MOMENT_CONTENT        (WIDTH_SCREEN - 70.0f)




@implementation HXDynamic

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             };
}

+ (NSMutableArray *)getLocalData
{
    NSMutableArray *datas = @[].mutableCopy;
    
    NSError *error;
    NSString *jsonString = [NSString
                            stringWithContentsOfFile:[[NSBundle mainBundle]
                                                      pathForResource:@"index3"
                                                      ofType:@"txt"]
                            encoding:NSUTF8StringEncoding
                            error: & error];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
    
    NSMutableDictionary *retunTextDic = [NSString retunTextDic];
    
    for (NSDictionary *dict in retDict[@"data"]) {
        HXDynamic *model = [self setupDictionary:dict retunTextDic:retunTextDic];
        [datas addObject:model];
    }
    return datas;
}

+ (HXDynamic *)setupDictionary:(NSDictionary *)dict retunTextDic:(NSDictionary *)retunTextDic
{
    HXDynamic *model = [[self alloc] init];
    [model mj_setKeyValues:dict];
    
    NSArray *photos = @[
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530526601952&di=a6a93482c5a4f17a8328c7ee47392b6e&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201512%2F10%2F20151210131006_xzeKh.jpeg",
                       
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530526601952&di=1a9820a1ca46219353735d2715f2885b&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201512%2F13%2F20151213190125_KcZnY.jpeg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530526601951&di=e4af85c96d723603268cc1d8acb80b37&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201501%2F14%2F20150114145326_sQPjW.jpeg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530526601951&di=d29fda16c3b73b2686c2868016a4b3d1&imgtype=0&src=http%3A%2F%2Fimg4q.duitang.com%2Fuploads%2Fitem%2F201503%2F22%2F20150322100452_ezcWW.jpeg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530526601951&di=666f78a8b525833246e0bef32927302d&imgtype=0&src=http%3A%2F%2Fcdnq.duitang.com%2Fuploads%2Fitem%2F201505%2F14%2F20150514204900_wVZKH.jpeg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530526601951&di=2f0917940c280150faf4ab9e0fd89f7c&imgtype=0&src=http%3A%2F%2Fimg4q.duitang.com%2Fuploads%2Fitem%2F201504%2F14%2F20150414H2406_rKehA.jpeg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530526601951&di=c388e1515d6d3eab2c267dfce6f62e11&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201502%2F23%2F20150223104305_CEAN2.thumb.700_0.jpeg",
                       @"http://img5.duitang.com/uploads/item/201508/09/20150809005334_rxVJH.jpeg",
                       @"http://img4.duitang.com/uploads/item/201510/03/20151003183452_kHSJE.jpeg",
                       @"http://p1.qqyou.com/touxiang/UploadPic/2014-7/18/201407182008422829.jpg"
                       ];
    
    int i = rand() % (photos.count-1);
    
    model.retunTextDic = retunTextDic.copy;
    model.photoUrl = [NSString stringWithFormat:@"%@",photos[i]];
    
    NSArray *names = @[@"张译",@"阿菁Yatching",@"我是一个小小的战士",@"BOOM-大王喵",@"总有一种不好的预感",@"永恒的神奇之星",@"励志成为一个有文化有内涵的人",@"巨兔兔子__saki",@"ok有事吗",@"Shimmmmmi",@"小仙女游乐园",@"produce48"];
    
    i = rand() % (names.count-1);
    
    model.nickname = names[i];
    
    [model setUpDynamicFrame];
    
    return model;
}

- (void)setattributedTextWithHeight:(CGFloat)isShowAllAttributedText
{
    UILabel *templateLabel = [[UILabel alloc] init];
    templateLabel.frame = CGRectMake(0, 0, _maxWidth, 0);
    templateLabel.attributedText = self.attributedText;
    templateLabel.numberOfLines = isShowAllAttributedText ? 0 : 6;
    [templateLabel sizeToFit];
    _contentSize.height = templateLabel.height+10;
    
    _isShowAllAttributedText = isShowAllAttributedText;
    
    if (_praiseetrHeight || _commtentViewH) {
        _commtentTopViewH =  [UIImage imageNamed:@"icon_circle_triangle"].size.height;
    }
    else {
        _commtentTopViewH = 0;
    }
    
    [self setUpCellHeight];
}



#pragma mark - Setter

- (void)setUpCellHeight
{
    self.height = 40 + _contentSize.height + _addressH + _timeH + _allcontentButtonH + _spicpathHeight + _praiseetrHeight + _commtentTopViewH + _commtentViewH  + 15;
    if (!_content.length) {
        self.height += 7;// 图片与顶部名称间隙
    }
    else {
        self.height += 5; // 图片与文字间隙
    }
}

- (void)setUpDynamicFrame
{
    // 1. nickname
    _nicknameW = [HXTool calculateTextWidthWithText:_nickname
                                            andFont:[UIFont boldSystemFontOfSize:14]];
    
    // 2. content
    _allcontentButtonH = 0.0f;
    _contentSize = (CGSize){0,0};
    
    if (_content.length) {
        
        UILabel *templateLabel = [[UILabel alloc] init];
        
        _maxWidth = WIDTH_MOMENT_CONTENT - 5;
        _attributedText = [self attributedTextWithText:_content].mutableCopy;

        templateLabel.frame = CGRectMake(0, 0, _maxWidth, 0);
        templateLabel.attributedText = self.attributedText;
        templateLabel.numberOfLines = 0;
        [templateLabel sizeToFit];
        
        CGFloat textAllHeight = templateLabel.height;
        
        templateLabel.numberOfLines = 6;
        [templateLabel sizeToFit];
        
        if (textAllHeight > templateLabel.height) {
            // 大于六行
            _isShowAllButton = NO;
            _allcontentButtonH = 20;
        }
        else {
            _isShowAllButton = YES;
        }
        _contentSize =(CGSize){_maxWidth, templateLabel.height+10}; // 内容显示6行高度
    }
    else {
        _isShowAllButton = YES;
    }
    
    self.height = 40 + _contentSize.height + _addressH + _timeH + _allcontentButtonH + _spicpathHeight + _praiseetrHeight + _commtentTopViewH + _commtentViewH  + 15;
    
    if (!_content.length) {
        self.height += 7;// 图片与顶部名称间隙
    }
    else {
        self.height += 5; // 图片与文字间隙
    }
    
    // 3. location
    _addressH = 0.0f;
    _addressW = 0.0f;
    if (_location.length) {
        _addressW = [HXTool calculateTextWidthWithText:_location andFont:[UIFont systemFontOfSize:13]];
        _addressH = 25; // 地址高度  25
        
        if (_addressW > _maxWidth) {
            _addressW = _maxWidth;
        }
    }
    
    // 4. pubdate
    self.timeW = 0.0f;
    self.timeW = [HXTool calculateTextWidthWithText:_pubdate andFont:[UIFont systemFontOfSize:13]];
    _timeH = 20;
    
    // 5. spicpath
    _spicpathHeight = [self heightImages];
    
    // 6. praise
    NSMutableString *praisestr = @"".mutableCopy;
    for (NSDictionary *praise in _praiselist) {
        if (praisestr.length) {
            [praisestr appendString:[NSString stringWithFormat:@",  %@",praise[@"nickname"]]];
        }
        else {
            [praisestr appendString:[NSString stringWithFormat:@"%@",praise[@"nickname"]]];
        }
    }
    
    _praisestr = praisestr;
    
    if (_praiselist.count) {
        
        CGFloat icon_circle_like = [UIImage imageNamed:@"icon_circle_like"].size.width;
        CGFloat w = WIDTH_SCREEN - (5 + icon_circle_like + 7) - 80;
        _praiseAttributed = [self attributeStringWithContent:_praisestr keyWords:[_praisestr componentsSeparatedByString:@",  "]];
        _praiseetrHeight = [_praiseAttributed boundingRectWithSize:CGSizeMake(w, MAXFLOAT)
                                                           options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height+10;
    }
    else {
        _praiseetrHeight = 0.0f;
    }
    
    // 7. comment
    _commentModels = @[].mutableCopy;
    _commtentViewH = 0.0f;
    
    NSInteger tag = 0;
    for (NSDictionary *commtent in _webChatCommentInfoList) {
        HXNewDynamicCircleComment *model = [HXNewDynamicCircleComment new];
       
        model.retunTextDic = _retunTextDic;
        model.index = tag;
        
        [model mj_setKeyValues:commtent];
        
        [model setUpCommtentFrame];
        
        [_commentModels addObject:model];
        
        _commtentViewH += model.height;
        ++tag;
    }
    
    if (_praiseetrHeight || _commtentViewH) {
        _commtentTopViewH =  [UIImage imageNamed:@"icon_circle_triangle"].size.height;
    }
    else {
        _commtentTopViewH = 0;
    }
    
    // 8. cell
    self.height = 40 + _contentSize.height + _addressH + _timeH + _allcontentButtonH + _spicpathHeight + _praiseetrHeight + _commtentTopViewH + _commtentViewH  + 15;
    if (!_content.length) {
        self.height += 7;// 图片与顶部名称间隙
    }
    else {
        self.height += 5; // 图片与文字间隙
    }
}

#pragma mark expand

/**
 *  特殊文字&表情处理
 *
 *  @param text 正本内容
 *
 *  @return attributedString
 */
- (NSMutableAttributedString *)attributedTextWithText:(NSString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    
    NSString *urlPattern = kRegulaURLStr;
    NSString *phoneNumber = kRegulaPhoneStr;
    
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@", emotionPattern, urlPattern,phoneNumber];
    
    // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        ZLTextPart *part = [[ZLTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    if (!parts.count) {
        NSMutableAttributedString *newAttributedText = [[NSMutableAttributedString alloc] initWithString:text];
        [newAttributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, newAttributedText.length)];
        return newAttributedText;
    }
    
    // 遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        ZLTextPart *part = [[ZLTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    // 排序
    // 系统是按照从小 -> 大的顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(ZLTextPart *part1, ZLTextPart *part2) {
        
        if (part1.range.location > part2.range.location) {
            // part1>part2
            // part1放后面, part2放前面
            return NSOrderedDescending;
        }
        // part1<part2
        // part1放前面, part2放后面
        return NSOrderedAscending;
    }];
    
    UIFont *font = [UIFont systemFontOfSize:15];
    NSMutableArray *specials = [NSMutableArray array];
    
    // 按顺序拼接每一段文字
    NSDictionary *dict = _retunTextDic;
    for (ZLTextPart *part in parts) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
            NSString *str = [text substringWithRange:part.range];
            UIImage *image = [UIImage imageNamed:dict[str]];
            if (image) {
                //新建文字附件来存放我们的图片,iOS7才新加的对象
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                //给附件添加图片
                textAttachment.image = image;
                //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
                textAttachment.bounds = CGRectMake(0, -6, 20, 20);
                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                substr = [NSAttributedString attributedStringWithAttachment:textAttachment];
            }
        } else if (part.special) { // 非表情的特殊文字
            
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName : [UIColor colorWithHex:0x046363]
                                                                                       }];
            // 创建特殊对象
            ZLSpecial *s = [[ZLSpecial alloc] init];
            s.text = part.text;
            NSUInteger loc = attributedText.length;
            NSUInteger len = part.text.length;
            s.range = NSMakeRange(loc, len);
            s.urlString = part.text;
            [specials addObject:s];
            
        } else { // 非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName : [UIColor colorWithHex:0x292929]
                                                                                       }];
        }
        if (substr) {
            [attributedText appendAttributedString:substr];
        }
    }
    
    // 一定要设置字体,保证计算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    if (specials.count) {
        [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    }
    return attributedText;
}

/**
 *  特殊文字处理
 *
 *  @param content 点赞文字
 *
 *  @return attributedString
 */
- (NSMutableAttributedString *)attributeStringWithContent:(NSString *)content keyWords:(NSArray *)keyWords
{
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    NSMutableArray *parts = @[].mutableCopy;
    NSInteger i = 0;
    for (NSString *text in keyWords) {
        
        ZLTextPart *part = [[ZLTextPart alloc] init];
        part.text = text;
        part.special = YES;
        part.range = [content rangeOfString:part.text];
        [parts addObject:part];
        
        if (i != keyWords.count-1) {
            ZLTextPart *_part = [[ZLTextPart alloc] init];
            _part.text = @",  ";
            _part.range = [content rangeOfString:_part.text];
            [parts addObject:_part];
        }
        ++i;
    }
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    NSMutableArray *specials = [NSMutableArray array];
    // 按顺序拼接每一段文字
    for (ZLTextPart *part in parts) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.special) { // 非表情的特殊文字
            
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName:[UIColor colorWithHex:0x046363]
                                                                                       }];
            // 创建特殊对象
            ZLSpecial *s = [[ZLSpecial alloc] init];
            s.text = part.text;
            NSUInteger loc = attributedText.length;
            NSUInteger len = part.text.length;
            s.range = NSMakeRange(loc, len);
            s.urlString = part.text;
            [specials addObject:s];
        } else { // 非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName:[UIColor colorWithHex:0x292929]
                                                                                       }];
        }
        if (substr) {
            [attributedText appendAttributedString:substr];
        }
    }
    
    // 一定要设置字体,保证计算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    
    return attributedText;
}

- (CGFloat)heightImages
{
    CGFloat height = 0.0f;
    if (_spicpath.count > 0) {
        height += 3.0f;
        CGFloat space = 4.0;
        if (_spicpath.count == 1) {
            
            CGFloat width_img = 0.0f;
            CGFloat height_img = 0.0f;
            
            if (_imginfo) {
                NSArray *array = [_imginfo componentsSeparatedByString:@","];
                if (array.count && array.count == 2) {
                    width_img = [array.firstObject floatValue];
                    height_img  = [array.lastObject floatValue];
                }
            }
            
            CGFloat max_image_w = (WIDTH_SCREEN - 70.0f - 130);
            if (height_img > 0 && width_img > 0) {
                
                if (height_img < width_img) {
                    // 宽图
                    if (width_img > max_image_w) { // 宽图超过最大值
                        _width_img = max_image_w;
                    }
                    else {
                        _width_img = width_img;
                    }
                    
                    height_img = _width_img / width_img * height_img;
                }
                else {
                    // 长图
                    CGFloat max_image_h = (HEIGHT_SCREEN ) * 0.3;
                    
                    _width_img = max_image_h / height_img  * width_img;
                    
                    if (_width_img > max_image_w) { // 长图的宽 超过最大值  按宽图来等比缩放
                        _width_img = max_image_w;
                        height_img = max_image_w / width_img * height_img;
                    }
                    else {
                        if (height_img > max_image_h) {  // 长图 超过最大值
                            if (_width_img * 3 < max_image_h) {  // 超长图处理
                                if (width_img > max_image_w/2) {
                                    _width_img = max_image_w/2;
                                }
                                height_img = _width_img / WIDTH_SCREEN * HEIGHT_SCREEN;
                            }
                            else {
                                height_img = max_image_h;
                            }
                        }
                    }
                }
                _height_img = height_img;
                height += height_img;
            }
            else {
                height += WIDTH_MOMENT_CONTENT * 0.4 / WIDTH_SCREEN * HEIGHT_SCREEN;
            }
        }
        else {
            NSInteger row = (_spicpath.count / 3) + (_spicpath.count % 3 == 0 ? 0 : 1);
            height += (WIDTH_MOMENT_CONTENT * 0.31 * row + space * (row - 1));
        }
    }
    return height;
}

@end



@implementation ZLTextPart

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}

@end



@implementation ZLSpecial

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end



@implementation HXNewDynamicCircleComment

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             };
}

- (void)setUpCommtentFrame
{
    if (_content.length && _nickname.length) {
        NSArray *keyWords = @[];
        NSMutableString *str = [[NSMutableString alloc] init];
        if (self.replyuid.length > 0 && _replynickname.length > 0) {
            [str appendFormat:@"%@ 回复 %@ : ", _nickname,_replynickname];
            keyWords = @[_nickname,@" 回复 ",_replynickname,@" : "];
        }
        else {
            [str appendFormat:@"%@: ", _nickname];
            keyWords = @[_nickname, @": "];
        }
        _allcontent = [NSString stringWithFormat:@"%@%@",str,_content];
        _commtentAttributedString = [self attributeStringWithAllContent:_allcontent keyWords:keyWords];
        
        CGFloat w = WIDTH_SCREEN - 85;
        _height = [_commtentAttributedString boundingRectWithSize:CGSizeMake(w, MAXFLOAT)
                                                          options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height+5;
    }
}

- (NSMutableAttributedString *)attributeStringWithAllContent:(NSString *)content keyWords:(NSArray *)keyWords
{
    NSMutableArray *parts = [NSMutableArray array];
    if (keyWords.count) {
        
        NSInteger i = 0;
        NSInteger loct = 0;
        for (NSString *string in keyWords) {
            
            ZLTextPart *part = [[ZLTextPart alloc] init];
            part.text = string;
            part.range = NSMakeRange(loct, string.length);
            [parts addObject:part];
            
            loct += string.length;
            
            if (i == 0 || i == 2) {
                part.special = YES;
                part.emotion = NO;
                part.name = YES;
            }
            
            ++i;
        }
    }
    return [self attributedTextWithText:_content WithParts:parts];
}

/**
 *  普通文字 --> 属性文字
 *
 *  @param text 普通文字
 *
 *  @return 属性文字
 */
- (NSMutableAttributedString *)attributedTextWithText:(NSString *)text WithParts:(NSArray *)partNames
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    
    NSString *urlPattern = kRegulaURLStr;
    NSString *phoneNumber = kRegulaPhoneStr;
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@", emotionPattern, urlPattern,phoneNumber];
    
    // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [parts addObjectsFromArray:partNames];
    
    ZLTextPart *namePart = partNames.lastObject;
    
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        ZLTextPart *part = [[ZLTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        
        // 内容从name开始算起
        NSRange range = *capturedRanges;
        range.location = namePart.range.location+range.location;
        
        part.range = range;
        [parts addObject:part];
    }];
    
    // 遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        ZLTextPart *part = [[ZLTextPart alloc] init];
        part.text = *capturedStrings;
        
        // 内容从name开始算起
        NSRange range = *capturedRanges;
        range.location = namePart.range.location+range.location;
        
        part.range = range;
        [parts addObject:part];
    }];
    
    // 排序
    // 系统是按照从小 -> 大的顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(ZLTextPart *part1, ZLTextPart *part2) {
        if (part1.range.location > part2.range.location) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    NSMutableArray *specials = [NSMutableArray array];
    // 按顺序拼接每一段文字
    NSDictionary *dict = _retunTextDic;
    for (ZLTextPart *part in parts) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
            NSString *str = part.text;
            UIImage *image = [UIImage imageNamed:dict[str]];
            if (image) {
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                textAttachment.image = image;
                textAttachment.bounds = CGRectMake(0, -6, 20, 20);
                substr = [NSAttributedString attributedStringWithAttachment:textAttachment];
            }
        } else if (part.special) { // 非表情的特殊文字
            
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName:[UIColor colorWithHex:0x046363]
                                                                                       }];
            // 创建特殊对象
            ZLSpecial *s = [[ZLSpecial alloc] init];
            s.text = part.text;
            NSUInteger loc = attributedText.length;
            NSUInteger len = part.text.length;
            s.range = NSMakeRange(loc, len);
            s.urlString = part.text;
            [specials addObject:s];
            
            if (part.name) {
                s.type = @"name";
            }
            
        } else { // 非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName:[UIColor colorWithHex:0x292929]
                                                                                       }];
        }
        if (substr) {
            [attributedText appendAttributedString:substr];
        }
    }
    
    // 一定要设置字体,保证计算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    
    return attributedText;
}

@end
