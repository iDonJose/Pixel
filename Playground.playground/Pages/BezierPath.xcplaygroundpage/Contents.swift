/*:
 ## `BezierPath`
 */

import Pixel


/*:
 ### `Gradient.circle`
 Creates a circle bezier path
 > See also `rect`, `roundedRect`, `oval`, `squircle`, `arc`, `svg`
 */

let circle = BezierPath.circle(insets: .one * 20)


/*:
 ### `Gradient.squircle`
 Creates a squircle bezier path
 */

let squircle = BezierPath.squircle(cornerRadii: [.topLeft: 80, .bottomRight: 200],
                                   isRelative: false,
                                   morphsIntoCircle: false,
                                   insets: .one * 20)
squircle


/*:
 ### `Gradient.svg`
 Creates a bezier path from custom SVGs
 */

let svg = BezierPath.svg(["M100,250 C313,41 114,343 400,250",
                          "M50,50 Q-30,100 50,150 100,230 150,150 230,100 150,50 100,-30 50,50" ],
                         bounds: .one * 400,
                         insets: .one * 20)
svg



extension BezierPath: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        let view = View()
        view.frame.size = .init(width: 400, height: 400)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.bezierPath = self
        return view
    }
}

class View: UIView {

    var bezierPath = BezierPath()

    override func draw(_ bounds: CGRect) {
        super.draw(bounds)
        let context = UIGraphicsGetCurrentContext()!

        context.setStrokeColor(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
        context.setLineWidth(8)
        context.setLineCap(.round)
        context.addPath(bezierPath.path(for: bounds).cgPath)
        context.strokePath()
    }
}

//: < [Summary](Summary) | [Next](@next) >
