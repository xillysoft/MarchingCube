//
//  vector.c
//  test_marching_cube
//
//  Created by 赵小健 on 3/23/16.
//  Copyright © 2016 赵小健. All rights reserved.
//

#include "vector.h"

inline float distanceSquare(float x0, float y0, float z0, float x1, float y1, float z1)
{
    const float dx=x1-x0;
    const float dy=y1-y0;
    const float dz=z1-z0;
    return dx*dx+dy*dy+dz*dz;
}


inline float distance(float x0, float y0, float z0, float x1, float y1, float z1)
{
    return sqrt(distanceSquare(x0, y0, z0, x1, y1, z1));
}

//calculate 1.0/sqrt(number)
float Q_rsqrt( float number )
{
    long i;
    float x2, y;
    const float threehalfs = 1.5F;
    
    x2 = number * 0.5F;
    y  = number;
    i  = * ( long * ) &y;                       // evil floating point bit level hacking
    i  = 0x5f3759df - ( i >> 1 );               // what the fuck?
    y  = * ( float * ) &i;
    y  = y * ( threehalfs - ( x2 * y * y ) );   // 1st iteration
    //	y  = y * ( threehalfs - ( x2 * y * y ) );   // 2nd iteration, this can be removed
    
    return y;
}