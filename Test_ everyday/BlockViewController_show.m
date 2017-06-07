//
//  BlockViewController_show.m
//  Test_ everyday
//
//  Created by prliu on 2017/3/29.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "BlockViewController_show.h"
#import "BlockViewController_input.h"

@interface BlockViewController_show ()
@property (weak, nonatomic) IBOutlet UIButton *showBt;
@end

@implementation BlockViewController_show

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
   
    [self fun1:segue];
    //[self fun2:segue];

}

-(void)fun1:(UIStoryboardSegue*)segue{
    
    BlockViewController_input *input = segue.destinationViewController;
    //方法一，实现block
    input.inputTextBlock = ^(NSString *str){
        
        NSLog(@"输入:%@",str);
        [self.showBt setTitle:str forState:UIControlStateNormal];
        
    };

}

-(void)fun2:(UIStoryboardSegue*)segue{

    BlockViewController_input *input = segue.destinationViewController;
    //方法二，其实同理，都是对inputVC的block进行实现
    [input returnInputText:^(NSString *inputText) {
        
        NSLog(@"方法二输入:%@",inputText);
        
        
    }];

}

@end
