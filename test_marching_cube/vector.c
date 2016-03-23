//
//  vector.c
//  test_marching_cube
//
//  Created by 赵小健 on 3/23/16.
//  Copyright © 2016 赵小健. All rights reserved.
//

#include "vector.h"

float distance(float x0, float y0, float z0, float x1, float y1, float z1)
{
    const float dx=x1-x0;
    const float dy=y1-y0;
    const float dz=z1-z0;
    return sqrt(dx*dx+dy*dy+dz*dz);
}
