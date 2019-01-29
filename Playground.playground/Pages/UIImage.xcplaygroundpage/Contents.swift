/*:
 ## `UIImage`
 */

import Pixel


/*:
 ### `init(color:shape:size:)`
 Creates an image from a shape and color.
 > See also `init(color:shapeForBounds:size:)`
 */

let color = #colorLiteral(red: 0.7736413373, green: 0.4306083741, blue: 0.9326520647, alpha: 1)
let shape = BezierPath.squircle(cornerRadii: [.allCorners: 0.25],
                                isRelative: true,
                                morphsIntoCircle: false,
                                insets: .one * 10)

var image = UIImage(color: color, shape: shape, size: .one * 200)

/*:
 ### `init(gradient:shape:size:)`
 Creates an image from a shape and gradient.
 > See also `init(gradient:shapeForBounds:size:)`
 */

let gradient = Gradient.horizontal(colors: #colorLiteral(red: 0.3515037003, green: 0.5538487399, blue: 1, alpha: 1), #colorLiteral(red: 0.7736413373, green: 0.4306083741, blue: 0.9326520647, alpha: 1), #colorLiteral(red: 0.5298200335, green: 0.2564727642, blue: 0.3665198898, alpha: 1))
image = UIImage(gradient: gradient, shape: shape, size: .one * 200)


//: < [Summary](Summary) | [Next](@next) >
