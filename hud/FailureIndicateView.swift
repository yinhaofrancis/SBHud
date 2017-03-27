//
//  FailureView.swift
//  hud
//
//  Created by hao yin on 27/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

public class FailureIndicateView:baseIndicateView{
    public override func didMoveToWindow() {
        
        self.layer.addSublayer(shape)
        shape.lineJoin = "round"
        shape.lineCap = "round"
    }
    public override func start(contain: HudPlain) {
        let a = CABasicAnimation(keyPath: "strokeEnd")
        a.fromValue = 0
        a.toValue = 1
        a.duration = 1
        self.shape.add(a, forKey: nil)
    }
    let shape:CAShapeLayer =  CAShapeLayer()
    public override func layoutSubviews() {
        
        let w = min(self.bounds.width, self.bounds.height)
        let frame = CGRect(x: 0, y: 0, width: w, height: w)
        shape.frame = frame
        shape.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let r = self.drawFailure(rect: frame, isElement: self.isElement)
        shape.path = r.path
        shape.lineWidth = r.lineWidth
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = self.color.cgColor
    }
    func drawFailure(rect: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200), isElement: Bool = false) ->(lineWidth:CGFloat,path:CGPath){
        
        let seed: CGFloat = min(rect.width - (isElement ? 1 : 8) * 2, rect.height - (isElement ? 1 : 8) * 2)
        let linewidth: CGFloat = seed / 20.0
        let localseed: CGFloat = isElement ? 1 : 8
        let pathRect = CGRect(x: localseed + linewidth / 2.0, y: localseed + linewidth / 2.0, width: seed - linewidth, height: seed - linewidth)
        
        
        let frame = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height)
        
        
        
        let ovalPath = UIBezierPath(ovalIn: pathRect)
        
        
        
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: frame.minX + 0.27774 * frame.width, y: frame.minY + 0.27857 * frame.height))
        bezier3Path.addCurve(to: CGPoint(x: frame.minX + 0.72322 * frame.width, y: frame.minY + 0.72405 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.72325 * frame.width, y: frame.minY + 0.72408 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.61185 * frame.width, y: frame.minY + 0.61268 * frame.height))
        bezier3Path.move(to: CGPoint(x: frame.minX + 0.72500 * frame.width, y: frame.minY + 0.27678 * frame.height))
        bezier3Path.addLine(to: CGPoint(x: frame.minX + 0.28000 * frame.width, y: frame.minY + 0.72178 * frame.height))
        
        
        
        
        let conbine = UIBezierPath()
        conbine.append(ovalPath)
        conbine.append(bezier3Path)
        return(linewidth,conbine.cgPath)
    }
}
