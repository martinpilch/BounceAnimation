//
//  CAAnimationGroup+BounceAnimation.h
//  
//
//  Created by Martin Pilch on 3/10/13.
//
//

#import <QuartzCore/QuartzCore.h>

typedef enum _BounceAnimationStyle {
  BounceAnimationStyleLeft,
  BounceAnimationStyleRight,
  BounceAnimationStyleUp,
  BounceAnimationStyleDown
} BounceAnimationStyle;

@interface CAAnimationGroup (BounceAnimation)

+ (CAAnimationGroup *)bounceAnimationGroupWithStyle:(BounceAnimationStyle)style startCenter:(CGPoint)startCenter peak:(CGFloat)peak bounceDuration:(CGFloat)bounceDuration bounceCount:(NSInteger)bounceCount;

@end
