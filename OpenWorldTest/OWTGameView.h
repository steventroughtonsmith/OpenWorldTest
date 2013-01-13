//
//  SKRGameView.h
//  OpenWorldTest
//
//  Created by Steven Troughton-Smith on 23/12/2012.
//  Copyright (c) 2012 High Caffeine Content. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SceneKit/SceneKit.h>
#import <OpenGL/gl.h>

#import "OWTLevelGenerator.h"
#import "OWTChunk.h"
#import "OWTPlayer.h"

typedef struct _SKRInput
{
	BOOL up;
	BOOL down;
	
	BOOL forward;
	BOOL backward;
	BOOL left;
	BOOL right;
	
	SCNVector3 look;
	
} SKRInput;

typedef struct _SKRPlayer
{
	BOOL moving;
	
} SKRPlayer;


typedef enum _SKRBlockType
{
	SKRBlockTypeWater,
	SKRBlockTypeDirt,
	SKRBlockTypeGrass,
	SKRBlockTypeTree
} SKRBlockType;


@interface OWTGameView : SCNView <SCNSceneRendererDelegate, SCNProgramDelegate>
{
	
	NSMutableDictionary *chunkCache;
	CATextLayer *frameRateLabel;
	
	SKRInput input;
	SKRPlayer player;
	
	OWTPlayer *playerNode;
	NSMutableArray *blocks;
	NSArray *joysticks;
	OWTLevelGenerator *gen;
	NSTrackingArea * trackingArea;
	CVDisplayLinkRef displayLinkRef;
	
	BOOL gameLoopRunning;
	SCNNode *skyNode;
	SCNNode *floorNode;
	SCNNode *lastNode;
	
	CALayer *crosshairLayer;
}

-(IBAction)reload:(id)sender;
- (CVReturn)gameLoopAtTime:(CVTimeStamp)time;
@end
