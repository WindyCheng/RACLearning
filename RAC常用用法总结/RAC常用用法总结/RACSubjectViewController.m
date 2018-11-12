//
//  RACSubjectViewController.m
//  RAC常用用法总结
//
//  Created by Windy on 2018/4/2.
//  Copyright © 2018年 Windy. All rights reserved.
//

#import "RACSubjectViewController.h"
#import "RACSubjectTwoViewController.h"
#import <ReactiveCocoa.h>

@interface RACSubjectViewController ()

@property(nonatomic, copy)UIButton * button;

@end

@implementation RACSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
}

- (void)buildUI {
    self.button.frame = CGRectMake(100, 100, 80, 30);
    [self.view addSubview:self.button];
}

#pragma mark---lazy loading
- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button setBackgroundColor:[UIColor redColor]];
        [_button setTitle:@"push" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
#pragma mark--btnOnClick
- (void)btnOnClick {
    RACSubjectTwoViewController *twoVC = [[RACSubjectTwoViewController alloc] init];
    twoVC.subject = [RACSubject subject];
    [twoVC.subject subscribeNext:^(id x) {  // 这里的x便是sendNext发送过来的信号
        NSLog(@"反向传值%@", x);
        [self.button setTitle:x forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:twoVC animated:YES];
}

@end
