//
//  CIColor.swift
//  Pixel-iOS
//
//  Created by José Donor on 20/03/2019.
//


extension CIColor {

	/// Changes alpha.
	public func with(alpha: CGFloat) -> CIColor {
		return CIColor(red: red, green: green, blue: blue, alpha: alpha)
	}

}
