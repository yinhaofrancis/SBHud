import UIKit


public protocol IFactory{
    static func make(type:HudType)->IContentRender
}




//public class DefaultFactory:IFactory{
//    public static func make(type: HudType) -> IContentRender {
//        switch type {
//        case .waiting:
//            return makeWaiting(type: type)
//        }
//    }
//    static func makeWaiting(type:HudType) ->IContentRender{
//        
//    }
//}
