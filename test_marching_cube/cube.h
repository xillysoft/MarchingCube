//
//  cube.h
//  test_marching_cube
//
//  Created by 赵小健 on 3/23/16.
//  Copyright © 2016 赵小健. All rights reserved.
//
#include <stdio.h>
#include <objc/objc.h>

#ifndef cube_h
#define cube_h

typedef struct{
    float x;
    float y;
    float z;
}XYZ; //3-d point

typedef struct {
    XYZ p[3]; //a triangle consists of 3 points
} TRIANGLE;

typedef struct {
    XYZ p[8]; //8 vertices of this grid
    double val[8]; //values for 8 vertices of this grid
} GRIDCELL;

void MarchingCube(float isovalue, float gridSize, float X0, float X1, float Y0, float Y1, float Z0, float Z1);
float metaball(float x, float y, float z);
int Polygonise(GRIDCELL grid,double isolevel,TRIANGLE triangles[5]);
XYZ VertexInterplate(float isolevel,XYZ P1, XYZ P2,float v0, float v1);
void drawTriangles(int numTriangles, TRIANGLE *triangles);
XYZ vectorFromTwoPoints(XYZ P1, XYZ P0);
XYZ vectorMultiply(XYZ v1, XYZ v2);
void vectorNormalize(XYZ *pN);

#endif /* cube_h */
