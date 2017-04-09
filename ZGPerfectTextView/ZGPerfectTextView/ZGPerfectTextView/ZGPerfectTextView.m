//
//  ZGPerfectTextView.m
//  ZGPerfectTextView
//
//  Created by 徐宗根 on 2017/4/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGPerfectTextView.h"

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
//    self.textAlignment = NSTextAlignmentCenter;
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




@end
