#ifndef MISC_H
#define MISC_H

#include <math.h>

#define DISTANCE(__A__, __B__) (sqrt((__A__) * (__A__) + (__B__) * (__B__)))

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

#define RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 180.0 / M_PI)


#endif