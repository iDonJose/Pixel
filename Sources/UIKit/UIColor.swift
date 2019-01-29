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



	// MARK: - Red, blue, green, alpha

	/// Create a color from RGB Hexadecimal representation '#RRGGBB'.
	public convenience init?(rgb: String) {
		self.init(rgba: rgb + "FF")
	}

	/// Create a color from RGBA Hexadecimal representation '#RRGGBBAA'.
	public convenience init?(rgba: String) {

		guard rgba.hasPrefix("#"), rgba.count == 9 else { return nil }

		var hex = rgba
		hex.removeFirst()

		var hexValue: UInt32 = 0

		guard Scanner(string: hex).scanHexInt32(&hexValue) else { return nil }

		let red = CGFloat((hexValue & 0xFF000000) >> 24) / 255
		let green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255
		let blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255
		let alpha = CGFloat(hexValue & 0x000000FF) / 255

		self.init(red: red, green: green, blue: blue, alpha: alpha)

	}



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

		guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return (0, 0, 0, 0) }

		return (red, green, blue, alpha)
	}

	/// RGB Hexadecimal representation '#RRGGBB'.
	public var rgbHex: String {
		let (red, green, blue, _) = rgba
		return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
	}

	/// RGBA Hexadecimal representation '#RRGGBBAA'.
	public var rgbaHex: String {
		let (red, green, blue, alpha) = rgba
		return String(format: "#%02X%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255), Int(alpha * 255))
	}



	// MARK: - Hue, saturation, lightness, alpha

	/// Create a color from hue, saturation, lightness & alpha.
	/// Hue is in [0°, 360°], saturation, lightness & alpha are in [0, 1]
	public convenience init(hue: CGFloat,
							saturation: CGFloat,
							lightness: CGFloat,
							alpha: CGFloat = 1) {

		func hueToRGB(m1: CGFloat, m2: CGFloat, h: CGFloat) -> CGFloat {

			let hue = (h.truncatingRemainder(dividingBy: 1) + 1).truncatingRemainder(dividingBy: 1)

			switch hue {
			case let hue where hue * 6 < 1 :
				return m1 + (m2 - m1) * hue * 6
			case let hue where hue * 2 < 1 :
				return m2
			case let hue where hue * 3 < 1.9999 :
				return m1 + (m2 - m1) * (2 / 3 - hue) * 6
			default:
				return m1
			}
		}


		let hue = (hue / 360).in(0, 1)
		let saturation = saturation.in(0, 1)
		let lightness = lightness.in(0, 1)
		let alpha = alpha.in(0, 1)

		let m2 = lightness <= 0.5
			? lightness * (saturation + 1)
			: (lightness + saturation) - (lightness * saturation)
		let m1 = (lightness * 2) - m2

		let red = hueToRGB(m1: m1, m2: m2, h: hue + 1 / 3)
		let green = hueToRGB(m1: m1, m2: m2, h: hue)
		let blue = hueToRGB(m1: m1, m2: m2, h: hue - 1 / 3)

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
