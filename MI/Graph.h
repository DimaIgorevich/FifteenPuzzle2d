//
//  Graph.h
//  MI
//
//  Created by dRumyankov on 5/25/16.
//  Copyright © 2016 DimaRumyankov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Graph : NSObject

@property (nonatomic, strong) Node *startNode;
@property (nonatomic) NSMutableArray <Node *>*graph;
@property (nonatomic) NSMutableArray <NSMutableArray *>*optimalPath;

- (id)initWithStartState:(NSMutableArray <NSNumber *>*)gameState;

- (void)drawGraph;

@end
