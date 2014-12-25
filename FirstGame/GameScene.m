//
//  GameScene.m
//  FirstGame
//
//  Created by Diana Krasnozhenova on 12/24/14.
//  Copyright (c) 2014 Diana Krasnozhenova. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKNode *_bgLayer;
    SKNode *_gameLayer;
    SKNode *_HUDLayer;
    NSTimeInterval *_dt;
    NSTimeInterval *_lastUpdateTime;
    SKSpriteNode *_playerPlane;
}

static const uint32_t planeCategory = 1 << 0;
static const uint32_t worldCategory = 1 << 1;
static const uint32_t pipeCategory = 1 << 2;
static const uint32_t scoreCategory = 1 << 3;
static const uint32_t skyCategory = 1 << 4;

- (id) initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {

    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */

    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
            
            _bgLayer = [SKNode node];
            [self addChild:_bgLayer];
            _gameLayer = [SKNode node];
            [self addChild:_gameLayer];
            _HUDLayer = [SKNode node];
            [self addChild:_HUDLayer];
    
            SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:@"Background"];
            SKAction *moveBg = [SKAction moveByX:-backgroundTexture.size.width*2 y:0 duration:0.1*backgroundTexture.size.width];
            SKAction *resetBg = [SKAction moveByX:backgroundTexture.size.width*2 y:0 duration:0];
            SKAction *moveBgForever = [SKAction repeatActionForever: [SKAction sequence:@[moveBg, resetBg]]];
            
            for (int i = 0; i < 2 + self.frame.size.width / (backgroundTexture.size.width * 2); ++i) {
                SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
                [sprite setScale:1.0];
                sprite.zPosition = -20;
                sprite.anchorPoint = CGPointZero;
                sprite.position = CGPointMake(i * sprite.size.width, 0);
                [sprite runAction:moveBgForever];
                [_bgLayer addChild:sprite];
                
            }
            
            SKTexture *groundTexture = [SKTexture textureWithImageNamed:@"Ground"];
            SKAction *moveGroundSprite = [SKAction moveByX:-groundTexture.size.width * 2 y:0 duration:0.02 * groundTexture.size.width * 2];
            SKAction *resetGroundSprite = [SKAction moveByX:groundTexture.size.width * 2 y:0 duration:0];
            SKAction *moveGroundSpritesForever = [SKAction repeatActionForever: [SKAction sequence:@[moveGroundSprite, resetGroundSprite]]];
            
            for (int i = 0; i < 2 + self.frame.size.width / (groundTexture.size.width * 2); ++i) {
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:groundTexture];
            [sprite setScale:1.0];
            sprite.zPosition = 10;
            sprite.anchorPoint = CGPointZero;
            sprite.position = CGPointMake(i * sprite.size.width, 0);
            [sprite runAction:moveGroundSpritesForever];
            [_gameLayer addChild:sprite];
            
                    }
            
            _playerPlane = [SKSpriteNode spriteNodeWithImageNamed:@"Plane"];
            _playerPlane.position = CGPointMake(350, 400);
            _playerPlane.zPosition = 50;
            _playerPlane.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(46, 18)];
            _playerPlane.physicsBody.dynamic = YES;
            _playerPlane.physicsBody.allowsRotation = NO;
            _playerPlane.physicsBody.categoryBitMask = planeCategory;
            _playerPlane.physicsBody.collisionBitMask = worldCategory | pipeCategory | skyCategory;
            _playerPlane.physicsBody.contactTestBitMask = worldCategory | pipeCategory | skyCategory;
            [_gameLayer addChild:_playerPlane];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
