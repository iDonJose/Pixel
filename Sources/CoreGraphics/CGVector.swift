//
//  CGVector.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CGVector {

	/// Vector (1, 1)
	public static let one = CGVector(dx: 1, dy: 1)

	/// Norm
	public var norm: CGFloat {
		return sqrt(pow(dx, 2) + pow(dy, 2))
	}

	/// Normed point
	public func normed() -> CGVector {
		let norm = self.norm
		return CGVector(dx: dx / norm,
					   	dy: dy / norm)
	}


	/// Calculates angle from vector to another.
	/// Result angle is in [0, 2pi] radians
	public func angle(to vector: CGVector) -> CGFloat {

		var angle = atan2(dy, dx) - atan2(vector.dy, vector.dx)
		if angle < 0 { angle += 2 * .pi }

		return angle
	}

	/// Rotates vector by a given angle (radians)
	public func rotating(by angle: CGFloat) -> CGVector {

		let cos = CoreGraphics.cos(angle)
		let sin = CoreGraphics.sin(angle)

		return CGVector(dx: dx * cos - dy * sin,
						dy: dx * sin + dy * cos)
	}


	/// Returns value when projected on a direction
	public func projected(on direction: UICollectionView.ScrollDirection) -> CGFloat {
		switch direction {
		case .horizontal: return dx
		case .vertical: return dy
		}
	}

}
