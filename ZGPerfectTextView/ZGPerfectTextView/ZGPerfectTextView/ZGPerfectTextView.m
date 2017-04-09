//
//  ZGPerfectTextView.m
//  ZGPerfectTextView
//
//  Created by 徐宗根 on 2017/4/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGPerfectTextView.h"

NSString *const ZGTapAttributeName = @"ZGTapAttributeName";

@implementation ZGPerfectTextView


- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentSize"];
}



- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [self addObserver:self forKeyPath:@"contentSize" options:  (NSKeyValueObservingOptionNew) context:NULL];
}

// 方案一 垂直居中
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"])
    {
        UITextView *tv = object;
        CGFloat deadSpace = ([tv bounds].size.height - [tv contentSize].height);
        CGFloat inset = MAX(0, deadSpace/2.0);
        tv.contentInset = UIEdgeInsetsMake(inset, tv.contentInset.left, inset, tv.contentInset.right);
    }
    
}

// 方案二 垂直居中
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
////    UITextView *mTrasView = object;
//    
//    CGFloat topCorrect = ([self bounds].size.height - [self contentSize].height);
//    
//    topCorrect = (topCorrect <0.0 ?0.0 : topCorrect);
//    
//    self.contentOffset = (CGPoint){.x =0, .y = -topCorrect/2};
//    
//}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITextView *textView =self;// (UITextView *)recognizer.view;
    
    // Location of the tap in text-container coordinates
    
    NSLayoutManager *layoutManager = textView.layoutManager;
     UITouch *touch =[touches anyObject];
    CGPoint location =[touch locationInView:self];
    location.x -= textView.textContainerInset.left;
    location.y -= textView.textContainerInset.top;
    
    // Find the character that's been tapped on
    
    NSUInteger characterIndex;
    characterIndex = [layoutManager characterIndexForPoint:location
                                           inTextContainer:textView.textContainer
                  fractionOfDistanceBetweenInsertionPoints:NULL];
    
    
    if (characterIndex < textView.textStorage.length) {
        
        NSString *s=[self.text substringWithRange:NSMakeRange(characterIndex, 1)];
        NSLog(@"%@",s);
        
        
        NSRange range;
        id value = [textView.attributedText attribute:ZGTapAttributeName atIndex:characterIndex effectiveRange:&range];
        
        // Handle as required...
        
        NSLog(@"%@, %d, %d", value, range.location, range.length);
        
    }

    
    [super touchesBegan:touches withEvent:event];
}

//- (void)textTapped:(UITapGestureRecognizer *)recognizer
//{
//    UITextView *textView = (UITextView *)recognizer.view;
//    
//    // Location of the tap in text-container coordinates
//    
//    NSLayoutManager *layoutManager = textView.layoutManager;
//    CGPoint location = [recognizer locationInView:textView];
//    location.x -= textView.textContainerInset.left;
//    location.y -= textView.textContainerInset.top;
//    
//    // Find the character that's been tapped on
//    
//    NSUInteger characterIndex;
//    characterIndex = [layoutManager characterIndexForPoint:location
//                                           inTextContainer:textView.textContainer
//                  fractionOfDistanceBetweenInsertionPoints:NULL];
//    
//    
//    if (characterIndex < textView.textStorage.length) {
//        
//        NSString *s=[self.text substringWithRange:NSMakeRange(characterIndex, 1)];
//        NSLog(@"%@",s);
//
//        
//        NSRange range;
//        id value = [textView.attributedText attribute:@"myCustomTag" atIndex:characterIndex effectiveRange:&range];
//        
//        // Handle as required...
//        
//        NSLog(@"%@, %d, %d", value, range.location, range.length);
//        
//    }
//}

//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    //No.1
//    //开始写代码,触摸操作开始时,获取当前触摸位置的字符所属的单词。并用UIAlertView显示出来(提示：触摸位置需向下调整10个点，以便与文本元素对齐)
//    UITouch *touch =[touches anyObject];
//    CGPoint touchPoint =[touch locationInView:self];
//    
//    
//    NSInteger characterIndex = [self.layoutManager characterIndexForPoint:touchPoint inTextContainer:self.textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
//    if (characterIndex<self.text.length) {
//        NSString *s=[self.text substringWithRange:NSMakeRange(characterIndex, 1)];
//        NSLog(@"%@",s);
//    }
//    
//    //end_code
//    [super touchesBegan: touches withEvent: event];
//}



@end
