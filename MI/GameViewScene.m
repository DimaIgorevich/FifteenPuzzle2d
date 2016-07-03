//
//  GameViewScene.m
//  MI
//
//  Created by dRumyankov on 5/25/16.
//  Copyright © 2016 DimaRumyankov. All rights reserved.
//

#import "GameViewScene.h"
#import "UICollectionViewCellNode.h"
#import "NSMutableArray+EqualsEmelent.h"
#import <time.h>
#import "Container.h"

#define kTypeEmptyCell @"*"

const NSInteger kCountCellSection = 16;
const NSInteger kCountCellInSection = 4;
const NSInteger kEmptyCell = 0;

@interface GameViewScene()

@property CGSize parrentWinSize;
@property NSMutableArray <NSNumber *>*container;

@end

@implementation GameViewScene

- (void)viewDidLoad{
    _parrentWinSize = self.view.frame.size;
}

- (void)viewWillAppear:(BOOL)animated{
    srand((unsigned)time(NULL));
    [super viewWillAppear:animated];
    _isReadyPath = NO;
    _container = [[NSMutableArray alloc] initWithObjects:
//                  [NSNumber numberWithInt:2],
//                  [NSNumber numberWithInt:3],
//                  [NSNumber numberWithInt:4],
//                  [NSNumber numberWithInt:7],
//                  [NSNumber numberWithInt:11],
//                  [NSNumber numberWithInt:1],
//                  [NSNumber numberWithInt:5],
//                  [NSNumber numberWithInt:6],
//                  [NSNumber numberWithInt:0],
//                  [NSNumber numberWithInt:12],
//                  [NSNumber numberWithInt:15],
//                  [NSNumber numberWithInt:8],
//                  [NSNumber numberWithInt:10],
//                  [NSNumber numberWithInt:9],
//                  [NSNumber numberWithInt:13],
//                  [NSNumber numberWithInt:14],nil];
                                    [NSNumber numberWithInt:2],
                                    [NSNumber numberWithInt:5],
                                    [NSNumber numberWithInt:7],
                                    [NSNumber numberWithInt:3],
                                    [NSNumber numberWithInt:1],
                                    [NSNumber numberWithInt:11],
                                    [NSNumber numberWithInt:0],
                                    [NSNumber numberWithInt:4],
                                    [NSNumber numberWithInt:9],
                                    [NSNumber numberWithInt:6],
                                    [NSNumber numberWithInt:10],
                                    [NSNumber numberWithInt:8],
                                    [NSNumber numberWithInt:13],
                                    [NSNumber numberWithInt:14],
                                    [NSNumber numberWithInt:15],
                                    [NSNumber numberWithInt:12],nil];

//    _container = [[NSMutableArray alloc] init];
//    for(int i = 0; i <kCountCellSection; i++){
//        NSInteger randomValue = rand()%kCountCellSection;
//        while ([_container isExsistIntegerValue:randomValue]) {
//            randomValue = rand()%kCountCellSection;
//        }
//        NSNumber *number = [NSNumber numberWithInteger:randomValue];
//        [_container addObject:number];
//    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ready) name:@"pathIsReady" object:nil];
    
    if([self isSolution]){
        _gameGraph = [[Graph alloc] initWithStartState:_container];
    
    //dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_gameGraph drawGraph];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"not solve" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    //});
    
}

- (void)ready{
    _isReadyPath = YES;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Path is find" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(_parrentWinSize.width/kCountCellInSection,_parrentWinSize.width/kCountCellInSection);
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return kCountCellSection;
}

- (BOOL)isSolution{
    int inv = 0;
    for(int i = 0; i < _container.count; i++){
        int value = [_container objectAtIndex:i].intValue;
        if(value){
            for(int j = 0; j < i; j++){
                int value2 = [_container objectAtIndex:j].intValue;
                if(value2 > value){
                    ++inv;
                }
            }
        }
    }
    
    for(int i=0;i<_container.count; i++){
        int value = [_container objectAtIndex:i].intValue;
        if(value == 0){
            inv += 1 + i/4;
        }
    }
    
    return (inv & 1)?NO:YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCellNode *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gameNode" forIndexPath:indexPath];
    
    NSNumber *currentObject = [_container objectAtIndex:indexPath.row];
    
    if([self isEmptyCell:currentObject.integerValue]){
        cell.titleLabel.text = kTypeEmptyCell;
    } else {
        cell.titleLabel.text = [NSString stringWithFormat:@"%d", currentObject.intValue];
    }
    
    return cell;
}

- (BOOL)isEmptyCell:(NSInteger)kType{
    return kType == kEmptyCell;
}

- (IBAction)touch:(id)sender {
    if(_isReadyPath){
        NSLog(@"tap");
        if([[Container sharedManager] pathNodes].count != 0){
            _container = [[[Container sharedManager] pathNodes] lastObject].nodeContainer;
            [[[Container sharedManager] pathNodes] removeLastObject];
            [_collectionView reloadData];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Is ready!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
}
@end
