//
//  CGPoint+Algebra.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//

// swiftlint:disable shorthand_operator


extension CGPoint {

	// MARK: Addition

	public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
		return CGPoint(x: lhs.x + rhs.x,
					   y: lhs.y + rhs.y)
	}

	public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
		return lhs + (-rhs)
	}


	// MARK: Product

	public static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
		return CGPoint(x: lhs.x * rhs,
					   y: lhs.y * rhs)
	}

	public static func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
		return rhs * lhs
	}


	public static prefix func - (point: CGPoint) -> CGPoint {
		return -1 * point
	}

	public static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
		guard rhs != 0 else { fatalError("Can't divide by 0") }
		return lhs * (1 / rhs)
	}


	public static func * (lhs: CGPoint, rhs: CGPoint) -> CGFloat {
		return lhs.x * rhs.x + lhs.y * rhs.y
	}


	// MARK: - Shorthands

	public static func += (lhs: inout CGPoint, rhs: CGPoint) {
		lhs = lhs + rhs
	}

	public static func -= (lhs: inout CGPoint, rhs: CGPoint) {
		lhs = lhs - rhs
	}

	public static func *= (lhs: inout CGPoint, rhs: CGFloat) {
		lhs = lhs * rhs
	}

	public static func /= (lhs: inout CGPoint, rhs: CGFloat) {
		lhs = lhs / rhs
	}

}
