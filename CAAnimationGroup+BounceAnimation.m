//
//  CAAnimationGroup+BounceAnimation.m
//  
//
//  Created by Martin Pilch on 3/10/13.
//
//

#import "CAAnimationGroup+BounceAnimation.h"

#define kBounceTimeCoef 0.8f
#define kBouncePositionCoef 0.55f

@implementation CAAnimationGroup (BounceAnimation)

+ (CAAnimationGroup *)bounceAnimationGroupWithStyle:(BounceAnimationStyle)style startCenter:(CGPoint)startCenter peak:(CGFloat)peak bounceDuration:(CGFloat)bounceDuration bounceCount:(NSInteger)bounceCount {
  
  CGPoint bouncePeak = startCenter;
  switch ( style ) {
    case BounceAnimationStyleDown:
      bouncePeak.y += peak;
      break;
    case BounceAnimationStyleUp:
      bouncePeak.y -= peak;
      break;
    case BounceAnimationStyleRight:
      bouncePeak.x += peak;
      break;
    case BounceAnimationStyleLeft:
      bouncePeak.x -= peak;
      break;
    default:
      break;
  }
  
  NSArray *bounceAnimations = [CAAnimationGroup bounceAnimationWithDuration:bounceDuration
                                                                  fromPoint:startCenter
                                                                    toPoint:bouncePeak
                                                                bounceCount:bounceCount];
  
  CGFloat animationDuration = 0.0f;
  
  for ( CABasicAnimation *animation in bounceAnimations ) {
    animationDuration += 2 * animation.duration;
  }
  
  CAAnimationGroup *group = [CAAnimationGroup animation];
  group.fillMode = kCAFillModeForwards;
  group.removedOnCompletion = YES;
  group.delegate = self;
  group.duration = animationDuration;
  [group setAnimations:bounceAnimations];
  
  return group;
}

+ (NSArray*)bounceAnimationWithDuration:(CGFloat)duration fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint bounceCount:(NSUInteger)bounceCount {
  
  CGFloat base = fromPoint.x;
  CGFloat peak = toPoint.x - fromPoint.x;
  CGPoint bouncePoint = CGPointMake(base + peak, fromPoint.y);
  
  CGFloat bounceTime = duration;
  CGFloat beginTime = 0.0f;
  
  NSMutableArray *animationsArray = [NSMutableArray array];
  
  for ( int i = 0; i < bounceCount; i++ ) {
    CABasicAnimation *bounceAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [bounceAnimation setFromValue:[NSValue valueWithCGPoint:fromPoint]];
    [bounceAnimation setToValue:[NSValue valueWithCGPoint:bouncePoint]];
    bounceAnimation.fillMode = kCAFillModeForwards;
    bounceAnimation.removedOnCompletion = NO;
    bounceAnimation.autoreverses = YES;
    bounceAnimation.duration = bounceTime;
    bounceAnimation.beginTime = beginTime;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    beginTime += 2 * bounceTime;
    bounceTime *= kBounceTimeCoef;
    peak *= kBouncePositionCoef;
    bouncePoint.x = base + peak;
    
    [animationsArray addObject:bounceAnimation];
  }
  
  return animationsArray;
}

@end
