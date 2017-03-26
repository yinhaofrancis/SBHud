//
//  ViewController.swift
//  hud
//
//  Created by hao yin on 23/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let a = HudPlainMaker().makeMiddle(text: "asdasdad", color: UIColor.blue)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        a.showHud(from: self, delay: 3)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

