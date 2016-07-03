//
//  Container.h
//  MI
//
//  Created by dRumyankov on 5/26/16.
//  Copyright © 2016 DimaRumyankov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Container : NSObject{
    NSMutableArray <NSString *>*nodes_;

    NSMutableArray <Node *>*openNodes_;
    NSMutableArray <Node *>*closeNodes_;
    
    NSMutableArray <Node *>*pathNodes_;
    
    NSArray <NSNumber *>*terminatePattern_;
}

@property (nonatomic, strong) NSMutableArray <NSString *>*nodes;

@property (nonatomic, strong) NSMutableArray <Node *>*openNodes;
@property (nonatomic) NSMutableArray <Node *>*closeNodes;

@property (nonatomic) NSMutableArray <Node *>*pathNodes;

@property (nonatomic) NSArray <NSNumber *>*terminatePattern;

+ (id)sharedManager;

@end
