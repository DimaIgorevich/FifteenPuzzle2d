//
//  GameViewScene.h
//  MI
//
//  Created by dRumyankov on 5/25/16.
//  Copyright © 2016 DimaRumyankov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Graph.h"

@interface GameViewScene : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) Graph *gameGraph;

- (IBAction)touch:(id)sender;
@property (nonatomic) BOOL isReadyPath;

@end
