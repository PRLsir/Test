//
//  ThreadViewController.m
//  Test_ everyday
//
//  Created by prliu on 2017/3/30.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "ThreadViewController.h"

#define IMAGE_COUNT 12

@interface ThreadViewController ()
{
    NSThread *thread;
    NSMutableArray *imagearr;
}
@end

@implementation ThreadViewController

-(void)dealloc{

    [thread cancel];

}

- (void)viewDidLoad {
    
    /*
    •NSThread:
    –优点:NSThread  其他两个轻 级，使 简单 –缺点:需要  管 线程的 命周期、线程同步、加锁、睡眠以及唤醒等。线程同步对数据的加锁会有 定的系统开销
    •NSOperation: – 需要关 线程管 ，数据同步的事情，可以把精 放在  需要执 的操作上 –NSOperation是 向对象的
    •GCD:
    –Grand Central Dispatch是由苹果开发的 个多核编程的解决 案。iOS4.0+才能使 ，是替代NSThread， NSOperation的  效和强 的技术
    */

    [super viewDidLoad];
    [self loadData];
    //[self thread];
    //[self operation];
    [self dispatch];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(threadIsFinsh:) name:NSThreadWillExitNotification object:nil];

    // Do any additional setup after loading the view.
}

-(void)loadData{

    imagearr=[NSMutableArray array];
    for (int i=0; i<IMAGE_COUNT; i++) {
        [imagearr addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
    }

}

#pragma mark --- Dispatch_queue
-(void)dispatch{

    //DISPATCH_QUEUE_SERIAL--生成一个串行队列，队列中的block按照先进先出（FIFO）的顺序去执行，实际上为单线程执行。第一个参数是队列的名称，在调试程序时会非常有用，所有尽量不要重名了。
    

    dispatch_queue_t queue_serial = dispatch_queue_create("dispatch_queue_serial", DISPATCH_QUEUE_SERIAL);
    
    //DISPATCH_QUEUE_CONCURRENT--生成一个并发执行队列，block被分发到多个线程去执行。

    dispatch_queue_t queue_concurrent = dispatch_queue_create("dispatch_queue_concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    //获得程序进程缺省产生的并发队列，可设定优先级来选择高、中、低三个优先级队列。由于是系统默认生成的，所以无法调用dispatch_resume()和dispatch_suspend()来控制执行继续或中断。需要注意的是，三个队列不代表三个线程，可能会有更多的线程。并发队列可以根据实际情况来自动产生合理的线程数，也可理解为dispatch队列实现了一个线程池的管理，对于程序逻辑是透明的。
    
    dispatch_async(queue_serial, ^{
        
        [NSThread sleepForTimeInterval:0.8];
        NSLog(@"operation_block1");
        
    });
    dispatch_async(queue_serial, ^{
        
        [NSThread sleepForTimeInterval:0.1];
        NSLog(@"operation_block2");
        
    });
    dispatch_async(queue_serial, ^{
        
        [NSThread sleepForTimeInterval:0.3];
        NSLog(@"operation_block3");
        
    });
    
    dispatch_async(queue_concurrent, ^{
        
        [NSThread sleepForTimeInterval:0.8];
        NSLog(@"operation_block_concurrent1");
        
    });
    dispatch_async(queue_concurrent, ^{
        
        [NSThread sleepForTimeInterval:0.1];
        NSLog(@"operation_blcok_concurrent2");
        
    });
    dispatch_async(queue_concurrent, ^{
        
        [NSThread sleepForTimeInterval:0.3];
        NSLog(@"operation_blcok_concurrent3");
        
    });
    
    dispatch_queue_t queue_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue_global, ^{
        [NSThread sleepForTimeInterval:8];
        NSLog(@"串行线程7");
    });
    
    dispatch_group_async(group, queue_global, ^{
        [NSThread sleepForTimeInterval:6];
        NSLog(@"串行线程8");
    });
    
    dispatch_group_async(group, queue_global, ^{
        [NSThread sleepForTimeInterval:9];
        NSLog(@"串行线程9");
    });
    
    dispatch_group_notify(group, queue_global, ^{
        
        NSLog(@"串行线程7、8、9完成");
        
    });
    
    //重复执行 并发
    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        
        NSLog(@"dispatch_apply:%zu",index);
        
    });
    
    //同步执行block
    dispatch_barrier_sync(dispatch_get_global_queue(0, 0), ^{
        
    });
    
    /*
    dispatch队列还实现其它一些常用函数，包括：
    
    void dispatch_apply(size_t iterations, dispatch_queue_t queue, void (^block)(size_t)); //重复执行block，需要注意的是这个方法是同步返回，也就是说等到所有block执行完毕才返回，如需异步返回则嵌套在dispatch_async中来使用。多个block的运行是否并发或串行执行也依赖queue的是否并发或串行。
    
    void dispatch_barrier_async(dispatch_queue_t queue, dispatch_block_t block); //这个函数可以设置同步执行的block，它会等到在它加入队列之前的block执行完毕后，才开始执行。在它之后加入队列的block，则等到这个block执行完毕后才开始执行。
    
    void dispatch_barrier_sync(dispatch_queue_t queue, dispatch_block_t block); //同上，除了它是同步返回函数
    
    void dispatch_after(dispatch_time_t when, dispatch_queue_t queue, dispatch_block_t block); //延迟执行block
    
    最后再来看看dispatch队列的一个很有特色的函数：
    
    void dispatch_set_target_queue(dispatch_object_t object, dispatch_queue_t queue);
    
    它会把需要执行的任务对象指定到不同的队列中去处理，这个任务对象可以是dispatch队列，也可以是dispatch源（以后博文会介绍）。而且这个过程可以是动态的，可以实现队列的动态调度管理等等。比如说有两个队列dispatchA和dispatchB，这时把dispatchA指派到dispatchB：
    
    dispatch_set_target_queue(dispatchA, dispatchB);
    
    那么dispatchA上还未运行的block会在dispatchB上运行。这时如果暂停dispatchA运行：
    
    dispatch_suspend(dispatchA);
    
    则只会暂停dispatchA上原来的block的执行，dispatchB的block则不受影响。而如果暂停dispatchB的运行，则会暂停dispatchA的运行。
    
    这里只简单举个例子，说明dispatch队列运行的灵活性，在实际应用中你会逐步发掘出它的潜力。
    
    dispatch队列不支持cancel（取消），没有实现dispatch_cancel()函数，不像NSOperationQueue，不得不说这是个小小的缺憾。
     */

}

#pragma mark --- NSOperation

-(void)operation{

    //NSBlockOperation
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    /*

    //方法一 需要把NSBlockOperation加入到queen里 然后开启
    NSBlockOperation *operation_block1 = [NSBlockOperation blockOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:0.3];
        NSLog(@"operation_block1");
        
    }];
    NSBlockOperation *operation_block2 = [NSBlockOperation blockOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:1];
        NSLog(@"operation_block2");

    }];
    NSBlockOperation *operation_block3 = [NSBlockOperation blockOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:2];
        NSLog(@"operation_block3");
    }];
    
    //添加执行block
    [operation_block1 addExecutionBlock:^{
        
        [NSThread sleepForTimeInterval:0.4];
        NSLog(@"operation_block1-1");
        
    }];
    //添加执行block
    [operation_block1 addExecutionBlock:^{
        
        [NSThread sleepForTimeInterval:0.3];
        NSLog(@"operation_block1-2");
        
    }];
    //添加执行block
    [operation_block1 addExecutionBlock:^{
        
        [NSThread sleepForTimeInterval:0.2];
        NSLog(@"operation_block1-3");
        
    }];
    
    //添加依赖 [operationB addDependency:operationA]; // 操作B依赖于操作A 前依赖后
    
    //2-1-3
    [operation_block3 addDependency:operation_block1];//3要等1执行完才执行
    [operation_block1 addDependency:operation_block2];//1要等2执行完才执行
    
    //开启方法一，可以通过加入queue执行 执行顺序跟添加的前后顺序，没有关系 addOperation是并发的
    [queue addOperation:operation_block1];
    [queue addOperation:operation_block2];
    [queue addOperation:operation_block3];
    

    //开启方法二，可以直接start 执行顺序跟开启 开启的时间一致 如果添加的依赖跟start的顺序不一样，会崩溃提示 receiver is not yet ready to execute（接收器并未准备好）
    //[operation_block2 start];
    //[operation_block1 start];
    //[operation_block3 start];
    
    //设置监听
    [operation_block1 setCompletionBlock:^{
        
        NSLog(@"operation_block1结束");
        
    }];
    */
    //当前线程等待，直到之前所有的线程结束
    //[queue waitUntilAllOperationsAreFinished];//

    
    //NSInvocationOperation
    NSInvocationOperation *invocation1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocation_action1) object:nil];
    NSInvocationOperation *invocation2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocation_action2) object:nil];
    NSInvocationOperation *invocation3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocation_action3) object:nil];
    NSInvocationOperation *invocation4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocation_action4) object:nil];

    queue.maxConcurrentOperationCount = 2;//最大并发量
    
    //前靠后
    [invocation3 addDependency:invocation2];
    [invocation2 addDependency:invocation1];
    

    //方法一 类似于block 并发
    [queue addOperation:invocation1];
    [queue addOperation:invocation2];
    [queue addOperation:invocation3];
    [queue addOperation:invocation4];

    //[invocation4 waitUntilFinished]; //阻塞当前线程，直到该invocation4结束
    
    
    //[invocation start];
    

}
-(void)invocation_action1{

    [NSThread sleepForTimeInterval:3];
    NSLog(@"invocation_action1");

}

-(void)invocation_action2{
    
    [NSThread sleepForTimeInterval:2];
    NSLog(@"invocation_action2");
}

-(void)invocation_action3{
    
    [NSThread sleepForTimeInterval:1];
    NSLog(@"invocation_action3");
}
-(void)invocation_action4{

    [NSThread sleepForTimeInterval:0];
    NSLog(@"invocation_action4");

}

#pragma mark --- NSThread

-(void)thread{
    
    self.showTex = @"多线程\n";
    self.showTex = @"NSThread\n";

    //方法一
    //thread = [[NSThread alloc]initWithTarget:self selector:@selector(thread_action) object:nil];
    //[thread start];
    
    //方法二
    /*
    [NSThread detachNewThreadWithBlock:^{
        
        [self thread_action];
        
    }];
     */
    //方法三
    [NSThread detachNewThreadSelector:@selector(thread_action) toTarget:self withObject:nil];
}

-(void)threadIsFinsh:(NSNotification*)not{

    NSLog(@"线程即将完成:%@",not);

}

-(void)thread_action{
    
    int imageView_w = self.view.frame.size.width/3;
    int imageView_h = self.view.frame.size.height/4;


    for (int i = 0; i < 12; i++) {
        
        int x = (i%3)*imageView_w;
        int y = (i/3)*imageView_h;

        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, imageView_w, imageView_h)];
        [imageView setImage:[UIImage imageNamed:@""]];
        [imageView setBackgroundColor:[UIColor yellowColor]];
        imageView.layer.masksToBounds = YES;
        imageView.layer.borderWidth = 1;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [self performSelectorOnMainThread:@selector(addSubviewImage:) withObject:imageView waitUntilDone:YES];
        
        
    }


}
-(void)addSubviewImage:(UIImageView*)subView{

    [self.view addSubview:subView];
   
    @autoreleasepool {
        
    [NSThread detachNewThreadWithBlock:^{
        
        NSLog(@"即将开启:%@",[NSThread currentThread]);
        subView.image = [self loadImage:imagearr.count-1];
        imagearr.count>0 ? [imagearr removeLastObject] :nil;
        
    }];
    
    }


}

-(UIImage*)loadImage:(NSInteger)imag_index{

    if (imag_index<0)return nil;
    return  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagearr[imag_index]] options:NSDataReadingMappedIfSafe error:nil]];

    
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
