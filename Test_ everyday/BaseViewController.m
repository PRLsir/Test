//
//  BaseViewController.m
//  Test_ everyday
//
//  Created by prliu on 2017/3/21.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    
}
-(void)gogogo_base;
@end

@implementation BaseViewController

-(void)gogogo_base{

    NSLog(@"gogogo_base");

    
}

-(void)setTextView:(UITextView *)textView{

    if (_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
        _textView.text = self.showTex;
        _textView.editable = NO;
        [self.view addSubview:_textView];

    }


}

-(void)setShowTex:(NSString *)showTex
{

    if (![_showTex isEqualToString:showTex]) {
        
        [_showTex stringByAppendingString:showTex];
        self.textView.text = self.showTex;
        
    }


}
-(void)viewDidAppear:(BOOL)animated{
    
    extern NSString *string;
    NSLog(@"externString:%@",string);
    string = @"我修改了externString";
    [super viewDidAppear:animated];
    NSLog(@"%@ didapper",[self class]);
   
}

-(void)dealloc{

    NSLog(@"%@ dealloc",[self class]);


}

-(void)viewDidDisappear:(BOOL)animated{

    NSLog(@"%@ disappear",[self class]);

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
