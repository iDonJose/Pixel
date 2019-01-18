/*:
 ## `Shadow`
 */

import Pixel


let shadow = Shadow(color: #colorLiteral(red: 1, green: 0, blue: 0.02273212553, alpha: 1),
                    radius: 10,
                    offset: .init(x: 2, y: 5))
shadow



extension Shadow: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        let view = View()
        view.frame.size = .init(width: 400, height: 400)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.shadow = self
        return view
    }
}

class View: UIView {

    var shadow = Shadow()

    override func draw(_ bounds: CGRect) {
        super.draw(bounds)
        let context = UIGraphicsGetCurrentContext()!

        let path = BezierPath.svg(["M50,50 Q-30,100 50,150 100,230 150,150 230,100 150,50 100,-30 50,50" ],
                                  bounds: .one * 200,
                                  insets: .one * 20)
        context.addPath(path.path(for: bounds).cgPath)

        context.setStrokeColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        context.setLineWidth(2)
        shadow.draw(context: context)
        context.strokePath()
    }
}

//: < [Summary](Summary) | [Next](@next) >
