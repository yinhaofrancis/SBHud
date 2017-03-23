//
//  Render.swift
//  hud
//
//  Created by hao yin on 23/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

public protocol IContentRender{
    func render(container:UIView)
    func showAnimation(hub:UIView) -> CAAnimation
    func hiddenAnimation(hub:UIView) -> CAAnimation
    func during()->TimeInterval
}
//public class WaiterContentRender:IContentRender{
//    public func hiddenAnimation(hub: UIView) -> CAAnimation {
//        
//    }
//
//    public func showAnimation(hub: UIView) -> CAAnimation {
//        
//    }
//
//    public func render(container: UIView) {
//        
//    }
//    public func during() -> TimeInterval {
//        return 3
//    }
//    
//}
func + (a:CATransform3D,b:CATransform3D)->CATransform3D{
    return CATransform3DConcat(a, b)
}
@IBDesignable
public class WaiterAnimatonDisplayView:UIView{
    public var itemColor:UIColor = UIColor.red
    let aniamtionLayer:CAReplicatorLayer = CAReplicatorLayer()
    let itemLayer:CALayer = CALayer()
    @IBInspectable var m:Double = 10
    public override func didMoveToWindow() {
        
        
    }
    var item:UIImage = {
        UIGraphicsBeginImageContextWithOptions(CGSize(width:10,height:10), false, UIScreen.main.scale)
        let p = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10))
        UIColor.red.setFill()
        p.fill()
        return UIGraphicsGetImageFromCurrentImageContext()!
    }()
    public override func layoutSubviews() {
        aniamtionLayer.instanceCount = 5
        aniamtionLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI_4 / 4 + m * 0.1), 0, 0, 1)
        aniamtionLayer.instanceColor = UIColor.red.cgColor
        aniamtionLayer.instanceDelay = m * 0.1
       
        self.itemLayer.contents = item.cgImage
        
        aniamtionLayer.addSublayer(itemLayer)
        aniamtionLayer.frame = self.bounds
        self.itemLayer.frame = CGRect(x: self.bounds.minX + 10, y:self.bounds.midY, width: 10, height: 10)
        self.layer.addSublayer(aniamtionLayer)
    }
}
