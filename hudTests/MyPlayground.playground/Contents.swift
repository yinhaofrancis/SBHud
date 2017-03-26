//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

public class CircleIndicateView:UIView{
    open class override var layerClass: Swift.AnyClass {
        return CAShapeLayer.self
    }
    var shapeLayer:CAShapeLayer{
        return self.layer as! CAShapeLayer
    }
    override public func didMoveToWindow() {
        
        let a = CADisplayLink(target: self, selector: #selector(flush))
        a.add(to: RunLoop.main, forMode: .commonModes)
        let ak = CAKeyframeAnimation(keyPath: "transform")
        ak.values = [CATransform3DIdentity,CATransform3DMakeRotation(CGFloat(M_PI * 2 / 3), 0, 0, 1),CATransform3DMakeRotation(CGFloat(M_PI * 4 / 3), 0, 0, 1),CATransform3DIdentity]
        ak.keyTimes=[0,0.33333333,0.66666666,1]
        ak.duration = 5
        ak.repeatCount = Float.infinity
        self.layer.add(ak, forKey: nil)
        self.shapeLayer.lineCap = "round"
        
        
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
    public var color:UIColor = UIColor.red{
        didSet{
            self.shapeLayer.strokeColor = self.color.cgColor
        }
    }
    func flush(){
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = UIColor.red.cgColor
        let p = UIBezierPath(arcCenter: CGPoint(x:self.bounds.midX,y:self.bounds.midY), radius: min(self.bounds.midX,self.bounds.midY) - self.shapeLayer.lineWidth, startAngle: CGFloat(M_PI * j * 0.02), endAngle: CGFloat(M_PI * i * 0.02), clockwise: true)
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


PlaygroundPage.current.liveView = CircleIndicateView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
