//
//  ViewController.swift
//  JYStarLevelView
//
//  Created by 靳志远 on 2017/5/4.
//  Copyright © 2017年 靳志远. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var starView: JYStarLevelView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starView = JYStarLevelView(starsNum: 5, starShowStyle: .WholeStar, closureSelectComplete: { (index) in
            print(index)
        })
        starView?.backgroundColor = UIColor.blue
        
        view.addSubview(starView!)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let x: CGFloat = 30
        let y: CGFloat = 30
        let w: CGFloat = view.bounds.width - 2 * x
        let h: CGFloat = 100
        starView?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
    
    
}

