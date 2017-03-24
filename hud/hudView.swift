//
//  hudView.swift
//  hud
//
//  Created by hao yin on 23/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

public enum HudType:String{
    case waiting = "waiter"
}
public class HudView: UIView {
    public var render:IContentRender!;
    var on = false
    public override func layoutSubviews() {
        render.render(container: self)
    }
    public override func didMoveToWindow() {
        if !on{
            let x = NSLayoutConstraint(item: self.superview!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
            let y = NSLayoutConstraint(item: self.superview!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            
            let w = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 96)
            let h = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 96)
            self.addConstraints([w,h])
            
            self.superview?.addConstraints([x,y])
            on = true
   
        }
        
    }
}
public class hudController:UIViewController{
    public static var factory:IFactory = DefaultFactory() as IFactory
    public init(type:HudType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        
    }
    let type:HudType
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var hud:HudView?
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    public override func viewDidAppear(_ animated: Bool) {
        hud?.render.showAnimation(hub: hud!)
    }
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.hud?.render.hiddenAnimation(hub: hud!) {(i) in
            super.dismiss(animated: false, completion: nil)
        }
    }
    public func close(){

        NotificationCenter.default.post(name: NSNotification.Name.hudhidden, object:self)
        self.dismiss(animated: false) { [weak self] in
            self?.hud?.removeFromSuperview()
        }
    }
    public func show(from:UIViewController){
        if  self.view.window == nil{
            self.view.backgroundColor = UIColor.clear
            hud = HudView(frame: CGRect.zero)
            hud?.render = hudController.factory.make(type: type)
            hud?.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.hud!)
            NotificationCenter.default.post(name: NSNotification.Name.hudshow, object:self)
            from.present(self, animated: false, completion: nil)
            
        }
        
    }
}
public extension NSNotification.Name{
    public static let hudshow = NSNotification.Name("hudController.show")
    public static let hudhidden = NSNotification.Name("hudController.hidden")
}
