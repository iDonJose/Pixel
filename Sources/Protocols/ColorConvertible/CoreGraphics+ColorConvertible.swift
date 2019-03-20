//
//  CoreGraphics+ColorConvertible.swift
//  Pixel-iOS
//
//  Created by José Donor on 20/03/2019.
//


extension CGColor: ColorConvertible {

	/// Color
	public var color: Color {
		return UIColor(cgColor: self).color
	}

}
