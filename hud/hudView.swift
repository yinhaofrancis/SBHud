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
    public override func didMoveToWindow() {
        render.render(container: self)
    }
}
