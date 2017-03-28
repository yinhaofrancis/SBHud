//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import XCPlayground
//public class WaterLayer:CALayer{
//    public override func draw(in ctx: CGContext) {
//        ctx.setFillColor(color)
//        ctx.fillPath()
//    }
//    
//    
//    override init() {
//        super.init()
//        self.masksToBounds = true
//    }
//    override init(layer: Any) {
//        super.init(layer: layer)
//        self.masksToBounds = true
//    }
//    
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    func inner(){
//        
//    }
//    
//}

public class WaterProcessIndicateView:UIView{
    var isElement:Bool = true
    var color:CGColor = UIColor.blue.cgColor
    var process:CGFloat = 0.5
    var wave:CGFloat = 0
    var link:CADisplayLink?;
    
    
    
    open class override var layerClass: Swift.AnyClass{
        return CAShapeLayer.self
    }
    public override func layoutSubviews() {
        let path = makePath()
        shape.path = path
        shape.fillColor = self.color
    }
    var shape:CAShapeLayer{
        return self.layer as! CAShapeLayer
    }
    
    func makePath()->CGPath{
        let rect = self.bounds
        let seed: CGFloat = min(rect.width - (isElement ? 1 : 8) * 2, rect.height - (isElement ? 1 : 8) * 2)
        let linewidth: CGFloat = seed / 20.0
        let localseed: CGFloat = isElement ? 1 : 8
        let pathRect = CGRect(x: localseed + linewidth / 2.0, y: localseed + linewidth / 2.0, width: seed - linewidth, height: seed - linewidth)
        let path:CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: pathRect.minX, y: pathRect.maxY))
        path.addLine(to: CGPoint(x: pathRect.maxX, y: pathRect.maxY))
        path.addLine(to: CGPoint(x: pathRect.maxX, y: function(x: pathRect.maxX + wave) + pathRect.minY + (1-process) * pathRect.height))
        var i = pathRect.maxX - 1
        while i >= pathRect.minX {
            
            let y = function(x: i + wave) + pathRect.minY + (1 - process) * pathRect.height
            path.addLine(to: CGPoint(x: i, y: y))
            i -= 1
        }
        path.closeSubpath()
        return path
    }
    func function(x:CGFloat)->CGFloat{
        return 20 * sin(CGFloat.pi / 200 * x) + 20
    }
    
    public override func didMoveToWindow() {
        link = CADisplayLink(target: self, selector: #selector(flush))
        link?.add(to: RunLoop.main, forMode: .commonModes)
    }
    func flush() {
        wave += 10
        let path = makePath()
        shape.path = path
        shape.fillColor = self.color
    }
}
PlaygroundPage.current.liveView = WaterProcessIndicateView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))

