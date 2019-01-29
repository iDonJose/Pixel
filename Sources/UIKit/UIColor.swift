//
//  UIColor.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//

// Source : https://github.com/yannickl/DynamicColor/blob/master/Sources/HSL.swift

import UIKit



extension UIColor {

	// MARK: - Properties

	/// Red component
	public var red: CGFloat {
		var red: CGFloat = 0
		getRed(&red, green: nil, blue: nil, alpha: nil)
		return red
	}

	/// Green component
	public var green: CGFloat {
		var green: CGFloat = 0
		getRed(nil, green: &green, blue: nil, alpha: nil)
		return green
	}

	/// Blue component
	public var blue: CGFloat {
		var blue: CGFloat = 0
		getRed(nil, green: nil, blue: &blue, alpha: nil)
		return blue
	}

	/// Alpha component
	public var alpha: CGFloat {
		var alpha: CGFloat = 0
		getRed(nil, green: nil, blue: nil, alpha: &alpha)
		return alpha
	}

	/// RGBA components.
	public var RGBA: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {

		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0

		guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return (0, 0, 0, 0) }

		return (red, green, blue, alpha)
	}

	/// RGB Hexadecimal representation '#RRGGBB'.
	public var rgbHex: String {
		let (red, green, blue, _) = RGBA
		return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
	}

	/// RGBA Hexadecimal representation '#RRGGBBAA'.
	public var rgbaHex: String {
		let (red, green, blue, alpha) = RGBA
		return String(format: "#%02X%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255), Int(alpha * 255))
	}


	// MARK: - Initialize

	/// Create a color from RGB Hexadecimal representation '#RRGGBB'.
	public convenience init?(RGB: String) {
		self.init(RGBA: RGB + "FF")
	}

	/// Create a color from RGBA Hexadecimal representation '#RRGGBBAA'.
	public convenience init?(RGBA: String) {

		guard RGBA.hasPrefix("#"), RGBA.count == 9 else { return nil }

		var hex = RGBA
		hex.removeFirst()

		var hexValue: UInt32 = 0

		guard Scanner(string: hex).scanHexInt32(&hexValue) else { return nil }

		let divisor: CGFloat = 255

		let red = CGFloat((hexValue & 0xFF000000) >> 24) / divisor
		let green = CGFloat((hexValue & 0x00FF0000) >> 16) / divisor
		let blue = CGFloat((hexValue & 0x0000FF00) >> 8) / divisor
		let alpha = CGFloat(hexValue & 0x000000FF) / divisor

		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}


	/// Hue in [0°, 360°]
	public var hue: CGFloat {
		return hsla.hue
	}

	/// Saturation in [0, 1]
	public var saturation: CGFloat {
		return hsla.saturation
	}

	/// Lightness in [0, 1]
	public var lightness: CGFloat {
		return hsla.lightness
	}

	/// Red, blue, green & apha components.
	public var hsla: (hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat) {

		let rgba = self.rgba

		let max = Swift.max(rgba.red, Swift.max(rgba.green, rgba.blue))
		let min = Swift.min(rgba.red, Swift.min(rgba.green, rgba.blue))
		let delta = max - min
		let sum = max + min

		var hue: CGFloat = 0
		var saturation: CGFloat = 0
		let lightness = (max + min) / 2
		let alpha = rgba.alpha

		if delta != 0 {

			saturation = lightness < 0.5
				? delta / sum
				: delta / (2 - sum)

			switch max {
			case rgba.red:
				hue = (rgba.green - rgba.blue) / delta + (rgba.green < rgba.blue ? 6 : 0)
			case rgba.green:
				hue = (rgba.blue - rgba.red) / delta + 2
			case rgba.blue:
				hue = (rgba.red - rgba.green) / delta + 4
			default:
				break
			}

		}

		hue *= 60

		return (hue, saturation, lightness, alpha)
	}


}
