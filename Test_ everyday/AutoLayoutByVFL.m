//
//  AutoLayoutByVFL.m
//  Test_ everyday
//
//  Created by prliu on 2017/4/10.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "AutoLayoutByVFL.h"

@interface AutoLayoutByVFL ()

@end

@implementation AutoLayoutByVFL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view_top = [[UIView alloc]init];
    view_top.translatesAutoresizingMaskIntoConstraints = NO;
    view_top.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view_top];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[view_top]-10-|" options:0 metrics:nil views:@{@"view_top":view_top}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-84-[view_top]-20-|" options:0 metrics:nil views:@{@"view_top":view_top}]];
 
    
    // Do any additional setup after loading the view.
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
