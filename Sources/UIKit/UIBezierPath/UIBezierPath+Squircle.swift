//
//  UIBezierPath+Squircle.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//

// Sources :
// - https://github.com/interfacemarket/Egmont-plugin/blob/master/Egmont-plugin.sketchplugin/Contents/Sketch/EgmontPlugin.js
// - https://www.paintcodeapp.com/news/code-for-ios-7-rounded-rectangles


extension UIBezierPath {

	/// Creates a squircle path
	public convenience init(squircleIn bounds: CGRect,
							cornerRadius: CGFloat) {
		self.init()

		let radiusLimit = min(bounds.width, bounds.height) / 2 / 1.52866483
		let radiusMax = min(cornerRadius, radiusLimit)


		// Rectangle corners
		let A: (CGFloat, CGFloat) -> CGPoint = { x, y in
			return CGPoint(x: bounds.origin.x + x * radiusMax,
						   y: bounds.origin.y + y * radiusMax)
		}
		let B: (CGFloat, CGFloat) -> CGPoint = { x, y in
			return CGPoint(x: bounds.origin.x + bounds.width - x * radiusMax,
						   y: bounds.origin.y + y * radiusMax)
		}
		let C: (CGFloat, CGFloat) -> CGPoint = { x, y in
			return CGPoint(x: bounds.origin.x + bounds.width - x * radiusMax,
						   y: bounds.origin.y + bounds.height - y * radiusMax)
		}
		let D: (CGFloat, CGFloat) -> CGPoint = { x, y in
			return CGPoint(x: bounds.origin.x + x * radiusMax,
						   y: bounds.origin.y + bounds.height - y * radiusMax)
		}

		// Side middles
		let E: (CGFloat) -> CGPoint = { y in
			return CGPoint(x: bounds.midX,
						   y: bounds.origin.y + y * bounds.width)
		}
		let F: (CGFloat) -> CGPoint = { x in
			return CGPoint(x: bounds.x + bounds.width - x * radiusMax,
						   y: bounds.midY)
		}
		let G: (CGFloat) -> CGPoint = { y in
			return CGPoint(x: bounds.midX,
						   y: bounds.y + bounds.height - y * radiusMax)
		}
		let H: (CGFloat) -> CGPoint = { x in
			return CGPoint(x: bounds.x + x * bounds.height,
						   y: bounds.midY)
		}

		let threshold = 1.52866495 * 2 * cornerRadius


		if bounds.width > threshold && bounds.height > threshold {

			move(to: A(1.52866483, 0))
			addLine(to: B(1.52866471, 0))
			addCurve(to: B(0.66993427, 0.06549600), controlPoint1: B(1.08849323, 0), controlPoint2: B(0.86840689, 0))
			addLine(to: B(0.63149399, 0.07491100))
			addCurve(to: B(0.07491176, 0.63149399), controlPoint1: B(0.37282392, 0.16905899), controlPoint2: B(0.16906013, 0.37282401))
			addCurve(to: B(0, 1.52866483), controlPoint1: B(0, 0.86840701), controlPoint2: B(0, 1.08849299))
			addLine(to: C(0, 1.52866471))
			addCurve(to: C(0.06549569, 0.66993493), controlPoint1: C(0, 1.08849323), controlPoint2: C(0, 0.86840689))
			addLine(to: C(0.07491111, 0.63149399))
			addCurve(to: C(0.63149399, 0.07491111), controlPoint1: C(0.16905883, 0.37282392), controlPoint2: C(0.37282392, 0.16905883))
			addCurve(to: C(1.52866471, 0), controlPoint1: C(0.86840689, 0), controlPoint2: C(1.08849323, 0))
			addLine(to: D(1.52866483, 0))
			addCurve(to: D(0.66993397, 0.06549569), controlPoint1: D(1.08849299, 0), controlPoint2: D(0.86840701, 0))
			addLine(to: D(0.63149399, 0.07491111))
			addCurve(to: D(0.07491100, 0.63149399), controlPoint1: D(0.37282401, 0.16905883), controlPoint2: D(0.16906001, 0.37282392))
			addCurve(to: D(0, 1.52866471), controlPoint1: D(0, 0.86840689), controlPoint2: D(0, 1.08849323))
			addLine(to: A(0, 1.52866483))
			addCurve(to: A(0.06549600, 0.66993397), controlPoint1: A(0, 1.08849299), controlPoint2: A(0, 0.86840701))
			addLine(to: A(0.07491100, 0.63149399))
			addCurve(to: A(0.63149399, 0.07491100), controlPoint1: A(0.16906001, 0.37282401), controlPoint2: A(0.37282401, 0.16906001))
			addCurve(to: A(1.52866483, 0), controlPoint1: A(0.86840701, 0), controlPoint2: A(1.08849299, 0))
			close()

		}
		else if bounds.width > threshold {

			let F0 = F(0)
			let H0 = H(0)

			move(to: A(2.00593972, 0))
			addLine(to: CGPoint(x: bounds.x + bounds.width - 1.52866483 * cornerRadius, y: bounds.y))
			addCurve(to: B(0.99544263, 0.10012127), controlPoint1: B(1.63527834, 0), controlPoint2: B(1.29884040, 0))
			addLine(to: B(0.93667978, 0.11451437))
			addCurve(to: B(0.00000051, 1.45223188), controlPoint1: B(0.37430558, 0.31920183), controlPoint2: B(0.00000051, 0.85376567))
			addCurve(to: F0, controlPoint1: F0, controlPoint2: F0)
			addLine(to: F0)
			addCurve(to: F0, controlPoint1: F0, controlPoint2: F0)
			addLine(to: C(0, 1.45223165))
			addCurve(to: C(0.93667978, 0.11451438), controlPoint1: C(0, 0.85376561), controlPoint2: C(0.37430558, 0.31920174))
			addCurve(to: C(2.30815363, 0), controlPoint1: C(1.29884040, 0), controlPoint2: C(1.63527834, 0))
			addLine(to: CGPoint(x: bounds.x + 1.52866483 * cornerRadius, y: bounds.y + bounds.height))
			addCurve(to: D(0.99544257, 0.10012124), controlPoint1: D(1.63527822, 0), controlPoint2: D(1.29884040, 0))
			addLine(to: D(0.93667972, 0.11451438))
			addCurve(to: D(-0.00000001, 1.45223176), controlPoint1: D(0.37430549, 0.31920174), controlPoint2: D(-0.00000007, 0.85376561))
			addCurve(to: H0, controlPoint1: H0, controlPoint2: H0)
			addLine(to: H0)
			addCurve(to: H0, controlPoint1: H0, controlPoint2: H0)
			addLine(to: A(-0.00000001, 1.45223153))
			addCurve(to: A(0.93667978, 0.11451436), controlPoint1: A(0.00000004, 0.85376537), controlPoint2: A(0.37430561, 0.31920177))
			addCurve(to: A(2.30815363, 0), controlPoint1: A(1.29884040, 0), controlPoint2: A(1.63527822, 0))
			addLine(to: CGPoint(x: bounds.x + 1.52866483 * cornerRadius, y: bounds.y))
			addLine(to: A(2.00593972, 0))
			close()

		}
		else if bounds.height > threshold {

			let E0 = E(0)
			let G0 = G(0)

			move(to: E0)
			addLine(to: E0)
			addCurve(to: E0, controlPoint1: E0, controlPoint2: E0)
			addLine(to: B(1.45223153, 0))
			addCurve(to: B(0.11451442, 0.93667936), controlPoint1: B(0.85376573, 0.00000001), controlPoint2: B(0.31920189, 0.37430537))
			addCurve(to: B(0, 2.30815387), controlPoint1: B(0, 1.29884040), controlPoint2: B(0, 1.63527822))
			addLine(to: CGPoint(x: bounds.x + bounds.width, y: bounds.y + bounds.height - 1.52866483 * cornerRadius))
			addCurve(to: C(0.10012137, 0.99544269), controlPoint1: C(0, 1.63527822), controlPoint2: C(0, 1.29884028))
			addLine(to: C(0.11451442, 0.93667972))
			addCurve(to: C(1.45223165, 0), controlPoint1: C(0.31920189, 0.37430552), controlPoint2: C(0.85376549, 0))
			addCurve(to: G0, controlPoint1: G0, controlPoint2: G0)
			addLine(to: G0)
			addCurve(to: G0, controlPoint1: G0, controlPoint2: G0)
			addLine(to: D(1.45223141, 0))
			addCurve(to: D(0.11451446, 0.93667972), controlPoint1: D(0.85376543, 0), controlPoint2: D(0.31920192, 0.37430552))
			addCurve(to: D(0, 2.30815387), controlPoint1: D(0, 1.29884028), controlPoint2: D(0, 1.63527822))
			addLine(to: CGPoint(x: bounds.x, y: bounds.y + 1.52866483 * cornerRadius))
			addCurve(to: A(0.10012126, 0.99544257), controlPoint1: A(0, 1.63527822), controlPoint2: A(0, 1.29884040))
			addLine(to: A(0.11451443, 0.93667966))
			addCurve(to: A(1.45223153, 0), controlPoint1: A(0.31920189, 0.37430552), controlPoint2: A(0.85376549, 0))
			addCurve(to: E0, controlPoint1: E0, controlPoint2: E0)
			addLine(to: E0)
			close()

		}
		else if bounds.height > 1.52866495 * 2 * bounds.width {

			let E0 = E(0)
			let F0 = F(0)
			let G0 = G(0)
			let H0 = H(0)

			move(to: E0)
			addLine(to: E0)
			addCurve(to: E0, controlPoint1: E0, controlPoint2: E0)
			addLine(to: E0)
			addCurve(to: B(0, 1.52866483), controlPoint1: B(0.68440646, 0.00000001), controlPoint2: B(0, 0.68440658))
			addCurve(to: B(0, 1.52866507), controlPoint1: B(0, 1.52866495), controlPoint2: B(0, 1.52866495))
			addCurve(to: B(0, 1.52866483), controlPoint1: B(0, 1.52866483), controlPoint2: B(0, 1.52866483))
			addLine(to: F0)
			addCurve(to: C(0, 1.52866471), controlPoint1: C(0, 1.52866471), controlPoint2: C(0, 1.52866471))
			addLine(to: C(0, 1.52866471))
			addCurve(to: G0, controlPoint1: C(0, 0.68440646), controlPoint2: C(0.68440646, 0))
			addCurve(to: G0, controlPoint1: G0, controlPoint2: G0)
			addCurve(to: G0, controlPoint1: G0, controlPoint2: G0)
			addLine(to: G0)
			addCurve(to: G0, controlPoint1: G0, controlPoint2: G0)
			addLine(to: G0)
			addCurve(to: D(0, 1.52866471), controlPoint1: D(0.68440646, 0), controlPoint2: D(-0.00000004, 0.68440646))
			addCurve(to: D(0, 1.52866495), controlPoint1: D(0, 1.52866471), controlPoint2: D(0, 1.52866495))
			addCurve(to: D(0, 1.52866471), controlPoint1: D(0, 1.52866471), controlPoint2: D(0, 1.52866471))
			addLine(to: H0)
			addCurve(to: A(0, 1.52866483), controlPoint1: A(0, 1.52866483), controlPoint2: A(0, 1.52866483))
			addLine(to: A(0, 1.52866471))
			addCurve(to: E0, controlPoint1: A(0.00000007, 0.68440652), controlPoint2: A(0.68440658, -0.00000001))
			addCurve(to: E0, controlPoint1: E0, controlPoint2: E0)
			addLine(to: E0)
			close()

		}
		else {

			let E0 = E(0)
			let F0 = F(0)
			let H0 = H(0)
			let G0 = G(0)

			move(to: E0)
			addLine(to: E0)
			addCurve(to: B(1.52866495, 0), controlPoint1: B(1.52866495, 0), controlPoint2: B(1.52866495, 0))
			addLine(to: B(1.52866495, 0))
			addCurve(to: F0, controlPoint1: B(0.68440676, 0.00000001), controlPoint2: B(0, 0.68440658))
			addCurve(to: F0, controlPoint1: F0, controlPoint2: F0)
			addCurve(to: F0, controlPoint1: F0, controlPoint2: F0)
			addLine(to: F0)
			addCurve(to: F0, controlPoint1: F0, controlPoint2: F0)
			addLine(to: F0)
			addCurve(to: C(1.52866495, 0), controlPoint1: C(0, 0.68440652), controlPoint2: C(0.68440676, 0))
			addCurve(to: C(1.52866495, 0), controlPoint1: C(1.52866495, 0), controlPoint2: C(1.52866495, 0))
			addCurve(to: C(1.52866495, 0), controlPoint1: C(1.52866495, 0), controlPoint2: C(1.52866495, 0))
			addLine(to: G0)
			addCurve(to: D(1.52866483, 0), controlPoint1: D(1.52866483, 0), controlPoint2: D(1.52866483, 0))
			addLine(to: D(1.52866471, 0))
			addCurve(to: H0, controlPoint1: D(0.68440646, 0), controlPoint2: D(-0.00000004, 0.68440676))
			addCurve(to: H0, controlPoint1: H0, controlPoint2: H0)
			addCurve(to: H0, controlPoint1: H0, controlPoint2: H0)
			addLine(to: H0)
			addCurve(to: H0, controlPoint1: H0, controlPoint2: H0)
			addLine(to: H0)
			addCurve(to: A(1.52866483, 0), controlPoint1: A(0.00000007, 0.68440652), controlPoint2: A(0.68440664, -0.00000001))
			addCurve(to: A(1.52866483, 0), controlPoint1: A(1.52866483, 0), controlPoint2: A(1.52866483, 0))
			addLine(to: E0)
			close()

		}

	}

}
