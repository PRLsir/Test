//
//  TryViewController.m
//  Test_ everyday
//
//  Created by prliu on 2017/3/27.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "TryViewController.h"

@interface TryViewController ()

@end

@implementation TryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @try {
        // 1
        NSLog(@"1\n");
        [self tryTwo];
    }
    @catch (NSException *exception) {
        // 2
        NSLog(@"%s\n%@", __FUNCTION__, exception);
        NSLog(@"2\n");
        //@throw exception; // 这里不能再抛异常
    }
    @finally {
        // 3
        NSLog(@"3\n");

    }
    // 4
    // 这里一定会执行
    NSLog(@"4\n");

}
- (void)tryTwo
{
    @try {
        // 5
        NSLog(@"5\n");
        NSString *str = @"abc";
        [str substringFromIndex:111]; // 程序到这里会崩
    }
    @catch (NSException *exception) {
        
        NSLog(@"6\n");
        @throw exception; // 抛出异常，即由上一级处理 屏蔽的话顺序是1-5-6-7-8-3-4  放出的话顺序是1-5-6-7-2-3-4
        NSLog(@"%s\n%@", __FUNCTION__, exception);
    }
    @finally {
        // 7
        NSLog(@"7\n");
        NSLog(@"tryTwo - 我一定会执行");
    }
    
    // 8
    // 如果抛出异常，那么这段代码则不会执行
    NSLog(@"8\n");
    NSLog(@"如果这里抛出异常，那么这段代码则不会执行");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
