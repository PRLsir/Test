//
//  KVOViewController.h
//  Test_ everyday
//
//  Created by prliu on 2017/4/1.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVOViewController : UIViewController

@end

@interface TwoTimesArray : NSObject

-(void)incrementCount;
-(NSUInteger)countOfNumbers;
-(id)objectInNumbersAtIndex:(NSUInteger)index;

@end
