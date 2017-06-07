//
//  OpenGLView.m
//  Test_ everyday
//
//  Created by prliu on 2017/4/17.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "OpenGLView.h"
#import "GLESUtils.h"

@interface OpenGLView ()
{
    CAEAGLLayer *_glLayer;
    CVEAGLContext _glContext;
    
    GLuint _renderBuffers;
    GLuint _frameBuffers;
    
    GLuint _programHandle;
    GLuint _positionSlot;
    GLuint _positionSlot1;

}

@end

@implementation OpenGLView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
       
        [self createlayer];
        [self createContext];
        [self renderBuff];
        [self frameBuff];
        [self program];
        [self render];
        
    }
    return self;
}

-(void)createlayer{

    _glLayer = (CAEAGLLayer*)self.layer;
    _glLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],kEAGLDrawablePropertyRetainedBacking,kEAGLColorFormatRGBA8,kEAGLDrawablePropertyColorFormat, nil];

}

-(void)createContext{

    _glContext = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:_glContext];

}

-(void)renderBuff{

    glGenRenderbuffers(1, &_renderBuffers);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffers);
    [_glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:_glLayer];

}

-(void)frameBuff{
    
    glGenFramebuffers(1, &_frameBuffers);
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffers);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0 , GL_RENDERBUFFER, _renderBuffers);
    
}

-(void)program{

    NSString *vertexShaderPath = [[NSBundle mainBundle]pathForResource:@"VertexShader" ofType:@"glsl"];
    NSString *fragmentShaderPath = [[NSBundle mainBundle]pathForResource:@"FragmentShader" ofType:@"glsl"];
    
    _programHandle = [GLESUtils loadProgram:vertexShaderPath withFragmentShaderFilepath:fragmentShaderPath];
    glUseProgram(_programHandle);
    _positionSlot = glGetAttribLocation(_programHandle, "vPosition");

}

-(void)render{

    glClearColor(0, 1, 1, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    GLfloat vertices[] = {
    
        -0.5f,0.5f,0.0f,
        0.5f,0.5f,0.0f,
        0.5f,-0.5f,0.0f,
        -0.5f,-0.5f,0.0f
    
    };
    GLfloat vertices_1[] = {
        
        -0.5f,0.5f,0.0f,
        0.5f,0.5f,0.0f,
        -0.5f,-0.5f,0.0f
        
    };
    glVertexAttribPointer(_positionSlot, 3 , GL_FLOAT, GL_FALSE, 0, vertices);
    glEnableVertexAttribArray(_positionSlot);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    [_glContext presentRenderbuffer:GL_RENDERBUFFER];
    
    glVertexAttribPointer(_positionSlot1, 3 , GL_FLOAT, GL_FALSE, 0, vertices_1);
    glEnableVertexAttribArray(_positionSlot1);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    [_glContext presentRenderbuffer:GL_RENDERBUFFER];

}

+(Class)layerClass{

   return  [CAEAGLLayer class];
    
}

- (void)layoutSubviews
{
 
}

@end
