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

        self.view.backgroundColor = .white

        let animationLabel = PMAnimationLabelView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:100))
        animationLabel.text = "Loading..."
        animationLabel.font = UIFont.boldSystemFont(ofSize:40)
        animationLabel.center = CGPoint(x:self.view.frame.width / 2, y:self.view.frame.height / 2)

        self.view.addSubview(animationLabel)

        animationLabel.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

