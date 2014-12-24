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
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
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
