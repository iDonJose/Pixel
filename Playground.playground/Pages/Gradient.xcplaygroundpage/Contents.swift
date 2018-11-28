/*:
 ## `Gradient`
 */

import Pixel
import PlaygroundSupport


let colors = Gradient.Colors(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))

let gradient = Gradient.conical(colors: colors,
                                center: .one * 0.5,
                                startRadius: 0.25,
                                endRadius: 0.5,
                                isRelative: true,
                                startAngle: 1 / 2 * .pi,
                                endAngle: 2 * .pi)

class View: UIView {

    override func draw(_ rect: CGRect) {

        let start = CACurrentMediaTime()
        defer {
            let end = CACurrentMediaTime()
            print("\(#function) took \((end - start) * 1_000) ms")
        }

        let context = UIGraphicsGetCurrentContext()!

        gradient.draw(in: rect, context: context)

    }

}

let view = View()
view.frame.size = .one * 400
PlaygroundPage.current.liveView = view



//: < [Summary](Summary) | [Next](@next) >
