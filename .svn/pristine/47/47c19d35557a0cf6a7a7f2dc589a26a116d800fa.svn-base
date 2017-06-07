//
//  RetainCycleViewController_two.m
//  Test_ everyday
//
//  Created by prliu on 2017/3/21.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "RetainCycleViewController_two.h"

typedef void(^myBlock)(int);

@interface RetainCycleViewController_two ()

-(void)gogogo_two;

@property (nonatomic,strong)dispatch_queue_t queue;
@property (nonatomic,weak)myBlock myb;
@property (nonatomic,strong)myBlock myb2;
@property (nonatomic,copy)  myBlock myb3;

@end

@implementation RetainCycleViewController_two

-(void)gogogo_two{

    NSLog(@"RetainCycleViewController_two fun gogogo");

}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"WechatIMG3"];
    /*
    self.queue =   dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(self.queue, ^{

    //模拟内存告急
      //NSMutableArray*arr  = [NSMutableArray array];

      for (int i = 0; i<999999; i++) {
      [arr addObject:image];
      }
        
        //模拟循环引用测试1，系统block 不会造成循环
        self.view.layer.contents = (id)image.CGImage;
        
    });
     */
    /*
     dispatch_queue_t queue2 =   dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
     dispatch_async(queue2, ^{
   
    //模拟循环引用测试2，系统block 不会造成循环
     self.view.layer.contents = (id)image.CGImage;
     
     });
     */
     
     //自定义block
    /*
    _myb = ^{
    
        //模拟循环引用测试2，自定义的block，如果修饰词为strong 不会造成循环
        self.view.layer.contents = (id)image.CGImage;
        
    };
     */
    /*
    _myb2 = ^{
        
        //模拟循环引用测试3，自定义的block，如果修饰词为strong,copy 会造成循环
        self.view.layer.contents = (id)image.CGImage;
        
    };
     */
    /*
    _myb = ^(int i){
        
        NSLog(@"模拟循环引用测试3，自定义的block，如果修饰词为weak,assign都不会造成循环.但是用weak时，会警告Assigning block literal to a weak variable; object will be released after assignment");
        //模拟循环引用测试3，自定义的block，如果修饰词为weak,assign都不会造成循环,但是weak有警告
        self.view.layer.contents = (id)image.CGImage;
        
    };
     */
    //正确的解决方式
    __weak RetainCycleViewController_two *weakSelf = self;
    _myb2 = ^(int i){
        
        NSLog(@"模拟循环引用测试3，自定义的block，如果修饰词为strong,copy 会造成循环");
        //模拟循环引用测试3，自定义的block，如果修饰词为strong,copy 会造成循环
        weakSelf.view.layer.contents = (id)image.CGImage;
        
    };
    _myb2(1);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
