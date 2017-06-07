//
//  DefineConstViewController.m
//  Test_ everyday
//
//  Created by prliu on 2017/3/29.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "DefineConstViewController.h"


//全局属性
#define DEFINE NSLog(@"i am prliu")//宏
NSString *string = @"i am prliu";//变量
extern NSString*string; //别的地方声明了
extern const NSString *string;//常量
static const NSString *string1;//static改变属性的访问权限 模块定义模块内 函数定义函数内 类定义类内


@interface DefineConstViewController ()

@end

@implementation DefineConstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    int a;
    char b;
    int *i=&a; i和&a都是指针，是int型指针
    char *j=&b; j和&b都是char型指针
    int **k=&i; k和&i都是int指针型指针
     */
    
    /*const 右边的不能被修改 */
    const int *p = NULL;//指针变量，保存的是内存地址
    int a = 10;
    int b = 20;
    int c = 30;
    //p-->a
    p = &a; //可改
    //*p = 30;不可改

    int const *p2 = NULL;
    p2 = &a;
    //*p2 = b; //同上
    
    int * const p3 = NULL;
    //p3 = &c;//不可改
    *p3 = c;//可改

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
