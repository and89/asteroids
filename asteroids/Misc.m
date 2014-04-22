#import "Misc.h"

BOOL intersect(AABB aabb1, AABB aabb2)
{
    if(fabsf(aabb1.c.x - aabb2.c.x) > (aabb1.r + aabb2.r))
        return NO;
    if(fabsf(aabb1.c.y - aabb2.c.y) > (aabb1.r + aabb2.r))
        return NO;
    
    return YES;
}

BOOL outOfScreen(CGSize screenRect, CGPoint pos, CGVector vel)
{
    if(((pos.x < 0) && (vel.dx < 0.0f)) ||
       ((pos.x > screenRect.width) && (vel.dx > 0.0f)) ||
       ((pos.y < 0) && (vel.dy < 0.0f)) ||
       ((pos.y > screenRect.height) && (vel.dy > 0.0f)))
    {
        return YES;
    }
        
    return NO;
}