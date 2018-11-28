//
//  BezierCurve.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


/// Cubic Bezier curve
public struct BezierCurve {

	/// Control point 1
	public var cp1: CGPoint
	/// Control point 2
	public var cp2: CGPoint
	/// Control point 3
	public var cp3: CGPoint
	/// Control point 4
	public var cp4: CGPoint


	// MARK: - Initialize

	public init(_ cp1: CGPoint,
				_ cp2: CGPoint,
				_ cp3: CGPoint,
				_ cp4: CGPoint) {
		self.cp1 = cp1
		self.cp2 = cp2
		self.cp3 = cp3
		self.cp4 = cp4
	}


	/// Creates a sub-curve
	///
	/// - Parameters:
	///   - percent: End of sub-curve as percent of initial curve
	/// - Returns: A BeziercCurve
	public func reducing(to percent: CGFloat) -> BezierCurve {
		return reducing(from: 0, to: percent)
	}

	/// Creates a sub-curve
	///
	/// - Parameters:
	///   - start: Start of sub-curve as percent of initial curve
	///   - end: End of sub-curve as percent of initial curve
	/// - Returns: A BeziercCurve
	public func reducing(from start: CGFloat,
						 to end: CGFloat) -> BezierCurve {

		guard 0 <= start && start <= end && end <= 1 else { return self }

		// Sub-Curve is empty
		guard start != end else { return BezierCurve(cp1, cp1, cp1, cp1) }

		// Sub-Curve matches initial curve
		guard !(start == 0 && end == 1) else { return self }


		var A = cp1
		var B = cp2
		var C = cp3
		var D = cp4
		var E, F, G, I, J, K: CGPoint

		if start != 0 {
			E = A + (B - A) * start
			F = B + (C - B) * start
			G = C + (D - C) * start
			I = E + (F - E) * start
			J = F + (G - F) * start
			K = I + (J - I) * start

			A = K
			B = J
			C = G
		}

		if end != 1 {

			let t = (end - start) / (1 - start)

			E = A + (B - A) * t
			F = B + (C - B) * t
			G = C + (D - C) * t
			I = E + (F - E) * t
			J = F + (G - F) * t
			K = I + (J - I) * t

			B = E
			C = I
			D = K
		}

		return BezierCurve(A, B, C, D)

	}

}
