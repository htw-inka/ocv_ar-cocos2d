/**
 * OcvARCocos2D - Marker-based Augmented Reality with ocv_ar and Cocos2D.
 *
 * Augmented Reality "touchable" sprite - implementation file.
 *
 * Author: Markus Konrad <konrad@htw-berlin.de>, August 2014.
 * INKA Research Group, HTW Berlin - http://inka.htw-berlin.de/
 *
 * See LICENSE for license.
 */

#import "ARTouchableSprite.h"

static ccColor4F markedColor { 1.0f, 0.0f, 0.0f, 0.9f };

@implementation ARTouchableSprite

#pragma mark user interaction

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    UIView *glView = [[CCDirector sharedDirector] view];
    
    // transform UIView touch coordinates to location specific coordinates
    CGPoint uiLocation = [touch locationInView:glView];
    
    // make a hit test calling CCSpriteAR's 3D hit test method
    BOOL hit = [super hitTest3DWithTouchPoint:uiLocation];
    
    NSLog(@"ARTouchableSprite #%d: hit = %d", _arParent.objectId, hit);
    
    // change the color on a successful hit
    if (hit) {
        if (!_defaultColor) {
            _defaultColor = [CCColor colorWithCcColor4f:self.color.ccColor4f];
            [self setColor:[CCColor colorWithCcColor4f:markedColor]];
        } else {
            [self setColor:[CCColor colorWithCcColor4f:_defaultColor.ccColor4f]];
            _defaultColor = nil;
        }
    } else {
        [super touchBegan:touch withEvent:event];
    }
}

@end
