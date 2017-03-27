//
//  SuccessIndicateView.swift
//  hud
//
//  Created by hao yin on 27/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

public class SuccessIndicateView:baseIndicateView{
    public override func didMoveToWindow() {
        self.layer.addSublayer(shape)
        shape.lineJoin = "round"
        shape.lineCap = "round"
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
        let r = self.drawSuccess(rect: frame, isElement: self.isElement)
        shape.path = r.0
        shape.lineWidth = r.1
        shape.strokeColor = self.color.cgColor
        shape.fillColor = UIColor.clear.cgColor
    }
    func drawSuccess(rect: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200), isElement: Bool = true)->(CGPath,CGFloat) {
        
        //// Variable Declarations
        let seed: CGFloat = min(rect.width - (isElement ? 1 : 8) * 2, rect.height - (isElement ? 1 : 8) * 2)
        let linewidth: CGFloat = seed / 20.0
        let localseed: CGFloat = isElement ? 1 : 8
        let pathRect = CGRect(x: localseed + linewidth / 2.0, y: localseed + linewidth / 2.0, width: seed - linewidth, height: seed - linewidth)
        
        let frame = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height)
        
        let ovalPath = UIBezierPath(ovalIn: pathRect)
        
        let rectanglePath = UIBezierPath()
        rectanglePath.move(to: CGPoint(x: frame.minX + 0.13500 * frame.width, y: frame.minY + 0.49000 * frame.height))
        rectanglePath.addLine(to: CGPoint(x: frame.minX + 0.48591 * frame.width, y: frame.minY + 0.75562 * frame.height))
        rectanglePath.addLine(to: CGPoint(x: frame.minX + 0.84500 * frame.width, y: frame.minY + 0.29000 * frame.height))
        
        let conbine = UIBezierPath()
        conbine.append(ovalPath)
        conbine.append(rectanglePath)
        return (conbine.cgPath,linewidth)
    }
}
