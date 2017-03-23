//
//  ViewController.swift
//  hud
//
//  Created by hao yin on 23/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ca: UISlider!
    @IBOutlet weak var a: WaiterAnimatonDisplayView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func aaa(_ sender: Any) {
        a.m = Double(ca.value)
    }


}

