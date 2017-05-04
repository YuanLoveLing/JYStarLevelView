//
//  JYStarLevelView.swift
//  JYStarLevelView
//
//  Created by 靳志远 on 2017/5/4.
//  Copyright © 2017年 靳志远. All rights reserved.
//

import UIKit

enum JYStarShowStyle: String {
    /// 整颗星为单位
    case WholeStar = "JYStarShowStyle_whole"
    /// 半颗星为单位
    case HalfStar = "JYStarShowStyle_half"
}

class JYStarLevelView: UIView {
    /// 星星个数，默认5个
    fileprivate var starNum: Int = 5
    fileprivate var starShowStyle: JYStarShowStyle = .HalfStar
    
    fileprivate var foregroundStarView: UIView?
    fileprivate var backgroundStarView: UIView?
    
    /// 记录当前星级
    fileprivate var currentStarLevel: CGFloat = 0.0
    
    /// 回调：选中星级后
    fileprivate var closureSelectComplete: ((_ currentStarLevel: CGFloat) -> ())?
    
    /**
     starsNum: 星星个数，默认五颗星
     starShowStyle: 默认半颗星为单位
     closureSelectComplete: 选择完毕后回调
     */
    init(starsNum: Int? = nil, starShowStyle: JYStarShowStyle? = .HalfStar, closureSelectComplete: ((_ currentStarLevel: CGFloat) -> ())?) {
        super.init(frame: CGRect.zero)
        
        if let starsNum = starsNum {
            self.starNum = starsNum
        }
        
        if let starShowStyle = starShowStyle {
            self.starShowStyle = starShowStyle
        }
        
        backgroundStarView = createStarView(starsNum: self.starNum, image: #imageLiteral(resourceName: "Star_normal"))
        addSubview(backgroundStarView!)
        foregroundStarView = createStarView(starsNum: self.starNum, image: #imageLiteral(resourceName: "Star_selected"))
        addSubview(foregroundStarView!)
        
        // 添加点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userTap))
        self.addGestureRecognizer(tapGesture)
        
        self.closureSelectComplete = closureSelectComplete
    }
    
    // 用户点击触发事件
    @objc fileprivate func userTap(tapGesture: UITapGestureRecognizer) {
        let point = tapGesture.location(in: self)
        let starWidth = bounds.width / CGFloat(starNum)
        
        let value = Float(point.x / starWidth)
        let ceilValue = ceilf(Float(point.x / starWidth))
        let roudValue = roundf(Float(point.x / starWidth))
        
        // 记录选中的星级
        currentStarLevel = CGFloat(roudValue > value ? ceilValue : ceilValue - 0.5)
        if starShowStyle == .WholeStar {
            currentStarLevel = CGFloat(ceilValue)
        }
        
        layoutSubviews()
        
        // 回调
        if closureSelectComplete != nil {
            closureSelectComplete!(currentStarLevel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createStarView(starsNum: Int, image: UIImage) -> (UIView) {
        let starView = UIView()
        starView.clipsToBounds = true
        
        for i in 0..<starsNum {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.tag = i
            starView.addSubview(imageView)
        }
        return starView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let starWidth = bounds.width / CGFloat(starNum)
        
        if let foregroundStarView = foregroundStarView {
            foregroundStarView.frame = CGRect(x: 0, y: 0, width: starWidth * currentStarLevel, height: bounds.height)
            for subView in foregroundStarView.subviews {
                let w: CGFloat = bounds.width / CGFloat(starNum)
                let h: CGFloat = bounds.height
                let x: CGFloat = w * CGFloat(subView.tag)
                let y: CGFloat = 0.0
                subView.frame = CGRect(x: x, y: y, width: w, height: h)
            }
        }
        
        if let backgroundStarView = backgroundStarView {
            backgroundStarView.frame = bounds
            for subView in backgroundStarView.subviews {
                let w: CGFloat = bounds.width / CGFloat(starNum)
                let h: CGFloat = bounds.height
                let x: CGFloat = w * CGFloat(subView.tag)
                let y: CGFloat = 0.0
                subView.frame = CGRect(x: x, y: y, width: w, height: h)
            }
        }
    }
}










