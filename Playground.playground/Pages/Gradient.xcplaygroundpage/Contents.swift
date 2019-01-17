/*:
 ## `Gradient`
 */

import Pixel


/*:
 ### `Gradient.linear`
 Creates a linear gradient
 > See also `vertical(colors:)`, `horizontal(colors:)`, `direction(_:colors:)`
 */
let linear = Gradient.linear(colors: .init(#colorLiteral(red: 0.2027656097, green: 0.2790459079, blue: 1, alpha: 1), #colorLiteral(red: 0.3149635069, green: 0.6492157217, blue: 0.7958984375, alpha: 1), #colorLiteral(red: 0.2526174113, green: 0.7159249442, blue: 0.2387215364, alpha: 1), #colorLiteral(red: 0.9664071295, green: 1, blue: 0.3240632684, alpha: 1)),
                             start: .zero,
                             end: .one,
                             isRelative: true)
linear


/*:
 ### `Gradient.radial`
 Creates a radial gradient
 */

let radial = Gradient.radial(colors: .init(#colorLiteral(red: 0.6280168806, green: 0.1038953145, blue: 0.2082267484, alpha: 1), #colorLiteral(red: 0.8015442607, green: 0.3330580239, blue: 0.8189174107, alpha: 1), #colorLiteral(red: 0.4873726719, green: 0.3989789773, blue: 0.8835100446, alpha: 1), #colorLiteral(red: 0.2962650405, green: 0.3629109427, blue: 0.9480503627, alpha: 1)),
                             startCenter: .one * 0.4,
                             endCenter: .one * 0.9,
                             startRadius: 0,
                             endRadius: 1,
                             isRelative: true)
radial


/*:
 ### `Gradient.conical`
 Creates a conical gradient
 */

let gradient = Gradient.conical(colors: .init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)),
                                center: .one * 0.5,
                                startRadius: 0.1,
                                endRadius: 0.5,
                                isRelative: true,
                                startAngle: .pi / 6,
                                endAngle: -.pi / 6)
gradient


/*:
 ### `Gradient.uniform`
 Creates a gradient that has only one color
 */

let uniform = Gradient.uniform(color: #colorLiteral(red: 0.3488978181, green: 0.905152239, blue: 0.9480503627, alpha: 1))



extension Gradient: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        let view = View()
        view.frame.size = .init(width: 400, height: 400)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.gradient = self
        return view
    }
}

class View: UIView {

    var gradient = Gradient()

    override func draw(_ bounds: CGRect) {
        super.draw(bounds)
        let context = UIGraphicsGetCurrentContext()!
        gradient.draw(in: bounds, context: context)
    }
}

//: < [Summary](Summary) | [Next](@next) >
