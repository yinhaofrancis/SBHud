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
    let a = HudPlainMaker().makeMiddle(text: "asdasdadddtrd yt dty dtd td trd tyd td ytd yt dytd try dtyd ytdytdytdytdytdtyd td t dy tydtdugyi  fty dtr drty sresre se uy fiy y f yrsetrsetr ytr uy fuyf td srtes  drty d", color: UIColor.blue)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        a.showHud(from: self, delay: 3)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

