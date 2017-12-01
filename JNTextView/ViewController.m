//
//  ViewController.m
//  JNTextView
//
//  Created by Yukino on 2017/12/1.
//  Copyright © 2017年 Yukino. All rights reserved.
//

#import "ViewController.h"
#import "JNTextView.h"
#import "Masonry.h"

@interface ViewController ()<UITextViewDelegate>

@property (nonatomic, strong) JNTextView *contentTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    
    JNTextView *contentTextView = [[JNTextView alloc] init];
    contentTextView.backgroundColor = [UIColor whiteColor];
    contentTextView.textColor = [UIColor blackColor];
    contentTextView.font = [UIFont systemFontOfSize:13];
    contentTextView.placeholder = @"  您可以输入您的意见和反馈";
    contentTextView.placeholderColor = [UIColor lightGrayColor];
    contentTextView.delegate = self;
    //调整光标的位置
    contentTextView.textContainerInset = UIEdgeInsetsMake(10,0, 0, 0);
    
    [self.view addSubview:contentTextView];
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(38.7);
    }];
    _contentTextView = contentTextView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 * 计算textView高度
 */
- (float)heightForTextView:(UITextView *)textView withText:(NSString *)stringText {
    CGSize constraint = CGSizeMake(textView.contentSize.width , CGFLOAT_MAX);
    CGRect size = [stringText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                        context:nil];
    float textHeight = size.size.height + 22.0;
    return textHeight;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    CGRect frame = textView.frame;
    float height;
    if ([text isEqual:@""]) {
        
        if (![textView.text isEqualToString:@""]) {
            height = [self heightForTextView:textView withText:[textView.text substringToIndex:[textView.text length] - 1]];
            
        }else {
            height = [self heightForTextView:textView withText:textView.text];
        }
        
    }else {
        height = [self heightForTextView:textView withText:[NSString stringWithFormat:@"%@%@",textView.text,text]];
    }
    
    frame.size.height = height;
    [UIView animateWithDuration:0.5 animations:^{
        
        textView.frame = frame;
        
    } completion:nil];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
