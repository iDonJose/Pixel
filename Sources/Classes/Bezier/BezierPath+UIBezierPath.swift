//
//  BezierPath+UIBezierPath.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//

// swiftlint:disable force_cast

#if USE_SVG

import SVGPath



extension BezierPath {

	public func path(for bounds: CGRect) -> UIBezierPath {
		return pathForBounds(bounds)
	}

	public var pathForBounds: (CGRect) -> UIBezierPath {
		switch self {

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

		case let .rect(insets):

			return { UIBezierPath(rect: $0.inset(by: insets)) }

		case let .oval(insets):

			return { UIBezierPath(ovalIn: $0.inset(by: insets)) }

		case let .circle(insets):

			return { _bounds in

				var bounds = _bounds.inset(by: insets)
				let diameter = min(bounds.width, bounds.height)

				let newBounds = CGRect(origin: bounds.origin + (bounds.size.to.cgPoint - .one * diameter) / 2,
									   size: .one * diameter)

				return UIBezierPath(ovalIn: newBounds)
			}

		case let .roundedRect(corners, cornerRadius, isRelative, insets):

			return { bounds in

				var cornerRadii = cornerRadius.to.cgSize

				if isRelative {
					cornerRadii.width *= bounds.width
					cornerRadii.height *= bounds.height
				}

				return UIBezierPath(roundedRect: bounds.inset(by: insets),
									byRoundingCorners: corners,
									cornerRadii: cornerRadii)
			}

		case let .squircle(cornerRadius, isRelative, insets):

			return { bounds in

				var radius = cornerRadius
				if isRelative { radius *= min(bounds.width, bounds.height) }

				return UIBezierPath(squircleIn: bounds.inset(by: insets),
									cornerRadius: radius)
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

#endif
