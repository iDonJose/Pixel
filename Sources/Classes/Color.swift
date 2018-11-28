//
//  Color.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//


/// A UIColor wrapper conforming to Codable
public struct Color: Equatable, Codable {

	public let value: UIColor


	public init(_ value: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) {
		self.value = value
	}

	public init(from decoder: Decoder) throws {

		let value = try decoder.singleValueContainer()
		let RGBA = try value.decode(String.self)

		self.init(UIColor(RGBA: RGBA) ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))

	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(value.rgbaHex)
	}


	public static func == (lhs: Color, rhs: Color) -> Bool {
		return lhs.value == rhs.value
	}

}
