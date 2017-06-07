//
//  Person.h
//  Test_ everyday
//
//  Created by prliu on 2017/3/7.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Person : NSObject

@property (strong, nonatomic) UIImage *avatar;
@property (copy  , nonatomic)   NSString *name;
@property (assign, nonatomic) NSInteger age;

//KVC KVO
@property (nonatomic,strong) NSString *temo_kvc;

-(NSString *)description;
+(NSString *)description;

@end
