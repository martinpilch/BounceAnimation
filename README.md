MMMBounceAnimation
==================

CAAnimationGroup category to create parametrized Bounce animation. Simply add the files to your project, import CAAnimationGroup+BounceAnimation.h and use:

```
CAAnimationGroup *group = [CAAnimationGroup bounceAnimationGroupWithStyle:BounceAnimationStyleUp
                                                                   startCenter:button.center
                                                                          peak:10.0f
                                                                bounceDuration:0.1f
                                                                   bounceCount:5];
[button.layer addAnimation:group forKey:@"bounceAnimation"];
```
