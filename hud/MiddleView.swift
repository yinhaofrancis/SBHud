//
//  MiddleView.swift
//  hud
//
//  Created by hao yin on 2017/3/26.
//  Copyright © 2017年 hao yin. All rights reserved.
//

import UIKit
public enum HudStyle{
    case waitting
    case success
    case warnning
    case failure
}
public class baseIndicateView:UIView,IndicateProperty{
    public var color: UIColor = UIColor.black
    public var isElement: Bool = true
}


public class IndicateContainerView:UIImageView {
    public let CircleView:baseIndicateView
    public init(indicate:baseIndicateView.Type){
        CircleView = indicate.init()
        
        super.init(frame: CGRect.zero)
    }
    public override func start(contain: HudPlain) {
        super.start(contain: contain)
        CircleView.start(contain: contain)
    }
    public override func stop(contain: HudPlain) {
        super.stop(contain: contain)
        CircleView.stop(contain: contain)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func config(){}
    private var limit:Bool = true
    public override func didMoveToWindow() {
        if limit{
            self.addSubview(CircleView)
            CircleView.translatesAutoresizingMaskIntoConstraints = false
            config()
            layout()
            limit = false
        }
    }
    public func layout(){}
}

public class MiddleHudContainerView:IndicateContainerView{
    public let label:UILabel = UILabel()
    public override func config() {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
    }
    override public func layout(){
        let h = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[view(64)]-20-[label]-20-|", options: .alignAllTop, metrics: nil, views: ["view":self.CircleView,"label":self.label])
        let vl = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[label]-20-|", options: .alignAllBottom, metrics: nil, views: ["label":self.label])
        
        let vc = NSLayoutConstraint.constraints(withVisualFormat: "V:[view(64)]-(>=20)-|", options: .alignAllBottom, metrics: nil, views: ["view":self.CircleView])
        self.addConstraints(h + vl + vc)
    }
}
