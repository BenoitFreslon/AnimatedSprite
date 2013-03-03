//
//  CCAnimatedSprite.h
//
//  Created by Benoit Freslon on 23/02/12.
//  Copyright 2013 Benoit Freslon. All rights reserved.
//  http://www.benoitfreslon.com
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
/**
 * AnimatedSprite
 * Handle sprite animations with spritesheets.
 * Optimized for Flash swf. Converted with TexturePacker
 *
 * @author Benoit Freslon
 * @version 1.04
 * @date 03/03/2013
 */
@interface AnimatedSprite : CCSprite  {
    /** CCAction of the current animation */
    CCAction *currentAnimAction;
    /** Name of the current animation */
    //NSString *currentAnimation;
    /** This dictionary contains all registred animations */
    NSMutableDictionary *animations;
}

@property (weak, nonatomic) NSString *currentAnimation;

/**
 * Add and registred a looping animation in the sprite
 *
 * @param pName     Name of the animation
 * @param frame     The frame of the spritesheet. Start from 0. Eg: img%04d.png > img0000.png
 * @param delay     Delay in ms on each frames.
 */
- (void) addLoopingAnimation:(NSString *)pName frame:(NSString *)pFrame delay:(float)pDelay;

/**
 * Add and registred an animation in the sprite
 *
 * @param pName     Name of the animation
 * @param frame     The frame of the spritesheet. Start from 0. Eg: img%04d.png > img0000.png
 * @param delay     Delay in ms on each frames.
 */
- (void)addAnimation:(NSString *)pName frame:(NSString *)pFrame delay:(float)pDelay;
/**
 * Add and registred an animation in the sprite with callback
 *
 * @param pName     Name of the animation
 * @param frame     The frame of the spritesheet. Start from 0. Eg: img%04d.png > img0000.png
 * @param delay     Delay in ms on each frames.
 * @param target    id of the callback method
 * @param callback  callback selector
 */
- (void) addAnimation:(NSString *)pName frame:(NSString *)pFrame delay:(float)pDelay target:id callback:(SEL)pCallBack;

/**
 * Start a registred animation
 *
 * @param pName     Name of the registred animation
 */
- (void) startAnimation:(NSString *)pName;

/**
 * Start a registred animation
 *
 * @param pName     Name of the registred animation
 * @param pRestart  Do you restart the animation if it's the same ?
 */
- (void) startAnimation:(NSString *)pName restart:(BOOL)pRestart;


/**
 * Stop the current animation
 */
- (void) stopCurrentAnimation;

/**
 * Stop a registred animation
 *
 * @param pName     Name of the animation to stop.
 */
- (void) stopAnimation:(NSString *)pName;
/**
 * Pause the current animation
 *
 * @param pName     Name of the animation to stop.
 */
- (void) pauseCurrentAnimation;
/**
 * Resume the current animation
 *
 * @param pName     Name of the animation to stop.
 */
- (void) resumeCurrentAnimation;
@end
