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
    _textView.frame = CGRectMake(100, 100, 200, 100);
    _textView.editable = NO;
    //    _textView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_textView];

    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"This is an example by @marcelofabri_"];
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
