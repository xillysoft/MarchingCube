//
//  MarchingCube.m
//  test_marching_cube
//
//  Created by 赵小健 on 3/23/16.
//  Copyright © 2016 赵小健. All rights reserved.
//

#import "MarchingCube.h"
#import "vector.h"

@implementation MarchingCube

-(float)valueAtX:(float)x y:(float)y z:(float)z
{
    const float goo = 1.0; //"goo" value of metaball model
    const float S = 0.2; //size of this metaball
    const float x0=0.15, y0=0.30, z0=0.120; //location of this metaball
    
    const float dist = distance(x,y,z,x0,y0,z0);
    return dist<=S ? 1.0 : S/pow(dist, goo);
}

-(void)marchingCubeWithX:(float)x y:(float)y z:(float)z gridSize:(float)gridSize
{
    const float v0 = [self valueAtX:x y:y z:z];
    const float v1 = [self valueAtX:x+gridSize y:y z:z];
    const float v2 = [self valueAtX:x y:y+gridSize z:z];
    const float v3 = [self valueAtX:x y:y z:z+gridSize];
    
}
-(void)marchingWithGridSize:(float)gridSize u0:(float)u0 u1:(float)u1 v0:(float)v0 v1:(float)v1 w0:(float)w0 w1:(float)w1
{
    const float du = u1-u0;
    const float dv = v1-v0;
    const float dw = w1-w0;
    const int numL = du/gridSize;
    const int numM = dv/gridSize;
    const int numN = dw/gridSize;
    for(int i=0; i<numL; i++){
        const float x = u0+i*gridSize;
        for(int j=0; j<numM; j++){
            const float y = v0+j*gridSize;
            for(int k=0; k<numN; k++){
                const float z = w0+k*gridSize;
                {
                    [self marchingCubeWithX:x y:y z:z gridSize:gridSize];
                }
            }
        }
    }
}

@end
