/*:
 ## `CALayer`
 */

import Pixel


let layer = CALayer()
layer.frame.size = .init(width: 100, height: 100)

/*:
 ### `change(anchor:)`
 Changes anchor point without changing layer's position
 */

layer.anchorPoint
layer.frame.origin

layer.anchorPoint = .init(x: 0.4, y: 0.5)
layer.anchorPoint
layer.frame.origin
layer.frame.origin = .zero

layer.change(anchor: .init(x: 0.4, y: 0.5))
layer.anchorPoint
layer.frame.origin


//: < [Summary](Summary) | [Next](@next) >
