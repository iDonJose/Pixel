//
//  CGAffineTransform+Algebra.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CGAffineTransform {

	// MARK: Addition

	public static func + (lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
		return CGAffineTransform(a: lhs.a + rhs.a, b: lhs.b + rhs.b,
								 c: lhs.c + rhs.c, d: lhs.d + rhs.d,
								 tx: lhs.tx + rhs.tx, ty: lhs.ty + rhs.ty)
	}

	public static func - (lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
		return lhs + (-rhs)
	}


	// MARK: Product

	public static func * (lhs: CGAffineTransform, rhs: CGFloat) -> CGAffineTransform {
		return CGAffineTransform(a: lhs.a * rhs, b: lhs.b * rhs,
								 c: lhs.c * rhs, d: lhs.d * rhs,
								 tx: lhs.tx * rhs, ty: lhs.ty * rhs)
	}

	public static func * (lhs: CGFloat, rhs: CGAffineTransform) -> CGAffineTransform {
		return rhs * lhs
	}


	public static prefix func - (matrix: CGAffineTransform) -> CGAffineTransform {
		return -1 * matrix
	}

	public static func / (lhs: CGAffineTransform, rhs: CGFloat) -> CGAffineTransform {
		guard rhs != 0 else { fatalError("Can't divide by 0") }
		return lhs * (1 / rhs)
	}


	public static func * (lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
		return lhs.concatenating(rhs)
	}

}
