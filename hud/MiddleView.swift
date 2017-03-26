//
//  MiddleView.swift
//  hud
//
//  Created by hao yin on 2017/3/26.
//  Copyright © 2017年 hao yin. All rights reserved.
//

import UIKit

public class MiddleHudView<icon:UIView>:UIImageView{
    let CircleView:icon = icon()
    let label:UILabel = UILabel()
    public override func start(contain: HudPlain) {
        super.stop(contain: contain)
        CircleView.start(contain: contain)
    }
    public override func stop(contain: HudPlain) {
        super.stop(contain: contain)
        CircleView.stop(contain: contain)
        
    }
    private var limit:Bool = true
    public override func didMoveToWindow() {
        if limit{
            self.addSubview(CircleView)
            self.addSubview(label)
            CircleView.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            layout()
            limit = false
        }
        
    }
    func layout(){
        let h = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[view(64)]-20-[label]-20-|", options: .alignAllTop, metrics: nil, views: ["view":self.CircleView,"label":self.label])
        let vl = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[label]-20-|", options: .alignAllBottom, metrics: nil, views: ["label":self.label])
        
        let vc = NSLayoutConstraint.constraints(withVisualFormat: "V:[view(64)]-(>=20)-|", options: .alignAllBottom, metrics: nil, views: ["view":self.CircleView])
        self.addConstraints(h + vl + vc)
    }
}
