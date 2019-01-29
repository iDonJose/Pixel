/*:
 ## `CGVector`
 */

import Pixel


let vector = CGVector(dx: 100, dy: 10)
let otherVector = CGVector(dx: 100, dy: 30)

/*:
 ### `norm`
 */

let norm = vector.norm

/*:
 ### `normed()`
 */

let normedVector = vector.normed()

/*:
 ### `angle(to:)`
 Angle between two points
 > See `angle(from:)`
 */

let angle = vector.angle(to: otherVector)

/*:
 ### `rotated(by:)`
 */

let rotatedVector = vector.rotated(by: .pi / 2)

/*:
 ### `projected(on:)`
 */

let horizontalProjection = vector.projected(on: .horizontal)

//: < [Summary](Summary) | [Next](@next) >
