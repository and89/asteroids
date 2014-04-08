#ifndef __asteroids__GameApplication__
#define __asteroids__GameApplication__

class GameApplication
{
public:
    GameApplication();
    ~GameApplication();
    
    void Update(float _delta);
    void Draw();
    
protected:
    
private:
    GameApplication(const GameApplication &);
    GameApplication & operator=(const GameApplication &);
    
    // TODO: game objects
    // Player mPlayer;
    
    // std::vector<Asteroids> mAsteroids;
    // std::vector<Bullets> mBullets;
};

#endif /* defined(__asteroids__GameApplication__) */
