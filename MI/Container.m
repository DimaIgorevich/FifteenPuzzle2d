//
//  Container.m
//  MI
//
//  Created by dRumyankov on 5/26/16.
//  Copyright © 2016 DimaRumyankov. All rights reserved.
//

#import "Container.h"

@implementation Container

@synthesize nodes = nodes_;
@synthesize openNodes = openNodes_;
@synthesize terminatePattern = terminatePattern_;
@synthesize closeNodes = closeNodes_;
@synthesize pathNodes = pathNodes_;

+ (id)sharedManager{
    static Container *container = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        container = [[self alloc] init];
    });
    return container;
}

- (id)init{
    if(self = [super init]){
        nodes_ = [[NSMutableArray alloc] init];
        openNodes_ = [[NSMutableArray alloc] init];
        closeNodes_ = [[NSMutableArray alloc] init];
        pathNodes_ = [[NSMutableArray alloc] init];
        
        terminatePattern_ = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:1],
                             [NSNumber numberWithInt:2],
                             [NSNumber numberWithInt:3],
                             [NSNumber numberWithInt:4],
                             [NSNumber numberWithInt:5],
                             [NSNumber numberWithInt:6],
                             [NSNumber numberWithInt:7],
                             [NSNumber numberWithInt:8],
                             [NSNumber numberWithInt:9],
                             [NSNumber numberWithInt:10],
                             [NSNumber numberWithInt:11],
                             [NSNumber numberWithInt:12],
                             [NSNumber numberWithInt:13],
                             [NSNumber numberWithInt:14],
                             [NSNumber numberWithInt:15],
                             [NSNumber numberWithInt:0], nil];
    }
    return self;
}

@end
