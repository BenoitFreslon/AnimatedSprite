//
//  CCAnimatedSprite.m
//
//  Created by Benoit Freslon on 23/02/12.
//  Copyright 2013 Benoit Freslon. All rights reserved.
//  http://www.benoitfreslon.com
//

#import "AnimatedSprite.h"

@implementation AnimatedSprite

@synthesize currentAnimation = _currentAnimation;

-(id) initWithTexture:(CCTexture2D*)texture rect:(CGRect)rect rotated:(BOOL)rotated {
    //CCLOG(@"*** AnimatedSprite: initWithTexture");
    if ((self = [super initWithTexture:texture rect:rect rotated:rotated]) ) {
        self.currentAnimation = @"";
        animations = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (void)addLoopingAnimation:(NSString *)pName frame:(NSString *)pFrame delay:(float)pDelay {
    //CCLOG(@"**** AnimatedSprite: addLoopingAnimation: %@", pName);
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i=0;;i++) {
        NSString *str = [NSString stringWithFormat:pFrame, i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:str];
        if(frame == nil) {
            //CCLOGWARN(@"*** AnimatedSprite No frames found: %@", str);
            break;
        } else {
            [animFrames addObject:frame];
        }
    }
    
    if ([animFrames count] == 0) {
        //CCLOGWARN(@"*** AnimatedSprite: ERROR NO IMAGES IN FRAMES %@",self);
        return;
    }
    
    id animation = [CCAnimation animationWithSpriteFrames:animFrames delay:pDelay];
    id animationLoop = [CCAnimate actionWithAnimation:animation];

    CCRepeatForever *repeatAnimation = [CCRepeatForever actionWithAction:animationLoop];
    [animations setValue:repeatAnimation forKey:pName];
}

- (void)addAnimation:(NSString *)pName frame:(NSString *)pFrame delay:(float)pDelay {
    [self addAnimation:pName frame:pFrame delay:pDelay target:nil callback:nil];
}

- (void)addAnimation:(NSString *)pName frame:(NSString *)pFrame delay:(float)pDelay target:(id)pTarget callback:(SEL)pCallBack {
    //CCLOG(@"*** AnimatedSprite: addAnimation: %@", pName);
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i=0;;i++) {
        NSString *str = [NSString stringWithFormat:pFrame, i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:str];
        if(frame == nil) {
            //CCLOGWARN(@"*** AnimatedSprite: No frames found: %@", str);
            break;
        } else {
            [animFrames addObject:frame];
        }
    }
    if ([animFrames count] == 0) {
        //CCLOGWARN(@"*** AnimatedSprite: ERROR NO IMAGE IN FRAMES: %@ %@",pFrame, self );
        return;
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:pDelay];
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    
    CCCallFunc *callback = [CCCallFunc actionWithTarget:pTarget selector:pCallBack];
    if (pTarget == nil && pCallBack == nil) {
        callback = [CCCallFunc actionWithTarget:self  selector:@selector(dummyMethod)];
    }
    
    CCSequence *seq = [CCSequence actions:animate, callback , nil];
    
    [animations setValue:seq forKey:pName];
}
- (void) dummyMethod {
    
}
- (void)startAnimation:(NSString *)pName {
    //CCLOG(@"*** AnimatedSprite: startAnimation %@ %i %@",pName, self.tag, currentAnimation);
    /*
     if (![pName isEqualToString:currentAnimation]) {
     [self stopCurrentAnimation];
     }
     */
    [self resumeCurrentAnimation];
    [self stopCurrentAnimation];
    
    self.currentAnimation = pName;
    currentAnimAction = (CCAction *)[animations objectForKey:pName];
    //CCLOG(@"currentaciton: %@", currentAnimAction);
    if (currentAnimAction == nil) {
        CCLOGWARN(@"*** AnimatedSprite: ERROR CAN'T FIND ANIMATION: %@ %@", pName, self);
        
        return;
    }
    
    [self runAction:currentAnimAction];
}
- (void)startAnimation:(NSString *)pName restart:(BOOL)pRestart {
    //CCLOG(@"*** AnimatedSprite: startAnimation %@", pName);
    if ([self.currentAnimation isEqualToString:pName] && pRestart == YES) {
        [self startAnimation:pName];
    } else if (![self.currentAnimation isEqualToString:pName]) {
        [self startAnimation:pName];
    }
    [self resumeCurrentAnimation];
}
- (void)stopCurrentAnimation {
    //CCLOG(@"AnimatedSprite: stopCurrentAnimation %i, %@", self.tag, self);
    if (currentAnimAction != nil) {
        if ([currentAnimAction isDone] == NO) {
            [self stopAction:currentAnimAction];
            [currentAnimAction stop];
        }
        self.currentAnimation = @"";
    }
}
- (void)stopAnimation:(NSString *)pName {
    //CCLOG(@"*** AnimatedSprite: stopAnimation %@ %i %@",pName, self.tag, self);
    if ([pName isEqualToString:self.currentAnimation]) {
        if ([currentAnimAction isDone] == NO) {
            [self stopAction:currentAnimAction];
        }
        self.currentAnimation = @"";
    }
}
- (void)pauseCurrentAnimation {
    //CCLOG(@"AnimatedSprite: pauseCurrentAnimation %@", currentAnimAction);
    [self pauseSchedulerAndActions];
    [[[CCDirector sharedDirector] actionManager] pauseTarget:self];
}
- (void)resumeCurrentAnimation {
    [self resumeSchedulerAndActions];
    [[[CCDirector sharedDirector] actionManager] resumeTarget:self];
}
- (void)dealloc {
    //CCLOG(@"AnimatedSprite: dealloc %@",self);
    [self stopCurrentAnimation];
    [self stopAllActions];
    [self unscheduleAllSelectors];
    
    for (NSString* key in [animations allKeys]) {
        CCAction *action = [animations objectForKey:key];
        //CCLOG(@"action %@", action);
        [self stopAction:action];
        [action stop];
    }
    
    [animations removeAllObjects];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
}
@end
