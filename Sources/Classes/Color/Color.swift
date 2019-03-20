//
//  Color.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//


public struct Color: Hashable, Codable, CustomStringConvertible, CustomPlaygroundDisplayConvertible {

	/// Red component
	public let red: Double
	/// Green component
	public let green: Double
	/// Blue component
	public let blue: Double
	/// Alpha component
	public let alpha: Double



	// MARK: - Initialize

	/// Creates a color from red, green, blue and alpha components
	public init(red: Double,
				green: Double,
				blue: Double,
				alpha: Double) {
		self.red = red
		self.green = green
		self.blue = blue
		self.alpha = alpha
	}

	/// Creates a color from a RGBA hexadecimal representation.
	/// Representation : '#RRGGBBAA'
	public init?(rgbaHex: String = "#FFFFFFFF") {

		guard rgbaHex.hasPrefix("#"), rgbaHex.count == 9 else { return nil }

		let string = String(rgbaHex[rgbaHex.index(after: rgbaHex.startIndex)...])
		var hexValue: UInt32 = 0

		guard Scanner(string: string).scanHexInt32(&hexValue) else { return nil }

		let red = Double((hexValue & 0xFF000000) >> 24) / 255
		let green = Double((hexValue & 0x00FF0000) >> 16) / 255
		let blue = Double((hexValue & 0x0000FF00) >> 8) / 255
		let alpha = Double(hexValue & 0x000000FF) / 255

		self.init(red: red, green: green, blue: blue, alpha: alpha)

	}

	/// Creates a color from RGB hexadecimal representation '#RRGGBB'.
	public init?(rgb: String) {
		self.init(rgbaHex: rgb + "FF")
	}

	/// Create a color from hue, saturation, lightness & alpha.
	/// Hue is in [0°, 360°], saturation, lightness & alpha are in [0, 1]
	public init(hue: Double,
				saturation: Double,
				lightness: Double,
				alpha: Double = 1) {

		func hueToRGB(m1: Double, m2: Double, h: Double) -> Double {

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


		let hue = min(max(hue / 360, 0), 1)
		let saturation = min(max(saturation, 0), 1)
		let lightness = min(max(lightness, 0), 1)
		let alpha = min(max(alpha, 0), 1)

		let m2 = lightness <= 0.5
			? lightness * (saturation + 1)
			: (lightness + saturation) - (lightness * saturation)
		let m1 = (lightness * 2) - m2

		let red = hueToRGB(m1: m1, m2: m2, h: hue + 1 / 3)
		let green = hueToRGB(m1: m1, m2: m2, h: hue)
		let blue = hueToRGB(m1: m1, m2: m2, h: hue - 1 / 3)

		self.init(red: red, green: green, blue: blue, alpha: alpha)

	}



	// MARK: - Description

	public var description: String {
		return "(\(red) r, \(green) g, \(blue) b, \(alpha) a)"
	}


	// MARK: - Playground

	public var playgroundDescription: Any {
		return UIColor(color: self)
	}

}
