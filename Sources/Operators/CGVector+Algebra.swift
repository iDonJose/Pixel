//
//  CGVector+Algebra.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CGVector {

	// MARK: Addition

	public static func + (lhs: CGPoint, rhs: CGVector) -> CGPoint {
		return CGPoint(x: lhs.x + rhs.dx,
					   y: lhs.y + rhs.dy)
	}

	public static func - (lhs: CGPoint, rhs: CGVector) -> CGPoint {
		return CGPoint(x: lhs.x - rhs.dx,
					   y: lhs.y - rhs.dy)
	}


	// MARK: Product

	public static func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
		return CGVector(dx: lhs.dx * rhs,
					   	dy: lhs.dy * rhs)
	}

	public static func * (lhs: CGFloat, rhs: CGVector) -> CGVector {
		return rhs * lhs
	}


	public static prefix func - (vector: CGVector) -> CGVector {
		return -1 * vector
	}

	public static func / (lhs: CGVector, rhs: CGFloat) -> CGVector {
		guard rhs != 0 else { fatalError("Can't divide by 0") }
		return lhs * (1 / rhs)
	}


	public static func * (lhs: CGVector, rhs: CGVector) -> CGFloat {
		return lhs.dx * rhs.dx + lhs.dy * rhs.dy
	}

}
