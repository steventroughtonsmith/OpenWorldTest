//
//  ParticleNode.h
//  SceneKraft
//
//  Created by Tom Irving on 10/09/2012.
//  Copyright (c) 2012 Tom Irving. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface OWTEntity : SCNNode {
	
	SCNVector3 velocity;
	SCNVector3 acceleration;
	CGFloat mass;
	
	BOOL touchingGround;
}

@property (nonatomic, assign) SCNVector3 velocity;
@property (nonatomic, assign) SCNVector3 acceleration;
@property (nonatomic, assign) CGFloat mass;
@property (nonatomic, readonly) BOOL touchingGround;

- (void)updatePositionWithRefreshPeriod:(CGFloat)refreshPeriod;
- (void)checkCollisionWithNodes:(NSArray *)nodes;

@end
