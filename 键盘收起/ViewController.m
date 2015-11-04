//
//  ViewController.m
//  键盘收起
//
//  Created by 141319 on 15/11/3.
//  Copyright © 2015年 com.mob.demoShareSDK. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Sizes.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic,assign) CGFloat nowOffsetY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nowOffsetY = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)hideKeyboard
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}
- (void)keyboardWillShow:(NSNotification *)notifi
{
    NSLog(@"NSNotification.userInfo %@",notifi.userInfo);
    NSDictionary *userInfo = notifi.userInfo;
    
    
    CGFloat height = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat duration =[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UITextField *tf;
    if (self.username.isFirstResponder == YES) {
        tf = self.username;
    }
    if (self.password.isFirstResponder == YES) {
        tf = self.password;
    }
    
    CGFloat chazhi = height - tf.bottomToSuper - self.nowOffsetY;
    if (chazhi < self.nowOffsetY) {
        return;
    }
    if (chazhi) {
        [UIView animateWithDuration:duration animations:^{
            self.view.top -=chazhi;
        } completion:^(BOOL finished) {
            self.nowOffsetY = chazhi;
        }];
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notifi
{
    NSLog(@"NSNotification.userInfo %@",notifi.userInfo);
    NSDictionary *userInfo = notifi.userInfo;
    
    CGFloat duration =[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UITextField *tf;
    if (self.username.isFirstResponder == YES) {
        tf = self.username;
    }
    if (self.password.isFirstResponder == YES) {
        tf = self.password;
    }
    
    if (self.nowOffsetY ) {
        [UIView animateWithDuration:duration animations:^{
            self.view.top +=self.nowOffsetY ;
        } completion:^(BOOL finished) {
            self.nowOffsetY = 0;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
