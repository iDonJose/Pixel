/*:
 ## `CGPoint`
 */

import Pixel


let point = CGPoint(x: 100, y: 10)
let otherPoint = CGPoint(x: 100, y: 30)

/*:
 ### `norm`
 */

let norm = point.norm

/*:
 ### `normed()`
 */

let normedPoint = point.normed()

/*:
 ### `angle(to:)`
 Angle between two points
 > See `angle(from:)`
 */

let angle = point.angle(to: otherPoint)

/*:
 ### `rotated(by:)`
 */

let rotatedPoint = point.rotated(by: .pi / 2)

/*:
 ### `projected(on:)`
 */

let horizontalProjection = point.projected(on: .horizontal)

//: < [Summary](Summary) | [Next](@next) >
