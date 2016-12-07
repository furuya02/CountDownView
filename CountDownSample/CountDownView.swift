//
//  CountDownView.swift
//  CountDownSample
//
//  Created by hirauchi.shinichi on 2016/12/07.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

import UIKit

@objc protocol CountDownDelegate {
    func didCount(count:Int)
    func didFinish()
}

class CountDownView: UIView, CAAnimationDelegate {

    weak var delegate: CountDownDelegate?

    var shapeLayer = CAShapeLayer()
    var label = UILabel()

    var max = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lineWidth:CGFloat = 10.0
        let lineColor = UIColor.black
        
        self.shapeLayer.isHidden = true
        self.label.isHidden = true
        shapeLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        
        let center = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        let radius = self.bounds.size.width / 2.0 - lineWidth / 2
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = startAngle + 2.0 * CGFloat(M_PI)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        self.shapeLayer.path = path.cgPath
        self.layer.addSublayer(self.shapeLayer)
        
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        label.center = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 100)
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(max:Int){
        self.max = max
        self.shapeLayer.isHidden = false
        self.label.isHidden = false
        self.label.text = "\(max)"
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.8
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.delegate = self
        shapeLayer.add(animation, forKey: "circleAnim")
    }
    
    func stop(){
        self.shapeLayer.isHidden = true
        shapeLayer.removeAnimation(forKey: "circleAnim")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if 1 < max {
                start(max: max - 1)
                self.delegate?.didCount(count: max)
                return
            }
        }
        self.delegate?.didFinish()
        self.shapeLayer.isHidden = true
        self.label.isHidden = true
    }
}

