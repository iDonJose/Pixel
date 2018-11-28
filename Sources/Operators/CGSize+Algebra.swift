//
//  CGSize+Algebra.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CGSize {

	// MARK: Addition

	public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
		return CGSize(width: lhs.width + rhs.width,
					  height: lhs.height + rhs.height)
	}

	public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
		return lhs + (-rhs)
	}


	// MARK: Product

	public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
		return CGSize(width: lhs.width * rhs,
					  height: lhs.height * rhs)
	}

	public static func * (lhs: CGFloat, rhs: CGSize) -> CGSize {
		return rhs * lhs
	}


	public static prefix func - (size: CGSize) -> CGSize {
		return -1 * size
	}

	public static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
		guard rhs != 0 else { fatalError("Can't divide by 0") }
		return lhs * (1 / rhs)
	}


	// MARK: CGRect

	public static func + (lhs: CGPoint, rhs: CGSize) -> CGRect {
		return CGRect(origin: lhs, size: rhs)
	}


	// MARK: UIEdgeInsets

	public static func + (lhs: CGSize, rhs: UIEdgeInsets) -> CGSize {
		return CGSize(width: lhs.width + rhs.left + rhs.right,
					  height: lhs.height + rhs.top + rhs.bottom)
	}

	public static func + (lhs: UIEdgeInsets, rhs: CGSize) -> CGSize {
		return rhs + lhs
	}

	public static func - (lhs: CGSize, rhs: UIEdgeInsets) -> CGSize {
		return CGSize(width: lhs.width - (rhs.left + rhs.right),
					  height: lhs.height - (rhs.top + rhs.bottom))
	}

}
