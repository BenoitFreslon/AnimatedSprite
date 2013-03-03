#AnimatedSprite
==============
By Benoît Freslon: http://www.benoitfreslon.com

##About
Handle your animations with your spritesheets atlases with [cocos2d-iphone 2.0](http://www.cocos2d-iphone.org/).
A simple class with simple methods: init, start, stop, restart, ...

The swf animations are converted and exported with [TexturePacker](http://www.codeandweb.com/texturepacker) for [cocos2d-iphone 2.0](http://www.cocos2d-iphone.org/).

See a tutorial example here: [Tutorial: Export your Flash animations on iPhone/iPad with cocos2D and TexturePacker](http://www.benoitfreslon.com/tutorial-export-your-flash-animations-on-iphoneipad-with-cocos2d-and-texturepacker)

##Requierements
* [cocos2d-iphone 2.0](http://www.cocos2d-iphone.org/)
* (Optional) [TexturePacker](http://www.codeandweb.com/texturepacker): Use it to export your animations.
* (Optional) Adobe Flash: Use it to create animations.

##Get started
* Include the AnimatedSprite.m and the AnimatedSprite.h into your XCode project.
* Add a compiler flag "-fobjc-arc" in XCode on AnimatedSprite.m.

##Usage
```
// Create the pig instance with a default sprite image
AnimatedSprite *pig = [AnimatedSprite spriteWithSpriteFrameName:@"pig_walk.swf/0000"];
        
// Init a looping animation
[pig addLoopingAnimation:@"walk" frame:@"pig_walk.swf/%04d" delay:0.05f];
        
// Init an animation
[pig addAnimation:@"dead" frame:@"pig_dead.swf/%04d" delay:0.05f target:self callback:@selector(removePig)];
        
// Add the sprite in the scene
[self addChild:pig];
        
// Start the walk animation
[pig startAnimation:@"walk"];
```

##Help
See the comments in AnimatedSprite.h
