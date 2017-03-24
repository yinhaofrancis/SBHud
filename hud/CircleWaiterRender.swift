//
//  CircleWaiterRender.swift
//  hud
//
//  Created by hao yin on 24/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

public class WaiterAnimatonDisplayView:UIView,ViewAnimation{
    public func stop() {
        let a = makeCloseAnimation(during: 0.3, radius: min(self.bounds.midX, self.bounds.midY))
        (0..<count).forEach { (i) in
            items[i].removeAnimation(forKey: runAnimaitionKey)
            items[i].add(a[i], forKey: nil)
            items[i].opacity = 0
        }
    }
    let runAnimaitionKey = "runing"
    
    var items:[CALayer] = []
    var ob:NSObject?
    var ol:NSObjectProtocol?
    public override func didMoveToWindow() {
        loadContent()
        let ob = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillEnterForeground, object: nil, queue: OperationQueue.main) { [unowned self](i) in
            self.layoutSubviews()
        }
        self.ob = ob as? NSObject        
    }
    public override func layoutSubviews() {
        start()
    }
    public func start() {
        loadAnimation(radius: min(self.bounds.midX, self.bounds.midY))
    }
    func loadAnimation(radius:CGFloat = 30){
        let ass = makeAnimations(during: 2,radius: radius)
        let ans = makeShowAnimation(during: 0.3,radius: radius)
        (0..<count).forEach { (i) in
            items[i].add(ass[i], forKey: runAnimaitionKey)
            items[i].add(ans[i], forKey: nil)
            items[i].opacity = 1
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
        guard items.count == 0 else{
            return
        }
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
    func makeShowAnimation(during:CFTimeInterval,radius:CGFloat=30)->[CAAnimation]{
        return (0..<count).map({ (i) -> CAAnimation in
            let a = CAKeyframeAnimation(keyPath: "position")
            let b = UIBezierPath()
            b.move(to: CGPoint(x: self.bounds.midX, y: self.bounds.midY))
            b.addLine(to: CGPoint(x: self.bounds.midX - radius, y: self.bounds.midY).applying(CGAffineTransform(rotationAngle:  CGFloat(Double(i) / Double(count) * M_PI * 2.0)) + CGAffineTransform(translationX: self.bounds.midX, y: self.bounds.midY)))
            
            a.duration = during
            a.path = b.cgPath
            a.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            return a
        })
    }
    func makeCloseAnimation(during:CFTimeInterval,radius:CGFloat)->[CAAnimation]{
        return (0..<count).map({ (i) -> CAAnimation in
            let a = CAKeyframeAnimation(keyPath: "position")
            let b = UIBezierPath()
            b.move(to: CGPoint(x: self.bounds.midX - radius, y: self.bounds.midY).applying(CGAffineTransform(rotationAngle:  CGFloat(Double(i) / Double(count) * M_PI * 2.0)) + CGAffineTransform(translationX: self.bounds.midX, y: self.bounds.midY)))
            b.addLine(to: CGPoint(x: self.bounds.midX, y: self.bounds.midY))
            a.path = b.cgPath
            let af = CABasicAnimation(keyPath: "opacity")
            af.toValue = -1
            af.fromValue = 1
            
            let ag = CAAnimationGroup()
            ag.animations = [a,af]
            ag.duration = during
            ag.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            return ag
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self.ob!)
    }
}

class CircleWaiterRender:IContentRender{
    func render(container:UIView){
        let view = WaiterAnimatonDisplayView(frame: CGRect.zero)
        container.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let v = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: ["view":view])
        let h = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: ["view":view])
        container.addConstraints(v + h)
        
    }
    func showAnimation(hub:UIView){
        hub.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration:during(), delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
            hub.transform = CGAffineTransform(scaleX: 1, y: 1)
            hub.alpha = 1
        }, completion: nil)
    }
    func hiddenAnimation(hub:UIView,end:@escaping (Bool)->Void){
        hub.transform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: during(), delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
            hub.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            hub.alpha = 0
        }, completion: end)
    }
    func during()->TimeInterval{
        return 0.5
    }
}
