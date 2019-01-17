//
//  BezierPath+UIBezierPath.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//

// swiftlint:disable force_cast

#if USE_SVG
import SVGPath
#endif



extension BezierPath {

	/// Generates a UIBezierPath
	public func path(for bounds: CGRect) -> UIBezierPath {
		return pathForBounds(bounds)
	}

	/// Create a closure returning an UIBezierPath
	public var pathForBounds: (CGRect) -> UIBezierPath {
		switch self {

        #if USE_SVG
		case let .svg(svg, size, insets):

			let path = UIBezierPath()

			svg.map { UIBezierPath(svgPath: $0) }
				.forEach { path.append($0) }

			return { _bounds in

				let bounds = _bounds.inset(by: insets)

				let bezierPath = path.copy() as! UIBezierPath
				let scale = CGAffineTransform(scaleX: bounds.width / size.width,
											  y: bounds.height / size.height)
				let translation = CGAffineTransform(translationX: bounds.x,
													y: bounds.y)
				bezierPath.apply(scale)
				bezierPath.apply(translation)

				return bezierPath
			}
        #endif

		case let .rect(insets):

			return { UIBezierPath(rect: $0.inset(by: insets)) }

		case let .oval(insets):

			return { UIBezierPath(ovalIn: $0.inset(by: insets)) }

		case let .circle(insets):

			return { _bounds in

				let bounds = _bounds.inset(by: insets)
				let diameter = min(bounds.width, bounds.height)

				let newBounds = CGRect(origin: bounds.origin + (bounds.size.to.cgPoint - .one * diameter) / 2,
									   size: .one * diameter)

				return UIBezierPath(ovalIn: newBounds)
			}

		case let .roundedRect(cornerRadii, isRelative, insets):

			return { _bounds in

				let bounds = _bounds.inset(by: insets)

				var cornerRadii = cornerRadii

                if isRelative {
                    let length = min(bounds.width, bounds.height)
                    cornerRadii = cornerRadii.mapValues { $0 * length }
                }

				return UIBezierPath(roundedRectIn: bounds,
									cornerRadii: cornerRadii)
			}

		case let .squircle(cornerRadii, isRelative, morphsIntoCircle, insets):

			return { _bounds in

				let bounds = _bounds.inset(by: insets)

				var cornerRadii = cornerRadii

                if isRelative {
                    let length = min(bounds.width, bounds.height)
                    cornerRadii = cornerRadii.mapValues { $0 * length }
                }

				return UIBezierPath(squircleIn: bounds,
                                    cornerRadii: cornerRadii,
                                    morphsIntoCircle: morphsIntoCircle)
			}

		case let .arc(_radius, isRelative, startAngle, endAngle, insets):

			return { _bounds in

				let bounds = _bounds.inset(by: insets)

				var radius = _radius
				if isRelative { radius *= min(bounds.width, bounds.height) }

				return UIBezierPath(arcCenter: bounds.center,
									radius: radius,
									startAngle: startAngle - .pi / 2,
									endAngle: endAngle  - .pi / 2,
									clockwise: true)
			}

		}
	}

}
