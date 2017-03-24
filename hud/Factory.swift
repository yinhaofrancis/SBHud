import UIKit


public protocol IFactory{
    func make(type:HudType)->IContentRender
}




public class DefaultFactory:IFactory{
    public func make(type: HudType) -> IContentRender {
        switch type {
        case .waiting:
            return makeWaiting()
        }
    }
    func makeWaiting() ->IContentRender{
        return CircleWaiterRender()
    }
}
