//
//  ViewController.swift
//  PMAnimationLabelView_demo_swift
//
//  Created by Taku Inoue on 2015/04/07.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.backgroundColor = UIColor.whiteColor()

        var animationLabel : PMAnimationLabelView = PMAnimationLabelView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100))
        animationLabel.text = "Loading..."
        animationLabel.font = UIFont.boldSystemFontOfSize(40)
        animationLabel.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) / 2)

        self.view.addSubview(animationLabel)

        animationLabel.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

