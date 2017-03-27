//
//  CircleProcessIndicateView.swift
//  hud
//
//  Created by hao yin on 27/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

public class CircleProcessIndicateView:baseIndicateView{
    public override func didMoveToWindow() {
        self.layer.addSublayer(shape)
        shape.lineJoin = "round"
        shape.lineCap = "round"
    }
    
    let shape:CAShapeLayer =  CAShapeLayer()
    public override func layoutSubviews() {
        
        let w = min(self.bounds.width, self.bounds.height)
        let frame = CGRect(x: 0, y: 0, width: w, height: w)
        shape.frame = frame
        shape.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let r = self.drawCircleProcess(rect: frame, isElement: false)
        shape.path = r
        shape.strokeColor = UIColor.red.cgColor
        shape.fillColor = UIColor.clear.cgColor
    }
    public override func time(time: CGFloat) {
        let r = self.drawCircleProcess(rect: frame, isElement: false,number: time)
        let a = CABasicAnimation(keyPath: "path")
        a.fromValue = self.shape.path
        a.toValue = r
        a.duration = 0.1
        self.shape.add(a, forKey: nil)
        self.shape.path = r
    }
    func drawCircleProcess(rect: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200), isElement: Bool = true, number: CGFloat = 0)->CGPath {
        
        //// Variable Declarations
        let seed: CGFloat = min(rect.width - (isElement ? 1 : 8) * 2, rect.height - (isElement ? 1 : 8) * 2)
        let linewidth: CGFloat = seed / 20.0
        let localseed: CGFloat = isElement ? 1 : 8
        let pathRect = CGRect(x: localseed + linewidth / 2.0, y: localseed + linewidth / 2.0, width: seed - linewidth, height: seed - linewidth)
        
        //// Oval Drawing
        let ovalRect = pathRect
        let ovalPath = UIBezierPath()
        ovalPath.addArc(withCenter: CGPoint(x: ovalRect.midX, y: ovalRect.midY), radius: ovalRect.width / 2, startAngle: -CGFloat.pi / 2, endAngle: -CGFloat.pi * (-2 * number + 0.5), clockwise: true)
        // -2x + 0.5
        return ovalPath.cgPath
    }
}
