/*:
 ## `DisplayLink`
 Wraps a CADisplayLink allowing to simply update display on every frame
 */

import Pixel


let displayLink = DisplayLink(lifespan: 0.2, fps: 60) { timestamp, isCompleted, isCanceled in

    print("Timestamp : \(timestamp) ms")
    if isCompleted { print("✅") }
    else if isCanceled { print("❌") }

}


//: < [Summary](Summary) | [Next](@next) >
