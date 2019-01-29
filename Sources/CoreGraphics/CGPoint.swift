//
//  CGPoint.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CGPoint {

	/// Point with coordinates (1, 1)
	public static let one = CGPoint(x: 1, y: 1)

	/// Norm
	public var norm: CGFloat {
		return sqrt(pow(x, 2) + pow(y, 2))
	}

	/// Normed point
	public func normed() -> CGPoint {
		let norm = self.norm
		return CGPoint(x: x / norm,
					   y: y / norm)
	}


	/// Calculates angle from point to another.
	/// Result angle is in [0, 2pi] radians
	public func angle(to point: CGPoint) -> CGFloat {

		var angle = atan2(point.y, point.x) - atan2(y, x)
		if angle < 0 { angle += 2 * .pi }

		return angle
	}

	/// Calculates angle from point to another.
	/// Result angle is in [0, 2pi] radians
	public func angle(from point: CGPoint) -> CGFloat {
		return 2 * .pi - point.angle(to: self)
	}

	/// Rotates point by a given angle (radians), origin is used as rotation center
	public func rotated(by angle: CGFloat) -> CGPoint {

		let cos = CoreGraphics.cos(angle)
		let sin = CoreGraphics.sin(angle)

		return CGPoint(x: x * cos - y * sin,
					   y: x * sin + y * cos)
	}


	/// Returns value when projected on a direction
	public func projected(on direction: UICollectionView.ScrollDirection) -> CGFloat {
		switch direction {
		case .horizontal: return x
		case .vertical: return y
		}
	}

}
