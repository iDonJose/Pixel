//
//  CATransform3D+Algebra.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CATransform3D {

	// MARK: Addition

	public static func + (lhs: CATransform3D, rhs: CATransform3D) -> CATransform3D {
		return CATransform3D(m11: lhs.m11 + rhs.m11, m12: lhs.m12 + rhs.m12, m13: lhs.m13 + rhs.m13, m14: lhs.m14 + rhs.m14,
							 m21: lhs.m21 + rhs.m21, m22: lhs.m22 + rhs.m22, m23: lhs.m23 + rhs.m23, m24: lhs.m24 + rhs.m24,
							 m31: lhs.m31 + rhs.m31, m32: lhs.m32 + rhs.m32, m33: lhs.m33 + rhs.m33, m34: lhs.m34 + rhs.m34,
							 m41: lhs.m41 + rhs.m41, m42: lhs.m42 + rhs.m42, m43: lhs.m43 + rhs.m43, m44: lhs.m44 + rhs.m44)
	}

	public static func - (lhs: CATransform3D, rhs: CATransform3D) -> CATransform3D {
		return lhs + (-rhs)
	}


	// MARK: Product

	public static func * (lhs: CATransform3D, rhs: CGFloat) -> CATransform3D {
		return CATransform3D(m11: lhs.m11 * rhs, m12: lhs.m12 * rhs, m13: lhs.m13 * rhs, m14: lhs.m14 * rhs,
							 m21: lhs.m21 * rhs, m22: lhs.m22 * rhs, m23: lhs.m23 * rhs, m24: lhs.m24 * rhs,
							 m31: lhs.m31 * rhs, m32: lhs.m32 * rhs, m33: lhs.m33 * rhs, m34: lhs.m34 * rhs,
							 m41: lhs.m41 * rhs, m42: lhs.m42 * rhs, m43: lhs.m43 * rhs, m44: lhs.m44 * rhs)
	}

	public static func * (lhs: CGFloat, rhs: CATransform3D) -> CATransform3D {
		return rhs * lhs
	}


	public static prefix func - (matrix: CATransform3D) -> CATransform3D {
		return -1 * matrix
	}

	public static func / (lhs: CATransform3D, rhs: CGFloat) -> CATransform3D {
		guard rhs != 0 else { fatalError("Can't divide by 0") }
		return lhs * (1 / rhs)
	}


	public static func * (lhs: CATransform3D, rhs: CATransform3D) -> CATransform3D {
		return CATransform3DConcat(lhs, rhs)
	}

}
