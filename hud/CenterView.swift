//
//  CenterView.swift
//  hud
//
//  Created by hao yin on 27/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

public class CenterHudContainerView:IndicateContainerView{
    public override func config() {}
    public override func layout() {
        let v = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[view]-8-|", options: .alignAllBottom, metrics: nil, views: ["view":self.CircleView])
        let h = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[view]-8-|", options: .alignAllBottom, metrics: nil, views: ["view":self.CircleView])
        self.addConstraints(v + h)
    }
}
