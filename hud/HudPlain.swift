//
//  HudPlainView.swift
//  hud
//
//  Created by hao yin on 24/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit
// MARK:- plain
public enum HudLayoutStyle{
    case center(size:CGSize)
    case bottom(height:CGFloat,VerticleOffset:CGFloat,horizonOffset:CGFloat)
    case top(height:CGFloat,VerticleOffset:CGFloat,horizonOffset:CGFloat)
    case middle(height:CGFloat,HorizonOffset:CGFloat)
    case centerAuto(max:CGSize,min:CGSize)
    case bottomAuto(max:CGFloat,min:CGFloat,VerticleOffset:CGFloat,horizonOffset:CGFloat)
    case topAuto(max:CGFloat,min:CGFloat,VerticleOffset:CGFloat,horizonOffset:CGFloat)
    case middleAuto(max:CGFloat,min:CGFloat,HorizonOffset:CGFloat)
}

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
    public var layoutStyle:HudLayoutStyle?
    public var Style:(HudPlain,UIView)->Void = {(_,content) in
        content.backgroundColor = UIColor.clear
    }
    
    public var animationShow:(HudPlain,UIView,((Bool) -> Void)?)->Void = {(self,content,complete) in
        self.view.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { 
            self.view.alpha = 1
        }, completion: complete)
    }
    public var animationClose:(HudPlain,UIView,((Bool) -> Void)?)->Void = {(self,content:UIView,complete) in
        self.view.alpha = 1
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.alpha = 0
        }, completion: complete)
    }
    public var useDefaultAnimation:Bool = false
    private var contentView:UIView?
    func layerOut(){
        let v = self.content(self)
        contentView = v
        self.view.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        if self.layoutStyle == nil{
            let c = self.Constrait(self,v)
            self.view.addConstraints(c.forself)
            self.contentView?.addConstraints(c.forcontent)
        }else{
            let c = self.makeConstraint(ls: self.layoutStyle!)
            self.view.addConstraints(c.forself)
            self.contentView?.addConstraints(c.forcontent)
        }
        self.Style(self,v)
        if let a = self.backgroudView(self,self.contentView!){
            self.view.addSubview(a)
            self.view.sendSubview(toBack: a)
            a.frame = self.view.bounds
            a.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        }else{
            if let img = self.backgroundImage(self,self.contentView!){
                (self.view as! UIImageView).image = img
            }
        }
    }
    private func makeConstraint(ls:HudLayoutStyle)->(forself:[NSLayoutConstraint],forcontent:[NSLayoutConstraint]){
        switch ls {
        case let .center(size: size):
            let x = NSLayoutConstraint(item: self.view, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0)
            let y = NSLayoutConstraint(item: self.view, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
            let w = NSLayoutConstraint(item: contentView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size.width)
            let h = NSLayoutConstraint(item: contentView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size.height)
            return(forself:[x,y],forcontent:[w,h])
        case let.bottom(height: he, VerticleOffset: v, horizonOffset: h):
            let t = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: h)
            let h = NSLayoutConstraint(item: self.contentView!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: h)
            let b = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: self.contentView!, attribute: .bottom, multiplier: 1, constant: v)
            let height = NSLayoutConstraint(item: self.contentView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: he)
            return (forself:[t,h,b],forcontent:[height])
        case let .top(height: he, VerticleOffset: v, horizonOffset: h):
            let t = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: h)
            let h = NSLayoutConstraint(item: self.contentView!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: h)
            let b = NSLayoutConstraint(item: self.contentView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: v)
            let height = NSLayoutConstraint(item: self.contentView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: he)
            return (forself:[t,h,b],forcontent:[height])
        case let .middle(height: height, HorizonOffset: h):
            let y = NSLayoutConstraint(item: self.view, attribute: .centerY, relatedBy: .equal, toItem: self.contentView!, attribute: .centerY, multiplier: 1, constant: 0)
            let l = NSLayoutConstraint(item: self.contentView!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: h)
            let t = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: h)
            
            let h = NSLayoutConstraint(item: self.contentView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: height)
            return ([y,l,t],[h])
        case let .centerAuto(max: max, min: min):
            let x = NSLayoutConstraint(item: self.view, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0)
            let y = NSLayoutConstraint(item: self.view, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
            let minw = NSLayoutConstraint(item: self.contentView!, attribute: .width, relatedBy:.greaterThanOrEqual, toItem: nil, attribute: .width, multiplier: 1, constant: min.width)
            let minh = NSLayoutConstraint(item: self.contentView!, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: min.height)
            let maxw = NSLayoutConstraint(item: self.contentView!, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .width, multiplier: 1, constant: max.width)
            let maxh = NSLayoutConstraint(item: self.contentView!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: max.height)
            self.contentView?.setContentHuggingPriority(200, for: .horizontal)
            self.contentView?.setContentHuggingPriority(200, for: .vertical)
            return ([x,y],[minw,minh,maxh,maxw])
        case let .bottomAuto(max: max, min: min, VerticleOffset: v, horizonOffset: h):
            let t = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: h)
            let h = NSLayoutConstraint(item: self.contentView!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: h)
            let b = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: self.contentView!, attribute: .bottom, multiplier: 1, constant: v)
            let maxh = NSLayoutConstraint(item: self.contentView!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: max)
            let minh = NSLayoutConstraint(item: self.contentView!, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: min)
            self.contentView?.setContentHuggingPriority(200, for: .vertical)
            return ([t,h,b],[maxh,minh])
        case let .topAuto(max: max, min: min,VerticleOffset: v, horizonOffset: h):
            let t = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: h)
            let h = NSLayoutConstraint(item: self.contentView!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: h)
            let b = NSLayoutConstraint(item: self.contentView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: v)
            let maxh = NSLayoutConstraint(item: self.contentView!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: max)
            let minh = NSLayoutConstraint(item: self.contentView!, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: min)
            self.contentView?.setContentHuggingPriority(200, for: .vertical)
            return ([t,h,b],[maxh,minh])
        case let .middleAuto(max: max, min: min,HorizonOffset: h):
            let y = NSLayoutConstraint(item: self.view, attribute: .centerY, relatedBy: .equal, toItem: self.contentView!, attribute: .centerY, multiplier: 1, constant: 0)
            let l = NSLayoutConstraint(item: self.contentView!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: h)
            let t = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: h)
            let maxh = NSLayoutConstraint(item: self.contentView!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: max)
            let minh = NSLayoutConstraint(item: self.contentView!, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: min)
            self.contentView?.setContentHuggingPriority(200, for: .vertical)
            return([y,l,t],[maxh,minh])
        }
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
    
    public var backgroudView:(HudPlain,UIView)->UIView? = {hud,content in
        return nil
    }
    public var backgroundImage:(HudPlain,UIView)->UIImage? = {hud,content in
        return nil
    }
    
    func innnerClose() {
        closeHud()
    }
    public func closeHud(completion: (() -> Void)? = nil){
        self.dismiss(animated: useDefaultAnimation) { 
            self.contentView?.stop(contain: self)
            completion?()
        }
        
    }
    override public func viewDidAppear(_ animated: Bool) {
        self.animationShow(self,self.contentView!,nil)
    }
    override public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.animationClose(self, self.contentView!) { (i) in
            super.dismiss(animated: flag, completion: completion)
        }
    }
    public override func loadView() {
        self.view = UIImageView();
        self.view.frame = UIScreen.main.bounds
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK:- Maker
public class HudPlainMaker:NSObject{
    public func makeCircle(color:UIColor)->HudPlain {
        let hud = HudPlain()
        let c = CircleIndicateView()
        c.color = color
        hud.content = {(_) in return c}
        return hud
    }
    public func makeMiddle(text:String,color:UIColor)->HudPlain{
        let hud = HudPlain()
        let c = MiddleHudView<CircleIndicateView>()
        c.CircleView.color = color
        c.label.text = text
        hud.content = { (_) in c}
        c.CircleView.isElement = true
        hud.Style = {$0.0.view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)}
        hud.layoutStyle = HudLayoutStyle.middleAuto(max: 320, min: 80, HorizonOffset: 20)
        UIGraphicsBeginImageContextWithOptions(CGSize(width:40,height:40), false, UIScreen.main.scale)
        let rect = CGRect(x: 4, y: 4, width: 32, height: 32)
        let p = UIBezierPath(roundedRect:rect , cornerRadius: 4)
        UIColor.white.setFill()
        let context = UIGraphicsGetCurrentContext()
        context?.setShadow(offset: CGSize(width:0,height:0), blur: 1, color: UIColor.black.withAlphaComponent(0.8).cgColor)
        p.fill()
        c.image = UIGraphicsGetImageFromCurrentImageContext()
        c.image = c.image?.resizableImage(withCapInsets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        UIGraphicsEndImageContext()
        return hud
    }
    public func makeTest()->HudPlain{
        let hud = HudPlain()
        let l = UILabel()
        l.numberOfLines = 0
        hud.content = {_ in l}
        l.text = "asdasdasdasdasdasdj asjd "
        hud.layoutStyle = HudLayoutStyle.centerAuto(max: CGSize(width:320,height:320), min: CGSize(width: 32, height: 32))
        return hud
    }
}
