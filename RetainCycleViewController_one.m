//
//  RetainCycleViewController_one.m
//  Test_ everyday
//
//  Created by prliu on 2017/3/21.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "RetainCycleViewController_one.h"
#import <objc/message.h>
#import "RetainCycleViewController_two.h"


@interface RetainCycleViewController_one ()

@end

@implementation RetainCycleViewController_one

//如果isa找不到相应的方法，会通过resolveInstanceMethod，解决因为
void gogogo_one(id self, SEL _cmd) {
    NSLog(@" >> gogogo_one");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showTex = @"这次我们来实践一下，为何说oc没有私有变量和私有属性,私有的定义：私有是指只能够在本类内部使用或访问，但是不能在类的外部被访问。初步的说法是，虽然在 .m 中实现的方法，不在.h 中声明，外界不就不能访问到,符合私有的特性,质疑：在 Objective-C 中，对象调用方法是以发送消息的形式实现的。所有方法的调用最终都会转化为发送消息的形式,所以通过Runtime特性，私有的特性是被推翻的";
    
    objc_msgSend(self,@selector(gogogo_base));
    objc_msgSend(self,@selector(gogogo_two));//并未实例化，堆栈没有的，要做拦截处理

    
    // Do any additional setup after loading the view from its nib.
}
//解决类方法
+ (BOOL)resolveClassMethod:(SEL)sel{
    
    NSLog(@" >>resolveClassMethod %@", NSStringFromSelector(sel));
    return YES;
}
//解决实例方法，防止调用未实现的方法
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    NSLog(@">> resolveInstanceMethod %@", NSStringFromSelector(sel));
    if (sel  == @selector(gogogo_two)) {
      return  class_addMethod([self class], sel, (IMP)gogogo_one, "");
    }
    return NO;
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
