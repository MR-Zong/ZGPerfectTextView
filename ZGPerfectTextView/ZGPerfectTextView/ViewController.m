//
//  ViewController.m
//  ZGPerfectTextView
//
//  Created by 徐宗根 on 2017/4/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ViewController.h"
#import "ZGPerfectTextView.h"

@interface ViewController () <UITextViewDelegate>

@property (nonatomic, strong) ZGPerfectTextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self example];
}


- (void)example
{
    
    _textView = [[ZGPerfectTextView alloc] init];
    _textView.frame = CGRectMake(100, 100, 350, 300);
    _textView.editable = NO;
    _textView.font = [UIFont systemFontOfSize:14];
    //    _textView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_textView];

    
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"This is an example by @marcelofabri_猿圈是一家互联网技术人才服务平台，专注于技术人才的评测，用代码帮助企业快速识别技术人才：候选人接受线上测试挑战，使用机器自动判卷，编程数据采集，采用先进的技术能力识别算法，精确识别候选人的真实技术能力，形成全面的编程技能评估报告和分析矩阵，将结果反馈给用户和公司，大大节省了时间和精力。除此之外，猿圈自研的Android、iOS在线云端编译引擎，可以支持用户在云端（浏览器中）写代码，在世界处于领先地位。"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"可以支持用户在云端（浏览器中）写代专人才"];
    
    
    NSMutableParagraphStyle *paragraphStyle  = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.string.length - 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, attributedString.string.length - 1)];
    
    [attributedString addAttribute:ZGTapAttributeName
                             value:@"http"
                             range:[[attributedString string] rangeOfString:@"an"]];

    
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"username://marcelofabri_"
                             range:[[attributedString string] rangeOfString:@"@marcelofabri_"]];
    
    
    NSDictionary *linkAttributes = @{NSForegroundColorAttributeName: [UIColor greenColor],
                                     NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                     NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
    
    // assume that textView is a UITextView previously created (either by code or Interface Builder)
    _textView.linkTextAttributes = linkAttributes; // customizes the appearance of links
    _textView.attributedText = attributedString;
    _textView.delegate = self;
    
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"点击处理...");
    if ([[URL scheme] isEqualToString:@"username"]) {
        NSString *username = [URL host];
        // do something with this username
        // ...
        return NO;
    }
    return YES; // let the system open this URL
}

@end
