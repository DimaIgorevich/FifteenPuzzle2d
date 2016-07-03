//
//  Node.h
//  MI
//
//  Created by dRumyankov on 5/25/16.
//  Copyright © 2016 DimaRumyankov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dirrection.h"

#define terminalPattern @"1234567891011121314150"
//#define terminalPattern @"123456780"

typedef enum{
    kStartNode,
    kLeftNode,
    kRigthNode,
    kDownNode,
    kUpNode,
    kNanNode
}typeNode;

@interface Node : NSObject

@property (nonatomic) NSInteger g;
@property (nonatomic) NSInteger h;
@property (nonatomic) NSInteger f;

@property (nonatomic) typeNode type;
@property (nonatomic, strong) Node *parrentNode;

@property (nonatomic, strong) Node *leftNode;
@property (nonatomic, strong) Node *rightNode;
@property (nonatomic, strong) Node *downNode;
@property (nonatomic, strong) Node *upNode;

@property (nonatomic) NSInteger a0;
@property (nonatomic) NSInteger a1;
@property (nonatomic) NSInteger a2;
@property (nonatomic) NSInteger a3;
@property (nonatomic) NSInteger a4;
@property (nonatomic) NSInteger a5;
@property (nonatomic) NSInteger a6;
@property (nonatomic) NSInteger a7;
@property (nonatomic) NSInteger a8;
@property (nonatomic) NSInteger a9;
@property (nonatomic) NSInteger a10;
@property (nonatomic) NSInteger a11;
@property (nonatomic) NSInteger a12;
@property (nonatomic) NSInteger a13;
@property (nonatomic) NSInteger a14;
@property (nonatomic) NSInteger a15;


@property (nonatomic, strong) NSMutableArray <NSNumber *>*nodeContainer;

- (id)initWithParrent:(Node *)parrentNode typeNode:(typeNode)type down:(NSInteger)down;

- (void)drawChild;

- (NSString *)currentState;



@end
