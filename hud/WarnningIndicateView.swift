//
//  WarnningView.swift
//  hud
//
//  Created by hao yin on 27/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

public class WarnningIndicateView:baseIndicateView{
    public override func didMoveToWindow() {
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = self.color.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        let a = CABasicAnimation(keyPath: "shadowRadius")
        a.fromValue = 0
        a.toValue = 3
        a.duration = 3
        a.repeatCount = Float.infinity
        a.autoreverses = true
        self.layer.add(a, forKey: nil)
    }
    public override var color:UIColor{
        didSet{
            self.setNeedsDisplay()
        }
    }
    public override func draw(_ rect: CGRect) {
        drawWarnning(rect: rect, color: self.color, isElement: self.isElement)
    }
    func drawWarnning( rect: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200), color: UIColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000),isElement: Bool = false) {
        
        //// Variable Declarations
        let seed: CGFloat = min(rect.width - (isElement ? 1 : 8) * 2, rect.height - (isElement ? 1 : 8) * 2)
        let linewidth: CGFloat = seed / 20.0
        let localseed: CGFloat = isElement ? 1 : 8
        let pathRect = CGRect(x: localseed + linewidth / 2.0, y: localseed + linewidth / 2.0, width: seed - linewidth, height: seed - linewidth)
        
        //// Frames
        let frame = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height)
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: pathRect)
        color.setStroke()
        ovalPath.lineWidth = linewidth
        ovalPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: frame.minX + 0.54200 * frame.width, y: frame.minY + 0.33850 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.54170 * frame.width, y: frame.minY + 0.34335 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.54200 * frame.width, y: frame.minY + 0.34014 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.54190 * frame.width, y: frame.minY + 0.34176 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.52450 * frame.width, y: frame.minY + 0.61850 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.53938 * frame.width, y: frame.minY + 0.38049 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.52450 * frame.width, y: frame.minY + 0.61850 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.50350 * frame.width, y: frame.minY + 0.63950 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.52450 * frame.width, y: frame.minY + 0.63010 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.51510 * frame.width, y: frame.minY + 0.63950 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.48250 * frame.width, y: frame.minY + 0.61850 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.49190 * frame.width, y: frame.minY + 0.63950 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.48250 * frame.width, y: frame.minY + 0.63010 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.46530 * frame.width, y: frame.minY + 0.34335 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.48250 * frame.width, y: frame.minY + 0.61850 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.46762 * frame.width, y: frame.minY + 0.38049 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.46500 * frame.width, y: frame.minY + 0.33850 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.46510 * frame.width, y: frame.minY + 0.34176 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.46500 * frame.width, y: frame.minY + 0.34014 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.47692 * frame.width, y: frame.minY + 0.31065 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.46500 * frame.width, y: frame.minY + 0.32755 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.46957 * frame.width, y: frame.minY + 0.31766 * frame.height))
        bezier2Path.addLine(to: CGPoint(x: frame.minX + 0.47736 * frame.width, y: frame.minY + 0.31024 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.50350 * frame.width, y: frame.minY + 0.30000 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.48422 * frame.width, y: frame.minY + 0.30388 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.49341 * frame.width, y: frame.minY + 0.30000 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.54200 * frame.width, y: frame.minY + 0.33850 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.52476 * frame.width, y: frame.minY + 0.30000 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.54200 * frame.width, y: frame.minY + 0.31724 * frame.height))
        bezier2Path.close()
        bezier2Path.move(to: CGPoint(x: frame.minX + 0.54050 * frame.width, y: frame.minY + 0.73475 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.50025 * frame.width, y: frame.minY + 0.77500 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.54050 * frame.width, y: frame.minY + 0.75698 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.52248 * frame.width, y: frame.minY + 0.77500 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.46000 * frame.width, y: frame.minY + 0.73475 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.47802 * frame.width, y: frame.minY + 0.77500 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.46000 * frame.width, y: frame.minY + 0.75698 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.50025 * frame.width, y: frame.minY + 0.69450 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.46000 * frame.width, y: frame.minY + 0.71252 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.47802 * frame.width, y: frame.minY + 0.69450 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.54050 * frame.width, y: frame.minY + 0.73475 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.52248 * frame.width, y: frame.minY + 0.69450 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.54050 * frame.width, y: frame.minY + 0.71252 * frame.height))
        bezier2Path.close()
        color.setFill()
        bezier2Path.fill()
    }
}
