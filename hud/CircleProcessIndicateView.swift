//
//  CircleProcessIndicateView.swift
//  hud
//
//  Created by hao yin on 27/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

public class CircleProcessLayer:CALayer{
    public override func draw(in ctx: CGContext) {
        UIGraphicsPushContext(ctx)
        drawCircleProcess(ctx: ctx, color: color, rect: self.bounds, isElement: isElememt, number: process)
        UIGraphicsPopContext()
    }
    public var color:CGColor = UIColor.blue.cgColor
    public var isElememt = true
    public var process:CGFloat = 0
    func drawCircleProcess(ctx:CGContext,color: CGColor, rect: CGRect, isElement: Bool ,number: CGFloat, offset: CGFloat = 2) {
        
        //// Variable Declarations
        let seed: CGFloat = min(rect.width - (isElement ? 1 : 8) * 2, rect.height - (isElement ? 1 : 8) * 2)
        let linewidth: CGFloat = seed / 20.0
        let localseed: CGFloat = isElement ? 1 : 8
        let pathRect = CGRect(x: localseed + linewidth / 2.0, y: localseed + linewidth / 2.0, width: seed - linewidth, height: seed - linewidth)
        let innerRect = CGRect(x: pathRect.minX + offset, y: pathRect.minY + offset, width: pathRect.width - 2 * offset, height: pathRect.height - 2 * offset)
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: pathRect)
        ctx.setStrokeColor(color)
        ovalPath.lineWidth = 1
        ovalPath.stroke()
        
        
        //// Oval 2 Drawing
        let oval2Rect = innerRect
        let oval2Path = UIBezierPath()
        oval2Path.addArc(withCenter: CGPoint(x: oval2Rect.midX, y: oval2Rect.midY), radius: oval2Rect.width / 2, startAngle: -CGFloat.pi/2, endAngle: (-2 * number + 0.5) * -CGFloat.pi, clockwise: true)
        oval2Path.addLine(to: CGPoint(x: oval2Rect.midX, y: oval2Rect.midY))
        oval2Path.close()
        
        ctx.setFillColor(color)
        oval2Path.fill()
    }
    override init(layer: Any) {
        super.init(layer: layer)
        self.color = (layer as! CircleProcessLayer).color
        self.isElememt = (layer as! CircleProcessLayer).isElememt
        self.process = (layer as! CircleProcessLayer).process
    }
    override init() {
        super.init()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override class func needsDisplay(forKey key: String) -> Bool{
        if key == "process"{
            return true
        }else if key == "color"{
            return true
        }else{
            return super.needsDisplay(forKey: key)
        }
    }
    func processAction(from:CGFloat,to:CGFloat){
        let a = CABasicAnimation(keyPath: "process")
        a.fromValue = from
        a.toValue = to
        a.duration = 0.5
        self.add(a, forKey: nil)
    }
}
public class CircleProcessIndicateView:baseIndicateView{
    open class override var layerClass: Swift.AnyClass { return CircleProcessLayer.self }
    public override func didMoveToWindow() {
        
        self.layer.contentsScale = UIScreen.main.scale
        self.backgroundColor = UIColor.white
    }
    public var processLayer:CircleProcessLayer{
        return self.layer as! CircleProcessLayer
    }
    public override var color: UIColor{
        didSet{
            self.processLayer.color = color.cgColor
        }
    }
    public override var isElement: Bool{
        didSet{
            self.processLayer.isElememt = isElement
        }
    }
    public var process:CGFloat = 0{
        didSet{
            self.processLayer.process = process
        }
    }
    public override func time(time: CGFloat) {
        self.processLayer.processAction(from: process, to: time)
        process = time
    }
}
