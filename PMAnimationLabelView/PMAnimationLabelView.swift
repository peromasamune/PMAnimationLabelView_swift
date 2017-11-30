//
//  PMAnimationLabelView.swift
//  PMAnimationLabelView_demo_swift
//
//  Created by Taku Inoue on 2015/04/07.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

public class PMAnimationLabelView: UIView {

    //MARK: - Public Property
    public var roopCount : NSInteger = 0 //Number of animation loop. Set 0 to infinite loop animation
    public var text : NSString = ""
    public var font : UIFont = UIFont.boldSystemFont(ofSize:17)
    public var textColor : UIColor = .black
    public var animationOffset : CGFloat = 5 // The amount of movement of the bounce animation (pixels)
    public var animationDuration : Double = 0.2 // Animation time per label
    public var animationDelay : Double = 0.1 // Animation difference between label
    public var labelOffset : CGFloat = 1

    //MARK: - Private Property
    private var contentView : UIView = UIView()
    private var stopAnimationFlag : Bool = false
    private var currentRoopCount : NSInteger = 0
    private var animationIndex : NSInteger = 0
    private var labelArray : Array<UILabel> = Array<UILabel>()

    //MARK: - Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Class Method
    public func startAnimation(){
        self.reloadView()
        self.executeAnimation()
    }

    public func stopAnimation(){
        self.stopAnimationFlag = false
    }

    //MARK: - Private Method
    private func initializeView(){
        for subView : UILabel in self.labelArray {
            subView.removeFromSuperview()
        }
        labelArray = Array<UILabel>()
        currentRoopCount = 0
        stopAnimationFlag = false

        contentView = UIView(frame: CGRect(x:0, y:0, width:10, height:10))
        contentView.backgroundColor = .clear
        self.addSubview(contentView)
    }

    private func reloadView(){
        self.initializeView()

        var offsetX : CGFloat = 0
        var labelHeight : CGFloat = 0

        for i in 0..<text.length {
            let unitString = text.substring(with: NSMakeRange(i, 1))
            
            let label = UILabel(frame: CGRect(x:offsetX, y:0, width:10, height:10))
            label.backgroundColor = .clear
            label.text = unitString
            label.font = self.font
            label.textColor = self.textColor
            label.sizeToFit()
            
            self.contentView.addSubview(label)
            self.labelArray.append(label)
            
            offsetX += label.frame.size.width + labelOffset
            if (labelHeight < label.frame.height) {
                labelHeight = label.frame.height
            }
        }

        self.contentView.frame = CGRect(x:0, y:0, width:offsetX, height:labelHeight)
        self.contentView.center = CGPoint(x:self.frame.width / 2, y:self.frame.height / 2)
    }

    private func executeAnimation(){

        var delayInSeconds : Double = 0.0
        let duration : Double = self.animationDuration

        self.animationIndex = 1

        for label : UILabel in self.labelArray {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds, execute: {
                UIView.animate(withDuration: duration, animations: {
                    var labelFrame : CGRect = label.frame
                    labelFrame.origin.y -= self.animationOffset
                    label.frame = labelFrame
                    
                }, completion: { (finished : Bool) -> Void in
                    UIView.animate(withDuration: duration, animations: {
                        var labelFrame : CGRect = label.frame
                        labelFrame.origin.y += self.animationOffset
                        label.frame = labelFrame
                    }, completion: { (finished : Bool) -> Void in
                        if (self.animationIndex == self.labelArray.count) {
                            self.didFinishAnimation()
                        }else{
                            self.animationIndex = self.animationIndex + 1
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
            self.executeAnimation()
        }else if (self.currentRoopCount < self.roopCount){
            self.executeAnimation()
            self.currentRoopCount = self.currentRoopCount + 1
        }
    }
}
