//
//  NSMutableArray+EqualsEmelent.m
//  MI
//
//  Created by dRumyankov on 5/25/16.
//  Copyright © 2016 DimaRumyankov. All rights reserved.
//

#import "NSMutableArray+EqualsEmelent.h"

@implementation NSMutableArray(EqualsElement)

- (BOOL)isExsistIntegerValue:(NSInteger)object{
    for(int i = 0; i < self.count; i++){
        NSNumber *value = [self objectAtIndex:i];
        if([self isEqualsIntegerValue:object with:value.intValue]){
            return YES;
        }
    }
    return NO;
}

- (BOOL)isEqualsIntegerValue:(NSInteger)object with:(NSInteger)equalsObject{
    return equalsObject == object;
}

@end
