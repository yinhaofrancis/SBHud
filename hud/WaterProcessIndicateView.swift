//
//  WaterProcessIndicateView.swift
//  hud
//
//  Created by hao yin on 28/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

public class WaterLayer:CALayer{
    var isElement:Bool = true
    var color:CGColor = UIColor.blue.cgColor
    var process:CGFloat = 0.5
    var wave:CGFloat = 0
    func makePath()->CGPath{
        let rect = self.bounds
        let seed: CGFloat = min(rect.width - (isElement ? 1 : 8) * 2, rect.height - (isElement ? 1 : 8) * 2)
        let linewidth: CGFloat = seed / 20.0
        let localseed: CGFloat = isElement ? 1 : 8
        let pathRect = CGRect(x: localseed + linewidth / 2.0, y: localseed + linewidth / 2.0, width: seed - linewidth, height: seed - linewidth)
        let path:CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: pathRect.minX, y: pathRect.maxY))
        path.addLine(to: CGPoint(x: pathRect.maxX, y: pathRect.maxY))
        path.addLine(to: CGPoint(x: pathRect.maxX, y: function(pathRect.maxX + wave) + pathRect.minY + (1 - process) * pathRect.height))
        var i = pathRect.maxX - 1
        while i >= pathRect.minX {
            
            let y = function(i + wave) + pathRect.minY + (1 - process) * pathRect.height
            path.addLine(to: CGPoint(x: i, y: y))
            i -= 1
        }
        path.closeSubpath()
        return path
    }
 
    var function:(_ x:CGFloat)->CGFloat = { x in
         return 20 * sin(CGFloat.pi / 200 * x) + 20
    }
    var period:CGFloat = 400
    public override func draw(in ctx: CGContext) {
        let path = makePath()
        ctx.setFillColor(self.color)
        ctx.addPath(path)
        ctx.fillPath()
    }
    override init() {
        super.init()
    }
    override init(layer: Any) {
        let l = layer as AnyObject
        super.init(layer: layer)
        self.isElement = l.isElement
        self.color = l.color
        self.process = l.process
        self.wave = l.wave
    
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func start(){
   
        
        let a = CABasicAnimation(keyPath: "wave")
        a.fromValue = 0
        a.byValue = self.period
        a.duration = 1
        a.repeatCount = Float.infinity
        self.add(a, forKey: nil)
        
    }
    open override class func needsDisplay(forKey key: String) -> Bool{
        if key == "wave"{
            return true
        }else{
            return super.needsDisplay(forKey: key)
        }
    }
}


public class WaterProcessIndicateView:UIView{
    open class override var layerClass:Swift.AnyClass{ return CAGradientLayer.self}
    var water:WaterLayer = WaterLayer()
    override public func didMoveToWindow() {
        self.layer.mask = water
        water.start()
        self.layer.contentsScale = UIScreen.main.scale
    }
    func config(){
        self.gradientLayer.startPoint = CGPoint.zero
        self.gradientLayer.endPoint = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
        
    }
    public var gradientLayer:CAGradientLayer{
        return self.layer as! CAGradientLayer
    }
}
