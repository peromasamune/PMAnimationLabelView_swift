#PMAnimationLabelView_swift

##

![Screen1](https://github.com/peromasamune/PMAnimationLabelView_swift/blob/master/screens/screen1.png?raw=true)

swift based animation label view

## How to use

1. Create object and add subview
2. Call  `startAnimation()` to start animation

```swift
var animationLabel : PMAnimationLabelView = PMAnimationLabelView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100))
animationLabel.text = "Loading..."
animationLabel.font = UIFont.boldSystemFontOfSize(40)
animationLabel.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) / 2)

self.view.addSubview(animationLabel)

animationLabel.startAnimation()
```

## Properties

```swift
var roopCount : NSInteger = 0 //Number of animation loop. Set 0 to infinite　loop animation
var text : NSString = ""
var font : UIFont = UIFont.boldSystemFontOfSize(17)
var textColor : UIColor = UIColor.blackColor()
var animationOffset : CGFloat = 5 // The amount of movement of the bounce animation (pixels)
var animationDuration : Double = 0.2 // Animation time per label
var animationDelay : Double = 0.1 // Animation difference between label
```

##License
Copyright &copy; 2015 Peromasamune  
Distributed under the [MIT License][mit].
[MIT]: http://www.opensource.org/licenses/mit-license.php 