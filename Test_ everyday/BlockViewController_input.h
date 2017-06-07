//
//  BlockViewController_input.h
//  Test_ everyday
//
//  Created by prliu on 2017/3/29.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void (^ReturnInput)(NSString *inputText);

@interface BlockViewController_input : BaseViewController

@property (nonatomic,copy) ReturnInput inputTextBlock;

-(void)returnInputText:(ReturnInput)block;

@end
