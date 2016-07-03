//
//  Node.m
//  MI
//
//  Created by dRumyankov on 5/25/16.
//  Copyright © 2016 DimaRumyankov. All rights reserved.
//

#import "Node.h"
#import "Container.h"

@implementation Node

- (id)initWithParrent:(Node *)parrentNode typeNode:(typeNode)type down:(NSInteger)down{
    if(self = [super init]){
        _parrentNode = parrentNode;
        _type = type;
        _nodeContainer = [NSMutableArray arrayWithArray:_parrentNode.nodeContainer];
        //_nodeContainer = [[NSMutableArray alloc] initWithArray:_parrentNode.nodeContainer];
        _g = down;
        //[self writeToStruct];
        //[self readStruct];
        [self generateContainer];
        //[self writeToStruct];
        
        _h = [self height];
        _f = [self func];
    }
    return self;
}

- (NSInteger)height{
    NSInteger h = 0;
    for(int i = 0; i < _nodeContainer.count; i++){
        if([[[Container sharedManager] terminatePattern] objectAtIndex:i].integerValue != [_nodeContainer objectAtIndex:i].integerValue){
            h++;
        }
    }
    return h;
}

- (NSInteger)func{
    return _h+_g;
}

- (void)solveCollision{
    NSLog(@"TUPIC!!!!");
    Node *nextNode = nil;
    
    //get first node from open list
    nextNode = [[[Container sharedManager] openNodes] firstObject];
    
    //remove node from open list
    [[[Container sharedManager] openNodes] removeObjectAtIndex:0];
    
    //show Next Node
    
    NSString *debug = [NSString stringWithFormat:@""];
    for(int i = 0; i < nextNode.nodeContainer.count; i++){
        if(i % 4 == 0){
            debug = [NSString stringWithFormat:@"%@\n%d", debug, [nextNode.nodeContainer objectAtIndex:i].intValue];
        } else {
            debug = [NSString stringWithFormat:@"%@ %d", debug, [nextNode.nodeContainer     objectAtIndex:i].intValue];
        }
    }
    NSLog(@"debug next node: \n%@", debug);
    
    //draw next node
    NSLog(@"count node in open list: %d", (int)[[Container sharedManager] openNodes].count);
    
    [nextNode drawChild];
}

- (void)drawChild{
    [self writeToStruct];
    [self readStruct];
    
    _h = [self height];
    _f = [self func];
    
    NSLog(@"g:%d h:%d f:%d", (int)_g, (int)_h, (int)_f);
    //add self to open list
    [[[Container sharedManager] openNodes] addObject:self];
    
    //[[[Container sharedManager] pathNodes] addObject:self];
    
    //check terminal state
    if(![[self currentState] isEqualToString:terminalPattern]){
        //NSLog(@"not terminal");
        if([[[Container sharedManager] nodes] indexOfObject:[self currentState]] == NSNotFound){
            //NSLog(@"not found");
            DirrectionStruct direction = [Dirrection byIndex:(int)[self.nodeContainer indexOfObject:[NSNumber numberWithInteger:kStartNode]]+1];
            NSMutableArray <Node *>* currentNodes = [[NSMutableArray alloc] init];
            NSInteger newG = 1;
            newG += self.g;
            
            //NSLog(@"solve direction");
            
            if(direction.leftDirrect){
                self.leftNode = [[Node alloc] initWithParrent:self typeNode:kLeftNode down:newG];
                [currentNodes addObject:self.leftNode];
            }
            if(direction.rightDirrect){
                self.rightNode = [[Node alloc] initWithParrent:self typeNode:kRigthNode down:newG];
                [currentNodes addObject:self.rightNode];
            }
            if(direction.downDirrect){
                self.downNode = [[Node alloc] initWithParrent:self typeNode:kDownNode down:newG];
                [currentNodes addObject:self.downNode];
            }
            if(direction.upDirrect){
                self.upNode = [[Node alloc] initWithParrent:self typeNode:kUpNode down:newG];
                [currentNodes addObject:self.upNode];
            }
            
            //check contain nodes in closeList and add to open
            for(Node *objectNode in currentNodes){
                if([[[Container sharedManager] nodes] indexOfObject:[objectNode currentState]] == NSNotFound){
                    if(objectNode.g < 30){
                        [[[Container sharedManager] openNodes] addObject:objectNode];
                    }
                    
                }
            }
            
            //delete parrent node from open list and add to close list
            
            [[[Container sharedManager] openNodes] removeObject:self];
            
            //[[[Container sharedManager] closeNodes] addObject:self];
            [[[Container sharedManager] nodes] addObject:[self currentState]];
            
            
            //check TUPIC SOLVE
            
            
            //set first object NODE*
            Node *nextNode = nil;
            
            int indexObject = 0;
            while ((nextNode == nil) && (indexObject < currentNodes.count)){
                if([[[Container sharedManager] nodes] indexOfObject:[[currentNodes objectAtIndex:indexObject] currentState]] == NSNotFound){
                    nextNode = [currentNodes objectAtIndex:indexObject];
                }
                indexObject++;
            }
            

            if((nextNode == nil) || (_g > 30)){
                [self solveCollision];
            } else {
                
                //get optimal variant from all set
                for(int i = indexObject; i < currentNodes.count; i++){
                    if(nextNode.f > [currentNodes objectAtIndex:i].f){
                        if([[[Container sharedManager] nodes] indexOfObject:[[currentNodes objectAtIndex:i] currentState]] == NSNotFound){
                            nextNode = [currentNodes objectAtIndex:i];
                        }
                    }
                }
            
                //show Next Node
            
                NSString *debug = [NSString stringWithFormat:@""];
                for(int i = 0; i < nextNode.nodeContainer.count; i++){
                    if(i % 4 == 0){
                        debug = [NSString stringWithFormat:@"%@\n%d", debug, [nextNode.nodeContainer objectAtIndex:i].intValue];
                    } else {
                        debug = [NSString stringWithFormat:@"%@ %d", debug, [nextNode.nodeContainer     objectAtIndex:i].intValue];
                    }
                }
                NSLog(@"debug next node: \n%@", debug);
            
                //remove nextNode from openList
                [[[Container sharedManager] openNodes] removeObject:nextNode];
                [self writeToStruct];
                
                //to next optimal Node
                [nextNode drawChild];
                
            }
            
        } else {
            [[[Container sharedManager] openNodes] removeObject:self];
            [self writeToStruct];
            
            //[[[Container sharedManager] closeNodes] addObject:self];
            [self solveCollision];
        }
        
        
    } else {
        NSLog(@"end");
                
        //create resultative path
        [[[Container sharedManager] pathNodes] addObject:self];
        
        while([[[Container sharedManager] pathNodes] lastObject].parrentNode != nil){
            [[[Container sharedManager] pathNodes] addObject:[[[Container sharedManager] pathNodes] lastObject].parrentNode];
        }
        
        //remove start state
        [[[Container sharedManager] pathNodes] removeLastObject];
        
        NSLog(@"step count: %d", [[[Container sharedManager] pathNodes] count]);
        
        //send message
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pathIsReady" object:nil];
    }
}

- (NSString *)currentState{
    NSString *state = [NSString stringWithFormat:@""];
    for(int i = 0; i < _nodeContainer.count; i++){
        state = [NSString stringWithFormat:@"%@%d",state,[_nodeContainer objectAtIndex:i].intValue];
    }
    return state;
}

- (void)generateContainer{
    NSInteger indexEmptyCell = [_parrentNode.nodeContainer indexOfObject:[NSNumber numberWithInteger:kStartNode]];
    if(_type == kLeftNode){
        [_nodeContainer removeObjectAtIndex:indexEmptyCell];
        [_nodeContainer insertObject:[_nodeContainer objectAtIndex:indexEmptyCell] atIndex:indexEmptyCell];
        
        [_nodeContainer removeObjectAtIndex:indexEmptyCell+1];
        [_nodeContainer insertObject:[NSNumber numberWithInteger:kStartNode] atIndex:indexEmptyCell+1];
    }
    if(_type == kRigthNode){
        [_nodeContainer removeObjectAtIndex:indexEmptyCell];
        [_nodeContainer insertObject:[_nodeContainer objectAtIndex:indexEmptyCell-1] atIndex:indexEmptyCell];
        
        [_nodeContainer removeObjectAtIndex:indexEmptyCell-1];
        [_nodeContainer insertObject:[NSNumber numberWithInteger:kStartNode] atIndex:indexEmptyCell-1];
        
    }
    if(_type == kUpNode){
        [_nodeContainer insertObject:[_nodeContainer objectAtIndex:indexEmptyCell+4] atIndex:indexEmptyCell];
        [_nodeContainer removeObjectAtIndex:indexEmptyCell+1];
        
        [_nodeContainer insertObject:[NSNumber numberWithInteger:kStartNode] atIndex:indexEmptyCell+4];
        [_nodeContainer removeObjectAtIndex:indexEmptyCell+5];
    }
    if(_type == kDownNode){
        [_nodeContainer removeObjectAtIndex:indexEmptyCell];
        [_nodeContainer insertObject:[_nodeContainer objectAtIndex:indexEmptyCell-4] atIndex:indexEmptyCell];
        
        [_nodeContainer removeObjectAtIndex:indexEmptyCell-4];
        [_nodeContainer insertObject:[NSNumber numberWithInteger:kStartNode] atIndex:indexEmptyCell-4];
    }
  
}

- (void)writeToStruct{
    _a0 = [_nodeContainer objectAtIndex:0].intValue;
    _a1 = [_nodeContainer objectAtIndex:1].intValue;
    _a2 = [_nodeContainer objectAtIndex:2].intValue;
    _a3 = [_nodeContainer objectAtIndex:3].intValue;
    _a4 = [_nodeContainer objectAtIndex:4].intValue;
    _a5 = [_nodeContainer objectAtIndex:5].intValue;
    _a6 = [_nodeContainer objectAtIndex:6].intValue;
    _a7 = [_nodeContainer objectAtIndex:7].intValue;
    _a8 = [_nodeContainer objectAtIndex:8].intValue;
    _a9 = [_nodeContainer objectAtIndex:9].intValue;
    _a10 = [_nodeContainer objectAtIndex:10].intValue;
    _a11 = [_nodeContainer objectAtIndex:11].intValue;
    _a12 = [_nodeContainer objectAtIndex:12].intValue;
    _a13 = [_nodeContainer objectAtIndex:13].intValue;
    _a14 = [_nodeContainer objectAtIndex:14].intValue;
    _a15 = [_nodeContainer objectAtIndex:15].intValue;
}

- (void)readStruct{
    [_nodeContainer removeAllObjects];
    _nodeContainer = nil;
    _nodeContainer = [[NSMutableArray alloc] initWithObjects:
                      [[NSNumber alloc]  initWithInteger:_a0],
                      [[NSNumber alloc]  initWithInteger:_a1],
                      [[NSNumber alloc]  initWithInteger:_a2],
                      [[NSNumber alloc]  initWithInteger:_a3],
                      [[NSNumber alloc]  initWithInteger:_a4],
                      [[NSNumber alloc]  initWithInteger:_a5],
                      [[NSNumber alloc]  initWithInteger:_a6],
                      [[NSNumber alloc]  initWithInteger:_a7],
                      [[NSNumber alloc]  initWithInteger:_a8],
                      [[NSNumber alloc]  initWithInteger:_a9],
                      [[NSNumber alloc]  initWithInteger:_a10],
                      [[NSNumber alloc]  initWithInteger:_a11],
                      [[NSNumber alloc]  initWithInteger:_a12],
                      [[NSNumber alloc]  initWithInteger:_a13],
                      [[NSNumber alloc]  initWithInteger:_a14],
                      [[NSNumber alloc]  initWithInteger:_a15], nil];
}

@end
