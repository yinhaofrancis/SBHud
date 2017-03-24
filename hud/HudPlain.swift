//
//  HudPlainView.swift
//  hud
//
//  Created by hao yin on 24/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit
// MARK:- plain
public protocol hock{
    func start(contain:HudPlain)
    func stop(contain:HudPlain)
    func time(time:TimeInterval)
}
extension UIView:hock{
    public func stop(contain: HudPlain) {}
    public func start(contain: HudPlain) {}
    public func time(time: TimeInterval) {}
}
public class HudPlain:UIViewController{
    public var content:(HudPlain)->UIView = {(self) in
        return UIView()
    }
    
    public var Constrait:(HudPlain,UIView)->(forself:[NSLayoutConstraint],forcontent:[NSLayoutConstraint]) = { (self,content) in
        let x = NSLayoutConstraint(item: self.view, attribute: .centerX, relatedBy: .equal, toItem: content, attribute: .centerX, multiplier: 1, constant: 0)
        let y = NSLayoutConstraint(item: self.view, attribute: .centerY, relatedBy: .equal, toItem: content, attribute: .centerY, multiplier: 1, constant: 0)
        let w = NSLayoutConstraint(item: content, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 64)
        let h = NSLayoutConstraint(item: content, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 64)
        return(forself:[x,y],forcontent:[w,h])
    }
    
    public var Style:(HudPlain,UIView)->Void = {(_,content) in
        content.backgroundColor = UIColor.red
    }
    
    public var animationShow:(HudPlain,UIView,((Bool) -> Void)?)->Void = {(_,content,complete) in
        let from = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let to = CGAffineTransform(scaleX: 1, y: 1)
        content.transform = from
        content.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options:.curveEaseOut, animations: {
            content.transform = to
            content.alpha = 1
        }, completion: nil)
    }
    public var animationClose:(HudPlain,UIView,((Bool) -> Void)?)->Void = {(_,content:UIView,complete) in
        let from = CGAffineTransform(scaleX: 0.1, y: 0.1)
        content.alpha = 1
        let to = CGAffineTransform(scaleX: 1, y: 1)
        content.transform = to
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            content.transform = from
            content.alpha = 0
        }, completion: complete)
    }
    public var useDefaultAnimation:Bool = false
    private var contentView:UIView?
    func layerOut(){
        let v = self.content(self)
        contentView = v
        self.view.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        let c = self.Constrait(self,v)
        self.view.addConstraints(c.forself)
        self.contentView?.addConstraints(c.forcontent)
        self.Style(self,v)
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.layerOut()
    }
    public func showHud(from:UIViewController,delay:TimeInterval?,modal:Bool = true,completion: (() -> Void)? = nil){
        guard (self.view.window == nil) else {
            return
        }
        if let d = delay{
            Timer.scheduledTimer(timeInterval: d, target: self, selector: #selector(innnerClose), userInfo: nil, repeats: false)
            self.contentView?.time(time: d)
        }
        self.modalPresentationStyle = modal ? .overFullScreen :.fullScreen
        
        from.present(self, animated: useDefaultAnimation, completion: completion)
        self.contentView?.start(contain: self)
    }
    func innnerClose() {
        closeHud()
    }
    public func closeHud(completion: (() -> Void)? = nil){
        self.dismiss(animated: useDefaultAnimation, completion: completion)
        self.contentView?.stop(contain: self)
    }
    override public func viewDidAppear(_ animated: Bool) {
        self.animationShow(self,self.contentView!,nil)
    }
    override public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.animationClose(self, self.contentView!) { (i) in
            super.dismiss(animated: flag, completion: completion)
        }
    }
    init() {super.init(nibName: nil, bundle: nil)}
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK:- Maker
public class HudPlainMaker:NSObject{
    public func makeCircle(color:UIColor)->HudPlain {
        let hud = HudPlain()
        
        return hud
    }
}
