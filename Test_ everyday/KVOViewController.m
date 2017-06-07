//
//  KVOViewController.m
//  Test_ everyday
//
//  Created by prliu on 2017/4/1.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "KVOViewController.h"
#import "Person.h"


@interface TwoTimesArray()
@property (nonatomic,readwrite,assign) NSUInteger count;
@property (nonatomic,copy) NSString* arrName;
@end
@implementation TwoTimesArray
-(void)incrementCount{
    self.count ++;
}
-(NSUInteger)countOfNumbers{
    return self.count;
}
-(id)objectInNumbersAtIndex:(NSUInteger)index{     //当key使用numbers时，KVC会找到这两个方法。
    return @(index * 2);
}
-(NSInteger)getNum{                 //第一个,自己一个一个注释试
    return 10;
}
-(NSInteger)num{                       //第二个
    return 11;
}
-(NSInteger)isNum{                    //第三个
    return 12;
}
@end

@interface KVOViewController ()
{
    Person *model;
}
@property (nonatomic,copy) NSString *state_kvo;
@end

@implementation KVOViewController

-(void)setNilValueForKey:(NSString *)key{
    NSLog(@"不能将%@设成nil",key);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TwoTimesArray *arr = [TwoTimesArray new];
    NSNumber* num = [arr valueForKey:@"num"];
    NSLog(@"%@",num);

    
    //kvo(.property 可以触发kvo)
    
    model = [[Person alloc]init];
    [model setValue:@"prliu" forKey:@"name"];//key 属性的名字。
    [model setValue:@"15" forKey:@"age"];
//    [model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"kvo"];
    
    //归档
    
    
//    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    
//    dispatch_apply(5, queue, ^(size_t intdex) {
//        
//        model.name = [NSString stringWithFormat:@"%zu",intdex];
//        
//    });
    
    //_property
//    [self addObserver:self forKeyPath:@"state_kvo" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    dispatch_apply(5, queue, ^(size_t intdex) {
//
//        [self setValue:@"state0" forKey:@"state_kvo"];//_state_kvo 不经过set方法触发不了 添加不了kvo
//
//
//    });
    
    //self----注意添加的对象 不是本事添加监控 是管理方添加 来对属性进行监视
//    [self addObserver:self forKeyPath:@"state_kvo" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    dispatch_apply(5, queue, ^(size_t intdex) {
//        
//        self.state_kvo = [NSString stringWithFormat:@"%zu",intdex];
//        
//        
//    });
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath:%@",keyPath);
    if([keyPath isEqualToString:@"name"])
    {
        NSLog(@"name_kvo:%@",[object valueForKey:@"name"]);
    }
    if([keyPath isEqualToString:@"state_kvo"])
    {
        NSLog(@"state_kvo:%@",[object valueForKey:@"state_kvo"]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    //[model removeObserver:self forKeyPath:@"name"];
    
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
