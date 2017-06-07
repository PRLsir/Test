//
//  OpenGLViewController.m
//  Test_ everyday
//
//  Created by prliu on 2017/3/27.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "OpenGLViewController.h"
#import <OpenAL/OpenAL.h>
#import "OpenGLView.h"

@interface OpenGLViewController ()
{
}
@property (nonatomic,strong)OpenGLView *glView;
@end

@implementation OpenGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.glView = [[OpenGLView alloc] initWithFrame:screenBounds];
    [self.view addSubview:self.glView];
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
