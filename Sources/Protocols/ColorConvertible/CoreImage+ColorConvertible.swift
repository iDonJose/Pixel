//
//  CoreImage+ColorConvertible.swift
//  Pixel-iOS
//
//  Created by José Donor on 20/03/2019.
//


extension CIColor: ColorConvertible {

	/// Color
	public var color: Color {
		return Color(red:	red.to.double,
					 green: green.to.double,
					 blue: 	blue.to.double,
					 alpha: alpha.to.double)
	}


	/// Initialize with a color
	public convenience init(color: Color) {
		self.init(red:	 CGFloat(color.red),
				  green: CGFloat(color.green),
				  blue:	 CGFloat(color.blue),
				  alpha: CGFloat(color.alpha))
	}

}
