//
//  CircleIndicateView.swift
//  hud
//
//  Created by hao yin on 2017/3/25.
//  Copyright © 2017年 hao yin. All rights reserved.
//

import UIKit
public protocol IndicateProperty{
    var color:UIColor{get set}
    var isElement:Bool {get set}
}
public class CircleIndicateView:baseIndicateView{
    open class override var layerClass: Swift.AnyClass {
        return CAShapeLayer.self
    }
    var shapeLayer:CAShapeLayer{
        return self.layer as! CAShapeLayer
    }
    var link:CADisplayLink?
    override public func didMoveToWindow() {
        
    }
    public override func start(contain: HudPlain) {
        let a = CADisplayLink(target: self, selector: #selector(flush))
        a.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        link = a
        self.shapeLayer.lineCap = "round"
    }
    public override func stop(contain: HudPlain) {
        link?.invalidate()
        self.shapeLayer.removeAllAnimations()
        i = 0;j = 0;y = 0.0
    }
    override public func layoutSubviews() {
        self.shapeLayer.lineWidth = min(self.bounds.width, self.bounds.height) / 20
        if self.shapeLayer.lineWidth < 1{
            self.shapeLayer.lineWidth = 1
        }
    }
    var i:Double = 0
    var y:Double = 0
    var j:Double = 0
    public override var color:UIColor{
        didSet{
            self.shapeLayer.strokeColor = self.color.cgColor
        }
    }
    func flush(){
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = self.color.cgColor
        let p = UIBezierPath(arcCenter: CGPoint(x:self.bounds.midX,y:self.bounds.midY), radius: min(self.bounds.midX,self.bounds.midY) - self.shapeLayer.lineWidth - (isElement ? 0 : 8), startAngle: CGFloat(M_PI * j * 0.02 + y * 0.1 * M_PI), endAngle: CGFloat(M_PI * i * 0.02 + y * 0.1 * M_PI), clockwise: true)
        self.shapeLayer.path = p.cgPath
        
        if sin(y/2) > 0{
            i += 1
        }else{
            if (j + 1 < i){
                j += 1
            }
        }
        y += 0.1
    }
}
