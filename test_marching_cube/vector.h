//
//  vector.h
//  test_marching_cube
//
//  Created by 赵小健 on 3/23/16.
//  Copyright © 2016 赵小健. All rights reserved.
//

#import <math.h>

#ifndef vector_h
#define vector_h

float distanceSquare(float x0, float y0, float z0, float x1, float y1, float z1);
float distance(float x0, float y0, float z0, float x1, float y1, float z1);
float Q_rsqrt( float number );

#endif /* vector_h */
