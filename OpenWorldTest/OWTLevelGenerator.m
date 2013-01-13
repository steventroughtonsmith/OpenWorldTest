//
//  OBLevelGenerator.m
//  onebutton
//
//  Created by Steven Troughton-Smith on 24/12/2011.
//  Copyright (c) 2011 High Caffeine Content. All rights reserved.
//

/*
 
	This is a Perlin-based noise generator using code from http://www.dreamincode.net/forums/topic/66480-perlin-noise/
 
 */

#import "OWTLevelGenerator.h"

const int NOISE_P_X = 1619;
const int NOISE_P_Y = 31337;
const int NOISE_P_SEED = 1013;

int seed = 1;

double interpolate1(double a,double b,double x)
{
	double ft=x * M_PI;
	double f=(1.0-cos(ft))* 0.5;
	return a*(1.0-f)+b*f;
}

double findnoise2(double x,double y)
{
	int n = (NOISE_P_X*(int)x + NOISE_P_Y*(int)y + NOISE_P_SEED * seed) & 0x7fffffff;
	
	n = (n >> 13) ^ n;
	n = (n * (n * n * 60493 + 19990303) + 1376312589) & 0x7fffffff;
	return 1.0 - (double)n/1073741824;
}

double noise2(double x,double y)
{
	double floorx=(double)((int)x);//This is kinda a cheap way to floor a double integer.
	double floory=(double)((int)y);
	double s,t,u,v;//Integer declaration
	s=findnoise2(floorx,floory);
	t=findnoise2(floorx+1,floory);
	u=findnoise2(floorx,floory+1);//Get the surrounding pixels to calculate the transition.
	v=findnoise2(floorx+1,floory+1);
	double int1=interpolate1(s,t,x-floorx);//Interpolate between the values.
	double int2=interpolate1(u,v,x-floorx);//Here we use x-floorx, to get 1st dimension. Don't mind the x-floorx thingie, it's part of the cosine formula.
	return interpolate1(int1,int2,y-floory);//Here we use y-floory, to get the 2nd dimension.
}


@implementation OWTLevelGenerator

- (id)init {
    self = [super init];
    if (self) {
         seed = arc4random()%INT32_MAX;		
	}
	
    return self;
}

-(void)gen:(int)featureSize
{
	// w and h speak for themselves, zoom well zoom in and out on it, I usually
	// use 75. P stands for persistence, this controls the roughness of the picture, i use 1/2
	
	int octaves=2;
	double p = 1/2;
	double zoom = (double)featureSize;
	
	for(int y=0;y<MAP_BOUNDS;y++)
	{
		for(int x=0;x<MAP_BOUNDS;x++)
		{
			double getnoise =0;
			for(int a=0;a<octaves-1;a++)//This loops trough the octaves.
			{
				double frequency = pow(2,a); //This increases the frequency with every loop of the octave.
				double amplitude = pow(p,a); //This decreases the amplitude with every loop of the octave.
				
				getnoise += noise2(((double)x)*frequency/zoom,((double)y)/zoom*frequency)*amplitude; //This uses our perlin noise functions. It calculates all our zoom and frequency and amplitude
				
			}
			
			double color= (double)((getnoise*128.0)+128.0); //Convert to 0-256 values.
			
			if(color>255)
				color=255;
			if(color<0)
				color=0;
			
			values[x][y] = color;
			
		}
	}
}

-(double)valueForX:(int)x Y:(int)y
{
    return values[x][y];
}

@end
