//
//  PropertyViewController.m
//  Test_ everyday
//
//  Created by prliu on 2017/3/23.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "PropertyViewController.h"

@interface PropertyViewController ()

@property (nonatomic, strong) NSString *name_strong;
@property (nonatomic, assign) NSString *name_assign;
@property (nonatomic, copy) NSString *name_copy;

@end

@implementation PropertyViewController


#define LOG(Item_NAME,Item)  NSLog(@"%@:%p,%@,%ld",Item_NAME,Item,Item,CFGetRetainCount(Item));
//#define LOG(Item_NAME,Item)  NSLog(@"%@:%p,%@,%ld",Item_NAME,&Item,Item,CFGetRetainCount(Item));


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //(一般来说,一个标准的复制操作,也可以称为简单任务,当你使用=运算符分配一个变量的值到另一个地方。表达式myInt2 = myInt1,例如,使整数myInt1内容从使用的内存复制myInt1 myInt2所使用的内存。复制操作之后,两个不同区域的内存包含相同的值。然而,如果你试图复制一个核心基础对象以这种方式,请注意,你不会复制对象本身,只对对象的引用。新核心基金会为例,有人可能会认为复制CFString对象myCFString2 = myCFString1她会使用表达式。再一次,这个表达式实际上并没有复制字符串数据。因为myCFString1和myCFString2必须CFStringRef类型,这个表达式只复制对象的引用。复制操作之后,你有两个副本的CFString的引用。这种类型的副本是非常快的,因为只有引用复制,但重要的是要记住,复制一个可变对象以这种方式是危险的。使用全局变量的程序,如果您的应用程序的一部分改变一个对象使用一份参考,没有办法对程序的其他部分有参考知道数据的副本已经改变了。如果你想要复制一个对象,你必须使用一个专门为这个目的提供的功能的核心基础。继续CFString示例中,您将使用CFStringCreateCopy创建一个完全新的CFString包含相同的数据与原始对象。核心基础类型“CreateCopy”功能还提供了变体“CreateMutableCopy”,返回一个对象的一个副本,可以修改。)
    //浅拷贝复制复合对象,对象等集合可以包含其他对象的对象,必须慎之又慎。如您所料,使用=操作符对这些对象执行一份结果重复的对象引用。简单对象,如CFString和CFData相比,复合对象的“CreateCopy”功能提供如CFArray和CFSet实际执行一个浅拷贝。在这些对象的情况下,一个浅复制意味着创建一个新的集合对象,但最初收集的内容并不只有复制对象引用复制到新的容器。这种类型的复制是有用的,例如,您有一个数组,是不可变的,你想重新排序。在这种情况下,您不希望复制的所有包含的对象因为没有需要改变——为什么使用额外的内存?你只是想要包括对象的设置改变。应用相同的风险是与简单复制对象引用类型。
    //深拷贝当你想要创建一个全新的复合对象,你必须执行一个深拷贝。深复制副本复合对象的内容以及它的所有包含的对象。当前版本的核心基础包含一个函数,执行深拷贝的属性列表(见CFPropertyListCreateDeepCopy)。如果你想创建其他结构的深层副本,你可以执行深复制自己由递归下行复合对象和复制它的所有内容。照顾在复合对象可以实现这个功能recursive-they可能直接或间接地包含一个引用控制会导致递归循环。
    
    [self str_copy];
    //[self arr_copy];//两个不同区域的内存包含相同的值
    //[self mutable_copy];
    //[self mutable_mcopy];
    
    //个人总结，深浅拷贝并不是说就是copy/mutabCopy，而是浅拷贝，只是使整数item1内容从使用的内存复制item1到item2所使用的内存，两个不同区域的内存包含相同的值，引用拷贝

    // Do any additional setup after loading the view.
}

-(void)str_copy{

    //要区别指针变量的存储空间和它所指向的存储空间，一个指针变量p指向某个存储单元i：p=&i。&是取址符，也叫构指符，&i的结果就是返回变量i的指针。把i的指针（&i）赋值给指针变量p，就说p指向变量i，就可以说p是i的指针。p和&i的类型是指向整型的指针类型int *，简单说就是整型指针型。含义是：p引用了名字为i的这片存储区域，这片区域的起始地址是&i，大小是sizeof(int)；而指针变量p本身的索引信息是&p，类型是(int **)，含义是p所命名的区域是以&p为起始，大小为sizeof(int *)。
    
    NSMutableString *string_assign = [NSMutableString stringWithString:@"哈哈哈"];
    NSMutableString *string_strong = [NSMutableString stringWithString:@"哈哈哈"];
    NSMutableString *string_copy = [NSMutableString stringWithString:@"哈哈哈"];


    //assign 指向的是同一块内存地址 引用计数器没变化
    self.name_assign = string_assign;
    LOG(@"string_assign", string_assign)
    LOG(@"self.name_assign", self.name_assign)
    [string_assign appendString:@" - 345"];
    LOG(@"string_assign", string_assign)
    LOG(@"self.name_assign", self.name_assign)
    
    //strong 指向的是同一块内存地址 引用计数器+1
    self.name_strong = string_strong;
    LOG(@"string_strong", string_strong)
    LOG(@"self.name_strong", self.name_strong)
    [string_strong appendString:@" - 678"];
    LOG(@"string_strong", string_strong)
    LOG(@"self.name_strong", self.name_strong)
    
    //copy 指向的不是同一块内存地址 新开辟一个空间 引用计数器没变化
    self.name_copy = string_copy;
    LOG(@"string_copy", string_copy)
    LOG(@"self.name_copy", self.name_copy)
    [string_copy appendString:@" - 012"];
    LOG(@"string_copy", string_copy)
    LOG(@"self.name_copy", self.name_copy)
    
    
    NSLog(@"==================================copy==========================================");
    
    
    //copy 指向的不是同一块内存地址 新开辟一个空间 引用计数器没变化
    self.name_copy = [string_copy copy];
    LOG(@"string_copy", string_copy)
    LOG(@"self.name_copy", self.name_copy)
    [string_copy appendString:@" - 012"];
    LOG(@"string_copy", string_copy)
    LOG(@"self.name_copy", self.name_copy)
    
}

-(void)arr_copy{

    //@interface NSArray<__covariant ObjectType> : NSObject <NSCopying, NSMutableCopying, NSSecureCoding, NSFastEnumeration>
    
    NSArray *arr = [NSArray arrayWithObjects:@"gogo", nil];
    LOG(@"arr",arr);
    NSArray *arr_copy = [arr copy];
    LOG(@"arr_copy",arr_copy);
    
    arr = nil;//arr 
    //LOG(@"arr",arr);
    LOG(@"arr_copy",arr_copy);

}

-(void)mutable_copy{

    //@interface NSMutableArray<ObjectType> : NSArray<ObjectType>

    NSMutableArray *marr = [NSMutableArray arrayWithObjects:@"toto", nil];
    NSArray *marr_copy = [marr copy];
    LOG(@"marr",marr);
    LOG(@"marr_copy",marr_copy);

}

-(void)mutable_mcopy{
    
    //@interface NSMutableArray<ObjectType> : NSArray<ObjectType>
    
    NSMutableArray *marr = [NSMutableArray arrayWithObjects:@"sese", nil];
    NSArray *marr_mcopy = [marr mutableCopy];
    LOG(@"marr",marr);
    LOG(@"marr_mcopy",marr_mcopy);
    
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
