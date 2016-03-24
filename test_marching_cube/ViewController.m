//
//  ViewController.m
//  test_marching_cube
//
//  Created by 赵小健 on 3/23/16.
//  Copyright © 2016 赵小健. All rights reserved.
//

#import "ViewController.h"
#import "cube.h"

#import <GLKit/GLKit.h>
#import <OpenGLES/ES1/gl.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController (){
    GLfloat _left;
    GLfloat _right;
    GLfloat _bottom;
    GLfloat _top;
    GLfloat _zNear;
    GLfloat _zFar;
}
@property (weak, nonatomic) IBOutlet GLKView *glkView;

@property CMMotionManager *motionManager;
@property CMAttitude *attitude0;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    NSAssert(context!=nil, @"context==nil!");
    self.glkView.context = context;
    [EAGLContext setCurrentContext:context];
    self.glkView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    self.glkView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    self.glkView.delegate = self;
    self.glkView.enableSetNeedsDisplay = YES;

    [self initGL];
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 1.0/10; // 10 fps
}


-(void)initGL
{
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LEQUAL);
    
        glEnable(GL_CULL_FACE);
        glCullFace(GL_BACK);
        glFrontFace(GL_CCW);
    
    glClearColor(0, 0.5, 0.5, 1);
    
    [self.glkView addObserver:self forKeyPath:@"bounds" options:0 context:NULL];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error){
        [self.glkView setNeedsDisplay];
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.motionManager stopDeviceMotionUpdates];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if(object==self.glkView && [keyPath isEqualToString:@"bounds"]){
        //projection matrix
        _left = -1;
        _right = 1;
        _bottom = -1;
        _top = 1;
        _zNear = 1;
        _zFar = 1000;

        CGSize size = self.glkView.bounds.size;
        glMatrixMode(GL_PROJECTION);
        glLoadIdentity();
        CGFloat aspect = size.width/size.height;
        if(size.width <= size.height){ //aspect<=1
            glOrthof(_left, _right, _bottom/aspect, _top/aspect, _zNear, _zFar);
        }else //width>height, aspect>1
            glOrthof(_left*aspect, _right*aspect, _bottom, _top, _zNear, _zFar);
        
        glMatrixMode(GL_MODELVIEW);
        [self.glkView setNeedsDisplay];
    }
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    //view(camera) matrix
    {
        glLoadIdentity();
        glTranslatef(0, 0, -_zFar);
        
        GLfloat vertices[] = {
            -1, -1, 0,
            1, -1, 0,
            1, 1, 0,
            -1, 1, 0,
        };
        glEnableClientState(GL_VERTEX_ARRAY);
        glVertexPointer(3, GL_FLOAT, 0, vertices);
        glColor4f(1, 1, 0, 1);
        glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    }

    glLoadIdentity();
    glTranslatef(0, 0, -_zNear);

    glTranslatef(0, 0, -2);

    CMAttitude *attitude = [self.motionManager deviceMotion].attitude;
    if(! self.attitude0){
        self.attitude0 = attitude;
    }else{
        [attitude multiplyByInverseOfAttitude:self.attitude0];
        glRotatef(attitude.roll*2*180/M_PI, 0, 1, 0);
        glRotatef(attitude.pitch*2*180/M_PI, 1, 0, 0);
        glRotatef(attitude.yaw*2*180/M_PI, 0, 0, 1);
    }

    
    glEnableClientState(GL_VERTEX_ARRAY);
    glColor4f(1, 0, 0, 1);
    float isoValue = 1.0;
    float gridSize = 0.05;
    MarchingCube(isoValue, gridSize, -1, 1, -1, 1, -1, 1);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
