#import "Asteroid.h"
#import "GameApp.h"
#import "Misc.h"

@implementation Asteroid

- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize
{
    if(self = [super initWithPos:startPos size:startSize])
    {
        self.velocity = CGVectorMake(1.0f * RANDOM_MINUS_1_TO_1(), 1.0f * RANDOM_MINUS_1_TO_1());
        
        self.angVelocity = 5.0f * RANDOM_MINUS_1_TO_1();
        
        self.dead = NO;
    }
    
    return self;
}

- (instancetype)initWithPos:(CGPoint)startPos size:(CGSize)startSize vel:(CGVector)startVel
{
    if(self = [super initWithPos:startPos size:startSize])
    {
        self.position = CGPointMake(startPos.x + startSize.width / 2.0f * RANDOM_MINUS_1_TO_1(),
                                    startPos.y + startSize.height / 2.0f * RANDOM_MINUS_1_TO_1());
        
        CGFloat randomVelX = 0.5f * RANDOM_MINUS_1_TO_1();
        CGFloat randomVelY = 0.5f * RANDOM_MINUS_1_TO_1();
        
        CGVector newVelocity = CGVectorMake(startVel.dx + randomVelX, startVel.dy + randomVelY);
        
        self.velocity = newVelocity;
        
        self.angVelocity = 1.0f * RANDOM_MINUS_1_TO_1();
        
        self.dead = NO;
    }
    
    return self;
}

- (void)update:(CGFloat)delta
{
    [super update:delta];
    
    self.angle += self.angVelocity;
    
    CGSize screenRect = [[GameApp sharedGameApp] screenSize];
    
    CGFloat radius = MAX(self.size.width, self.size.height);
    
    if(self.position.x < 0 - radius)
        [self setPosition:CGPointMake(screenRect.width + radius, self.position.y)];
    
    if(self.position.x > screenRect.width + radius)
        [self setPosition:CGPointMake(0.0f - radius, self.position.y)];
    
    if(self.position.y < 0 - radius)
        [self setPosition:CGPointMake(self.position.x, screenRect.height + radius)];
    
    if(self.position.y > screenRect.height + radius)
        [self setPosition:CGPointMake(self.position.x, 0.0f - radius)];
}

- (void)draw
{
    [super draw];
    
    static const int corners = 6;
    
    static GLfloat vertices[corners * 2];
    
    static const GLubyte colors[corners * 4] = {
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
    };
    
    static GLubyte indices[corners];
    
    static BOOL verticesInited = NO;
    
    if(!verticesInited)
    {
        float angle = 0.0f;
        for(unsigned int i=0; i<corners; ++i)
        {
            vertices[i * 2] = cosf(angle);
            vertices[i * 2 + 1] = sinf(angle);
            indices[i] = i;
            angle += 2.0 * M_PI / corners;
        }
        verticesInited = YES;
    }
    
    glPushMatrix();
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    glTranslatef(self.position.x, self.position.y, 0.0f);
    glRotatef(self.angle, 0.0f, 0.0f, 1.0f);
    glScalef(self.size.width, self.size.height, 1.0f);
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    glLineWidth(2.0f);
    glDrawElements(GL_LINE_LOOP, corners, GL_UNSIGNED_BYTE, indices);
    
    glPopMatrix();
}

@end
