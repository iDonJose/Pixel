/*:
 ## `Stroke`
 */

import Pixel


let stroke = Stroke(width: 8,
                    alignment: .center,
                    cap: .round,
                    join: .round,
                    dash: 0,
                    gap: 0,
                    phase: 0)
stroke



extension Stroke: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        let view = View()
        view.frame.size = .init(width: 400, height: 400)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.stroke = self
        return view
    }
}

class View: UIView {

    var stroke = Stroke()

    override func draw(_ bounds: CGRect) {
        super.draw(bounds)
        let context = UIGraphicsGetCurrentContext()!

        context.setStrokeColor(#colorLiteral(red: 0.1467625008, green: 0.2171751079, blue: 0.7644566127, alpha: 1))
        stroke.apply(on: context)

        let path = BezierPath.svg(["M50,50 Q-30,100 50,150 100,230 150,150 230,100 150,50 100,-30 50,50" ],
                                  bounds: .one * 200,
                                  insets: .one * 20)
        context.addPath(path.path(for: bounds).cgPath)
        context.strokePath()
    }
}

//: < [Summary](Summary) | [Next](@next) >
