//
//  HXLabel.m
//  HongXun
//
//  Created by 张炯 on 2018/1/18.
//



#import "HXLabel.h"

#define ZLStatusTextViewCoverTag 999
#define ZLLongPongPressGestureRecognizerTag 222

#import "HXDynamic.h"

@interface HXLabel ()

@property (nonatomic, assign) BOOL isLongPongPressGestureRecognizer;

@end

@implementation HXLabel

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.editable = NO;
        self.scrollEnabled = NO;
        
        if (iPhone5) {
        }
        else {
            self.selectable = NO;
        }
    }
    return self;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    if (_type) {
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    }
    else {
        self.textContainerInset = UIEdgeInsetsMake(5, -5, -5, -5);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 触摸对象
    UITouch *touch = [touches anyObject];

    // 触摸点
    CGPoint point = [touch locationInView:self];
    
    NSMutableArray *specials = [[self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL] mutableCopy];
    BOOL contains = NO;

    NSString *type;
    for (ZLSpecial *special in specials) {
        if (!type) {
            type = special.type;
        }
        self.selectedRange = special.range;
        
//        [self setNewSelectedRange:special.range];
//        NSRange range = [self getSelectedRange];
        

        // self.selectedRange --影响--> self.selectedTextRange
        // 获得选中范围的矩形框
        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        for (UITextSelectionRect *selectionRect in rects) {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) continue;

            if (CGRectContainsPoint(rect, point)) { // 点中了某个特殊字符串
                contains = YES;
                break;
            }
        }
        
        if (contains) {
            for (UITextSelectionRect *selectionRect in rects) {
                CGRect rect = selectionRect.rect;
                if (rect.size.width == 0 || rect.size.height == 0) continue;

                rect.origin.x = rect.origin.x-8;
                if (_type) {
                    rect.origin.y = rect.origin.y-6.5;
                }
                else {
                    rect.origin.y = rect.origin.y-3;
                }
                rect.size.width = rect.size.width + 5;

                NSMutableAttributedString *textColor = self.attributedText.mutableCopy;
                [textColor addAttribute:NSBackgroundColorAttributeName value:BORDERToWidth_4_Color range:special.range];
                [self setAttributedText:textColor];
            }

            break;
        }
    }
    
    if (!contains) {
        [super touchesBegan:touches withEvent:event];

        if ([type isEqualToString:@"name"]) {
            NSMutableAttributedString *textColor = self.attributedText.mutableCopy;
            [textColor addAttribute:NSBackgroundColorAttributeName value:BORDERToWidth_4_Color range:NSMakeRange(0, self.attributedText.length)];
            [self setAttributedText:textColor];
        }
    }
}

- (void)setNewSelectedRange:(NSRange) range
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}

- (NSRange)getSelectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UITouch *touch = [touches anyObject];
        
        // 触摸点
        CGPoint point = [touch locationInView:self];
        
        NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
        BOOL contains = NO;
        
        for (ZLSpecial *special in specials) {
            self.selectedRange = special.range;
            // self.selectedRange --影响--> self.selectedTextRange
            // 获得选中范围的矩形框
            NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
            // 清空选中范围
            self.selectedRange = NSMakeRange(0, 0);
            
            for (UITextSelectionRect *selectionRect in rects) {
                CGRect rect = selectionRect.rect;
                if (rect.size.width == 0 || rect.size.height == 0) continue;
                
                if (CGRectContainsPoint(rect, point)) { // 点中了某个特殊字符串
                    contains = YES;
                    break;
                }
            }
            
            if (contains) {
                for (UITextSelectionRect *selectionRect in rects) {
                    CGRect rect = selectionRect.rect;
                    if (rect.size.width == 0 || rect.size.height == 0) continue;

                    if (special.urlString) {
                        
                        if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(textWithAction:toType:)]) {
                            [self.dataDelegate textWithAction:special.urlString toType:special.type];
                            break;
                        }
                    }
                }
                break;
            }
        }
        [self touchesCancelled:touches withEvent:event];
        
        if (_textEvenTochWithBlock && !contains) {
            _textEvenTochWithBlock();
        }
    });
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 去掉特殊字符串后面的高亮背景
    NSMutableAttributedString *textColor = self.attributedText.mutableCopy;
    [textColor addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, self.attributedText.string.length)];
    [self setAttributedText:textColor];

    [super touchesCancelled:touches withEvent:event];
}


@end
