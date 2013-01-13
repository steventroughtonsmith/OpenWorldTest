//
//  ParticleNode.m
//  SceneKraft
//
//  Created by Tom Irving on 10/09/2012.
//  Copyright (c) 2012 Tom Irving. All rights reserved.
//

#import "OWTEntity.h"

@implementation OWTEntity
@synthesize velocity;
@synthesize acceleration;
@synthesize mass;
@synthesize touchingGround;


- (void)updatePositionWithRefreshPeriod:(CGFloat)refreshPeriod {
	
	velocity.x += acceleration.x * refreshPeriod;
	velocity.y += acceleration.y * refreshPeriod;
	velocity.z += acceleration.z * refreshPeriod;
	
	SCNVector3 position = self.position;
	position.x += velocity.x * refreshPeriod;
	position.y += velocity.y * refreshPeriod;
	position.z += velocity.z * refreshPeriod;
	[self setPosition:position];
}

- (void)checkCollisionWithNodes:(NSArray *)nodes {
	// TODO: Make this better.
	
	touchingGround = NO;
	__block SCNVector3 selfPosition = self.position;
	
	[nodes enumerateObjectsUsingBlock:^(SCNNode * node, NSUInteger idx, BOOL *stop) {
		
		if (self != node)
		{
			if (NodeCollision(node,selfPosition))
			{
				selfPosition.z = node.position.z+1.5;
				velocity.z = 0;
				node.opacity = 0.5;
				
				touchingGround = YES;
				*stop = YES;
			}
		}
	}];
	
	[self setPosition:selfPosition];
}

BOOL NodeCollision(SCNNode *node, SCNVector3 point)
{
	SCNVector3 min, max;
	
	[node getBoundingBoxMin:&min max:&max];
	
	min.x += node.position.x;
	min.y += node.position.y;
	min.z += node.position.z;
	
	max.x += node.position.x;
	max.y += node.position.y;
	max.z += node.position.z;
	
	return point.x <= max.x && point.x >= min.x &&
	point.y <= max.y && point.y >= min.y &&
	point.z <= max.z && point.z >= min.z ;
}


NSString *NSStringFromSCNVector3(SCNVector3 vec)
{
	return [NSString stringWithFormat:@"(%f, %f, %f)", vec.x, vec.y, vec.z];
}

@end