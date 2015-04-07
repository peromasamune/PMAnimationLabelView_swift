//
//  PMAnimationLabelView.swift
//  PMAnimationLabelView_demo_swift
//
//  Created by Taku Inoue on 2015/04/07.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

class PMAnimationLabelView: UIView {

    //MARK : - Public Property

    var roopCount : NSInteger = 0 //Number of animation loop. Set 0 to infinite　loop animation
    var text : NSString = ""
    var font : UIFont = UIFont.boldSystemFontOfSize(17)
    var textColor : UIColor = UIColor.blackColor()
    var animationOffset : CGFloat = 5 // The amount of movement of the bounce animation (pixels)
    var animationDuration : Double = 0.2 // Animation time per label
    var animationDelay : Double = 0.1 // Animation difference between label

    //MARK : - Private Property
    private var contentView : UIView = UIView()
    private var stopAnimationFlag : Bool = false
    private var currentRoopCount : NSInteger = 0
    private var animationIndex : NSInteger = 0
    private var labelArray : Array<UILabel> = Array<UILabel>()

    //MARK : - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK : - Class Method
    func startAnimation(){
        self.reloadView()
        self.execureAnimation()
    }

    func stopAnimation(){
        self.stopAnimationFlag = false
    }

    //MARK : - Private Method
    private func initializeView(){
        for subView : UILabel in self.labelArray {
            subView.removeFromSuperview()
        }
        labelArray = Array<UILabel>()
        currentRoopCount = 0
        stopAnimationFlag = false

        contentView = UIView(frame: CGRectMake(0, 0, 10, 10))
        contentView.backgroundColor = UIColor.clearColor()
        self.addSubview(contentView)
    }

    private func reloadView(){
        self.initializeView()

        var offsetX : CGFloat = 0
        var labelHeight : CGFloat = 0

        for var i = 0; i < text.length; i++ {
            let unitString = text.substringWithRange(NSMakeRange(i, 1))

            var label : UILabel = UILabel(frame: CGRectMake(offsetX, 0, 10, 10))
            label.backgroundColor = UIColor.clearColor()
            label.text = unitString
            label.font = self.font
            label.textColor = self.textColor
            label.sizeToFit()

            self.contentView.addSubview(label)
            self.labelArray.append(label)

            offsetX += label.frame.size.width + 1
            if (labelHeight < CGRectGetHeight(label.frame)) {
                labelHeight = CGRectGetHeight(label.frame)
            }
        }

        self.contentView.frame = CGRectMake(0, 0, offsetX, labelHeight)
        self.contentView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2)
    }

    private func execureAnimation(){

        var delayInSeconds : Double = 0.0
        var duration : Double = self.animationDuration

        self.animationIndex = 1

        for label : UILabel in self.labelArray {
            let seconds = delayInSeconds * Double(NSEC_PER_SEC)
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds))
            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                UIView.animateWithDuration(duration, animations: { () -> Void in

                    var labelFrame : CGRect = label.frame
                    labelFrame.origin.y -= self.animationOffset
                    label.frame = labelFrame

                    }, completion: { (finished : Bool) -> Void in

                        UIView.animateWithDuration(duration, animations: { () -> Void in

                            var labelFrame : CGRect = label.frame
                            labelFrame.origin.y += self.animationOffset
                            label.frame = labelFrame

                            }, completion: { (finished : Bool) -> Void in

                                if (self.animationIndex == self.labelArray.count) {
                                    self.didFinishAnimation()
                                }else{
                                    self.animationIndex++
                                }
                        })
                })
            })
            delayInSeconds += self.animationDelay
        }
    }

    private func didFinishAnimation(){

        if (self.stopAnimationFlag == true) {
            return
        }

        if (self.roopCount <= 0){
            self.execureAnimation()
        }else if (self.currentRoopCount < self.roopCount){
            self.execureAnimation()
            self.currentRoopCount++;
        }
    }

}
