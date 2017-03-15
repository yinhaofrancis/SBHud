//
//  SBHud.swift
//  SBHud
//
//  Created by hao yin on 15/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit

public enum SBState{
    case success
    case fail
    case warnning
    case successWithLabel(info:String)
    case failWithLabel(info:String)
    case warnningWithLabel(info:String)
}
public enum SBStateSize{
    case size(maxwidth:CGFloat,maxheight:CGFloat)
    
    case heightUnlimit(maxwidth:CGFloat)
    
    case widthUnlimit(maxheight:CGFloat)
    
    case marginHorizental(left:CGFloat,right:CGFloat)
    
    case marginvertical(top:CGFloat,bottom:CGFloat)
    
    case margin(left:CGFloat,right:CGFloat,top:CGFloat,bottom:CGFloat)
}

public protocol SBHudMaker:class{
    func make(state:SBState)->UIView?
    func size()->SBStateSize
}

class SBHudView:UIView{
    let state:SBState
    let backgroundView:UIImageView = UIImageView()
    weak var maker:SBHudMaker!
    init(stat:SBState){
        state = stat
        super.init(frame:CGRect.zero)
    }
    
    public lazy var backgroundImage:UIImage = {
        UIGraphicsBeginImageContextWithOptions(CGSize(width:30,height:30),false, UIScreen.main.scale)
        
        UIColor.white.setFill()
        UIBezierPath(roundedRect: CGRect(x:0,y:0,width:30,height:30), cornerRadius: 8).fill()
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let edge = UIEdgeInsetsMake(8, 8, 8, 8)
        
        return img!.resizableImage(withCapInsets: edge)
    }()
    
    required init?(coder aDecoder: NSCoder) {
        guard let dec = aDecoder.decodeObject(forKey: "state") else{
            state = .success
            super.init(coder: aDecoder)
            return
        }
        state = dec as! SBState
        super.init(coder: aDecoder)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        baseConfig()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseConfigSize()
    }
    
    func config(state:SBState) throws{
        guard let v = self.maker.make(state: state) else{
            throw NSError(domain: "unimplement \(state)", code: 0, userInfo: nil)
        }
        self.addSubview(v)
        
    }
    
    func baseConfigSize()  {
        self.backgroundView.frame = self.bounds
    }
    func baseConfig(){
        self.addSubview(backgroundView)
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        DispatchQueue.global().async {
            let image = self.backgroundImage
            DispatchQueue.main.async {
                self.backgroundView.image = image
            }
        }
    }
    
    
}

public class SBHud: NSObject {
    func fuck(state:SBState){
        
    }
}
