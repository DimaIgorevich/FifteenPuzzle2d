//
//  Graph.m
//  MI
//
//  Created by dRumyankov on 5/25/16.
//  Copyright © 2016 DimaRumyankov. All rights reserved.
//

#import "Graph.h"
#import "Container.h"

@implementation Graph

- (id)initWithStartState:(NSMutableArray <NSNumber *>*)gameState{
    if(self = [super init]){
        _startNode = [[Node alloc] init];
        _startNode.parrentNode = nil;
        _startNode.type = kStartNode;
        _startNode.g = kStartNode;
        _startNode.nodeContainer = [NSMutableArray arrayWithArray:gameState];
        
    }
    return self;
}

- (void)drawGraph{
        [_startNode drawChild];
}

@end
