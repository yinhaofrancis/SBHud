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
func + (a:CATransform3D,b:CATransform3D)->CATransform3D{
    return CATransform3DConcat(a, b)
}
public class WaiterAnimatonDisplayView:UIView{
    var items:[CALayer] = []
    public override func didMoveToWindow() {
        loadContent()
    }
    public override func layoutSubviews() {
        
        loadAnimation(radius: min(self.bounds.midX, self.bounds.midY))
    }
    
    func loadAnimation(radius:CGFloat = 30){
        let ass = makeAnimations(during: 2,radius: radius)
        (0..<count).forEach { (i) in
            items[i].add(ass[i], forKey: nil)
        }
    }
    public static var color:UIColor = UIColor.red
    public var image:UIImage = {
        UIGraphicsBeginImageContextWithOptions(CGSize(width:10,height:10), false, UIScreen.main.scale)
        WaiterAnimatonDisplayView.color.setFill()
        UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).fill()
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }()
    let count = 8
    func loadContent() {
        items = (0..<count).map { (i) -> CALayer in
            return CALayer()
        }
        items.forEach { (item) in
            item.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
            item.contents = image.cgImage
            self.layer.addSublayer(item)
        }
    }
    func makeAnimations(during:CFTimeInterval,radius:CGFloat = 30)->[CAAnimation]{
        return (0..<count).map { (i) -> CAAnimation in
            let a = CAKeyframeAnimation(keyPath: "position")
            let p = UIBezierPath()
            p.addArc(withCenter: CGPoint(x:self.bounds.midX,y:self.bounds.midY), radius: radius, startAngle: 0 + CGFloat(i) * CGFloat(M_PI * 2 / Double(self.count)), endAngle: CGFloat(M_PI * 2) + CGFloat(i) * CGFloat(M_PI * 2 / Double(self.count)), clockwise: true)
            a.path = p.cgPath
            a.duration = during
            a.repeatCount = Float.infinity
            return a
        }
    }
}
