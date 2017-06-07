//
//  GLESUtils.m
//  Test_ everyday
//
//  Created by prliu on 2017/4/19.
//  Copyright © 2017年 prliu. All rights reserved.
//

#import "GLESUtils.h"

@implementation GLESUtils


+(GLuint)loadProgram:(NSString *)vertexShaderFilepath withFragmentShaderFilepath:(NSString *)fragmentShaderFilepath{

    GLuint vertextShader = [self loadShader:GL_VERTEX_SHADER withFilepath:vertexShaderFilepath];
    
    if (vertextShader == 0) {
        return 0;
    }
    
    GLuint fragmentShader = [self loadShader:GL_FRAGMENT_SHADER withFilepath:fragmentShaderFilepath];
    
    if (fragmentShader == 0) {
        glDeleteShader(vertextShader);
        return 0;
    }
    
    GLuint programHandle = glCreateProgram();
    if (programHandle == 0) {
        return 0;
    }
    
    glAttachShader(programHandle, vertextShader);
    glAttachShader(programHandle, fragmentShader);
    
    glLinkProgram(programHandle);
    
    // Check the link status
    GLint linked;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linked);
    
    if (!linked) {
        GLint infoLen = 0;
        glGetProgramiv(programHandle, GL_INFO_LOG_LENGTH, &infoLen);
        
        if (infoLen > 1){
            char * infoLog = malloc(sizeof(char) * infoLen);
            glGetProgramInfoLog(programHandle, infoLen, NULL, infoLog);
            
            NSLog(@"Error linking program:\n%s\n", infoLog);
            
            free(infoLog);
        }
        
        glDeleteProgram(programHandle );
        return 0;
    }
    
    // Free up no longer needed shader resources
    glDeleteShader(vertextShader);
    glDeleteShader(fragmentShader);
    
    return programHandle;

}

+(GLuint)loadShader:(GLenum)type withString:(NSString*)shaderSting{
    
    GLuint shader = glCreateShader(type);
    if (shader == 0) {
        return 0;
    }
    
    const char * shaderStringUTF8 = [shaderSting UTF8String];
    glShaderSource(shader, 1, &shaderStringUTF8, NULL);
    
    glCompileShader(shader);
    
    GLint compiled = 0;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);
    
    if (!compiled) {
        GLint infoLen = 0;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &infoLen);
        
        if (infoLen > 1) {
            char * infoLog = malloc(sizeof(char) * infoLen);
            glGetShaderInfoLog(shader, infoLen, NULL, infoLog);
            free(infoLog);
        }
        glDeleteShader(shader);
        return 0;
    }
    return shader;
}

+(GLuint)loadShader:(GLenum)type withFilepath:(NSString *)shaderFilepath{
    
    NSError *error;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderFilepath encoding:NSUTF8StringEncoding error:&error];
    return [self loadShader:type withString:shaderString];
}


@end
