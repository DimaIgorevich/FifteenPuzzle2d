//
//  Dirrection.m
//  MI
//
//  Created by dRumyankov on 5/25/16.
//  Copyright © 2016 DimaRumyankov. All rights reserved.
// Fabolous - Imma Do It ft. Kobe

#import "Dirrection.h"

#define criticalDirrect 4
#define offsetCriticalDirrect 3

typedef enum{
    kSixIndex = 6,
    kSevenIndex,
    kTenIndex = 10,
    kElevenIndex
}CentralIndex;

typedef enum{
    kSecondIndex = 2,
    kThirdIndex,
    kFourIndex,
    kFiveIndex,
    kEightIndex = 8,
    kNineIndex,
    kTwelveIndex = 12,
    kFourteenIndex = 14,
    kFifteenIndex
}SideIndex;

@implementation Dirrection

+ (DirrectionStruct)byIndex:(int)indexEmptyCell{
    DirrectionStruct dirrection;
    dirrection.downDirrect = dirrection.upDirrect = dirrection.leftDirrect = dirrection.rightDirrect = NO;
//    
    //NSLog(@"index Empty cell: %d", indexEmptyCell);
    
    if(indexEmptyCell == criticalDirrect || indexEmptyCell == (criticalDirrect - offsetCriticalDirrect) || indexEmptyCell == pow(criticalDirrect, 2) || indexEmptyCell == (pow(criticalDirrect, 2) - offsetCriticalDirrect)){
        dirrection =  [self criticalDirrection:indexEmptyCell];
    } else if(indexEmptyCell == kSixIndex || indexEmptyCell == kSevenIndex || indexEmptyCell == kTenIndex || indexEmptyCell == kElevenIndex
              //indexEmptyCell == kFiveIndex
              ){
        dirrection = [self allDirection];
    } else {
//        if(indexEmptyCell == kSecondIndex){
//            dirrection.leftDirrect = dirrection.rightDirrect = YES;
//            dirrection.upDirrect = YES;
//        } else if(indexEmptyCell == kEightIndex){
//            dirrection.leftDirrect = dirrection.rightDirrect = YES;
//            dirrection.downDirrect = YES;
//        } else if(indexEmptyCell == kFourIndex){
//            dirrection.downDirrect = dirrection.upDirrect = YES;
//            dirrection.leftDirrect = YES;
//        } else if(indexEmptyCell == kSixIndex){
//            dirrection.downDirrect = dirrection.upDirrect = YES;
//            dirrection.rightDirrect = YES;
//        }
        if(indexEmptyCell == kSecondIndex || indexEmptyCell == kThirdIndex){
            dirrection.leftDirrect = dirrection.rightDirrect = YES;
            dirrection.upDirrect = YES;
        } else if(indexEmptyCell == kFourteenIndex || indexEmptyCell == kFifteenIndex){
            dirrection.leftDirrect = dirrection.rightDirrect = YES;
            dirrection.downDirrect = YES;
        } else if(indexEmptyCell == kFiveIndex || indexEmptyCell == kNineIndex){
            dirrection.downDirrect = dirrection.upDirrect = YES;
            dirrection.leftDirrect = YES;
        } else if(indexEmptyCell == kEightIndex || indexEmptyCell == kTwelveIndex){
            dirrection.downDirrect = dirrection.upDirrect = YES;
            dirrection.rightDirrect = YES;
        }
    }
    return dirrection;
}

+ (DirrectionStruct)criticalDirrection:(int)index{
    DirrectionStruct dirrection;
    dirrection.downDirrect = dirrection.upDirrect = dirrection.leftDirrect = dirrection.rightDirrect = NO;
    
    if(index == criticalDirrect){
        dirrection.rightDirrect = YES;
        dirrection.upDirrect = YES;
    }
    if(index == (criticalDirrect - offsetCriticalDirrect)){
        dirrection.leftDirrect = YES;
        dirrection.upDirrect = YES;
    }
    if(index == pow(criticalDirrect, 2)){
        dirrection.downDirrect = YES;
        dirrection.rightDirrect = YES;
    }
    if(index == (pow(criticalDirrect,2) - offsetCriticalDirrect)){
        dirrection.downDirrect = YES;
        dirrection.leftDirrect = YES;
    }
    return dirrection;
}

+ (DirrectionStruct)allDirection{
    DirrectionStruct dirrection;
    dirrection.downDirrect = YES;
    dirrection.leftDirrect = YES;
    dirrection.rightDirrect = YES;
    dirrection.upDirrect = YES;
    return dirrection;
}

@end
