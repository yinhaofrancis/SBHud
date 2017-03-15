//
//  QuickLayout.swift
//  SBHud
//
//  Created by hao yin on 15/03/2017.
//  Copyright © 2017 hao yin. All rights reserved.
//

import UIKit


extension UIView{
    func layoutAttribute(prop:NSLayoutAttribute) ->(UIView,NSLayoutAttribute) {
        return (self,prop)
    }
}
postfix operator <~
postfix func <~(a:(UIView,NSLayoutAttribute))->(NSLayoutRelation)->(UIView?,NSLayoutAttribute)->(CGFloat)->(CGFloat)->Void{
    return{ r in
        return{ b in
            return {m in
                return {c in
                    let lay = NSLayoutConstraint(item: a.0, attribute: a.1, relatedBy: r, toItem: b.0, attribute: b.1, multiplier: m, constant: c)
                    a.0.addConstraint(lay)
                }
            }
        }
    }
}
postfix operator ~>
postfix func ~>(a:(UIView,NSLayoutAttribute))->(NSLayoutRelation)->(UIView?,NSLayoutAttribute)->(CGFloat)->(CGFloat)->Void{
    return{ r in
        return{ b in
            return {m in
                return {c in
                    let lay = NSLayoutConstraint(item: a.0, attribute: a.1, relatedBy: r, toItem: b.0, attribute: b.1, multiplier: m, constant: c)
                    b.0?.addConstraint(lay)
                }
            }
        }
    }
}
//NSLayoutConstraint(item: <#T##Any#>, attribute: <#T##NSLayoutAttribute#>, relatedBy: <#T##NSLayoutRelation#>, toItem: <#T##Any?#>, attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
//第一个Item的属性= (= )第二个Item的属性*Multiplier+Constant
