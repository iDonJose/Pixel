//
//  UIEdgeInsets+Algebra.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension UIEdgeInsets {

	// MARK: Addition

	public static func + (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
		return UIEdgeInsets(top: lhs.top + rhs.top,
							left: lhs.left + rhs.left,
							bottom: lhs.bottom + rhs.bottom,
							right: lhs.right + rhs.right)
	}

	public static func - (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
		return lhs + (-rhs)
	}


	// MARK: Product

	public static func * (lhs: UIEdgeInsets, rhs: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: lhs.top * rhs,
							left: lhs.left * rhs,
							bottom: lhs.bottom * rhs,
							right: lhs.right * rhs)
	}

	public static func * (lhs: CGFloat, rhs: UIEdgeInsets) -> UIEdgeInsets {
		return rhs * lhs
	}


	public static prefix func - (insets: UIEdgeInsets) -> UIEdgeInsets {
		return -1 * insets
	}

	public static func / (lhs: UIEdgeInsets, rhs: CGFloat) -> UIEdgeInsets {
		guard rhs != 0 else { fatalError("Can't divide by 0") }
		return lhs * (1 / rhs)
	}

}
