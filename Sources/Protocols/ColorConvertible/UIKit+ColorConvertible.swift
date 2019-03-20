//
//  UIKit+ColorConvertible.swift
//  Pixel-iOS
//
//  Created by José Donor on 20/03/2019.
//


extension UIColor: ColorConvertible {

	/// Color
	public var color: Color {
		let rgba = self.rgba
		return Color(red:	rgba.red.to.double,
					 green: rgba.green.to.double,
					 blue: 	rgba.blue.to.double,
					 alpha: rgba.alpha.to.double)
	}


	/// Initialize with a color
	public convenience init(color: Color) {
		self.init(red:	 CGFloat(color.red),
				  green: CGFloat(color.green),
				  blue:	 CGFloat(color.blue),
				  alpha: CGFloat(color.alpha))
	}

}
