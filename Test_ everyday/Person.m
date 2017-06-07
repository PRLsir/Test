//
//  Person.m
//  Test_ everyday
//
//  Created by prliu on 2017/3/7.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "Person.h"

@implementation Person

-(instancetype)init{

    self = [super init];
    if (self) {
        
    
        
    }
//    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    [self addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    return self;
}

-(void)dealloc{

//    [self removeObserver:self forKeyPath:@"name"];
//    [self removeObserver:self forKeyPath:@"age"];

}

//解档
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ([super init]) {
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}



-(NSString *)description{


    return [NSString stringWithFormat:@"name = %@ age = %ldc",_name,_age];


}

+(NSString *)description{

 return @"dsfj";
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    NSLog(@"keyPath:%@",keyPath);

}

@end
