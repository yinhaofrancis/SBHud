//
//  ViewController.swift
//  hud
//
//  Created by hao yin on 23/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let make = HudPlainMaker()
    let data = [
        [
            ["type":HudStyle.waitting,"color":UIColor.purple],
            ["type":HudStyle.warnning,"color":UIColor.purple],
            ["type":HudStyle.failure,"color":UIColor.purple],
            ["type":HudStyle.success,"color":UIColor.purple]
        ]
    ]
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            make.makeCenter(color: data[0][indexPath.row]["color"] as! UIColor, stype: data[0][indexPath.row]["type"] as! HudStyle).showHud(from: self, delay: 3)
        }else if indexPath.section == 1{
            make.makeMiddle(text: "请等待", color: data[0][indexPath.row]["color"] as! UIColor, style: data[0][indexPath.row]["type"] as! HudStyle).showHud(from: self, delay: 3)
        }else if indexPath.section == 2{
            let a = make.makeProcess(color: UIColor.red)
            
            a.showHud(from: self)
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
                a.process += 0.1
            })
        }
        
    }
}

