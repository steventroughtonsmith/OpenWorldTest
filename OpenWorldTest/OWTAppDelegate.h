//
//  SKRAppDelegate.h
//  OpenWorldTest
//
//  Created by Steven Troughton-Smith on 23/12/2012.
//  Copyright (c) 2012 High Caffeine Content. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SceneKit/SceneKit.h>
#import <OpenGL/gl.h>


@interface OWTAppDelegate : NSObject <NSApplicationDelegate,SCNSceneRendererDelegate>
{
	IBOutlet SCNView *_view;
    GLuint _colorTexture, _depthTexture;
    GLuint _fbo; //offscreen framebuffer
    GLuint _program;
	GLint _cafbo;

}
@property (assign) IBOutlet NSWindow *window;

@end
