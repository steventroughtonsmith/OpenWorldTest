//
//  PlayerNode.h
//  SceneKraft
//
//  Created by Tom Irving on 09/09/2012.
//  Copyright (c) 2012 Tom Irving. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "OWTEntity.h"

@interface OWTPlayer : OWTEntity {
	
	SCNVector4 movement;
	CGFloat rotationUpDown;
	CGFloat rotationLeftRight;
}

@property (nonatomic, assign) SCNVector4 movement;
@property (nonatomic, assign, readonly) CGFloat rotationUpDown;
@property (nonatomic, assign, readonly) CGFloat rotationLeftRight;

+ (OWTPlayer *)node;
- (void)rotateByAmount:(CGSize)amount;

@end