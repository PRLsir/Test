//
//  GLESUtils.h
//  Test_ everyday
//
//  Created by prliu on 2017/4/19.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <OpenGLES/ES2/gl.h>


@interface GLESUtils : NSObject

+(GLuint)loadShader:(GLenum)type withString:(NSString*)shaderSting;
+(GLuint)loadShader:(GLenum)type withFilepath:(NSString *)shaderFilepath;
+(GLuint)loadProgram:(NSString *)vertexShaderFilepath withFragmentShaderFilepath:(NSString *)fragmentShaderFilepath;

@end
