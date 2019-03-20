//
//  UIColor.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//

// Source : https://github.com/yannickl/DynamicColor/blob/master/Sources/HSL.swift

import UIKit



extension UIColor {

	/// Changes alpha.
	public func with(alpha: CGFloat) -> UIColor {
		return withAlphaComponent(alpha)
	}



	// MARK: - Red, blue, green and alpha components

	/// Red component in [0, 1]
	public var red: CGFloat {
		var red: CGFloat = 0
		getRed(&red, green: nil, blue: nil, alpha: nil)
		return red
	}

	/// Green component in [0, 1]
	public var green: CGFloat {
		var green: CGFloat = 0
		getRed(nil, green: &green, blue: nil, alpha: nil)
		return green
	}

	/// Blue component in [0, 1]
	public var blue: CGFloat {
		var blue: CGFloat = 0
		getRed(nil, green: nil, blue: &blue, alpha: nil)
		return blue
	}

	/// Alpha component in [0, 1]
	public var alpha: CGFloat {
		var alpha: CGFloat = 0
		getRed(nil, green: nil, blue: nil, alpha: &alpha)
		return alpha
	}

	/// Red, blue, green & apha components.
	public var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {

		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0

		if getRed(&red, green: &green, blue: &blue, alpha: &alpha) { return (red, green, blue, alpha) }
		else { return (0, 0, 0, 0) }

	}

}
