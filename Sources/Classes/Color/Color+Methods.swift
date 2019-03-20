//
//  Color+Methods.swift
//  Pixel-iOS
//
//  Created by José Donor on 20/03/2019.
//


extension Color {

	/// Changes alpha.
	public func with(alpha: Double) -> Color {
		return Color(red: red, green: green, blue: blue, alpha: alpha)
	}


	// MARK: - Red, green, blue and alpha

	/// RGB hexadecimal representation '#RRGGBB'.
	public var rgbHex: String {
		return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
	}

	/// RGBA hexadecimal representation '#RRGGBBAA'.
	public var rgbaHex: String {
		return String(format: "#%02X%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255), Int(alpha * 255))
	}


	// MARK: - Hue, saturation, lightness and alpha

	/// Hue in [0°, 360°]
	public var hue: Double {
		return hsla.hue
	}

	/// Saturation in [0, 1]
	public var saturation: Double {
		return hsla.saturation
	}

	/// Lightness in [0, 1]
	public var lightness: Double {
		return hsla.lightness
	}

	/// Red, blue, green and apha components.
	public var hsla: (hue: Double, saturation: Double, lightness: Double, alpha: Double) {

		let max = Swift.max(red, Swift.max(green, blue))
		let min = Swift.min(red, Swift.min(green, blue))
		let delta = max - min
		let sum = max + min

		var hue = 0.0
		var saturation = 0.0
		let lightness = (max + min) / 2

		if delta != 0 {

			saturation = lightness < 0.5
				? delta / sum
				: delta / (2 - sum)

			switch max {
			case red: 	hue = (green - blue) / delta + (green < blue ? 6 : 0)
			case green: hue = (blue - red) / delta + 2
			case blue: 	hue = (red - green) / delta + 4
			default: 	break
			}

		}

		hue *= 60

		return (hue, saturation, lightness, alpha)

	}

}
