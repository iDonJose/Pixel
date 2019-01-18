//
//  Gradient.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//


/// A gredient representation
public enum Gradient: Hashable, Codable {

	/// Linear gradient
	case linear(colors: Colors, start: CGPoint, end: CGPoint, isRelative: Bool)
	/// Radial gradient
	case radial(colors: Colors, startCenter: CGPoint, endCenter: CGPoint, startRadius: CGFloat, endRadius: CGFloat, isRelative: Bool)
	/// Conical gradient
	case conical(colors: Colors, center: CGPoint, startRadius: CGFloat, endRadius: CGFloat, isRelative: Bool, startAngle: CGFloat, endAngle: CGFloat)



	// MARK: - Codable

	private enum CodingKeys: String, CodingKey {

		case type
		case colors

		case start
		case end
		case isRelative

		case startCenter
		case endCenter
		case startRadius
		case endRadius

		case center
		case startAngle
		case endAngle

	}

	/// Name
	private var name: String {
		switch self {
		case .linear: return "linear"
		case .radial: return "radial"
		case .conical: return "conical"
		}
	}

	public init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: CodingKeys.self)

		let type = try container.decode(String.self, forKey: .type)


		switch type {

		case "linear":

			let colors = try container.decode(Colors.self, forKey: .colors)
			let start = try container.decode(CGPoint.self, forKey: .start)
			let end = try container.decode(CGPoint.self, forKey: .end)
			let isRelative = try container.decode(Bool.self, forKey: .isRelative)

			self = .linear(colors: colors, start: start, end: end, isRelative: isRelative)

		case "radial":

			let colors = try container.decode(Colors.self, forKey: .colors)
			let startCenter = try container.decode(CGPoint.self, forKey: .startCenter)
			let endCenter = try container.decode(CGPoint.self, forKey: .endCenter)
			let startRadius = try container.decode(CGFloat.self, forKey: .startRadius)
			let endRadius = try container.decode(CGFloat.self, forKey: .endRadius)
			let isRelative = try container.decode(Bool.self, forKey: .isRelative)

			self = .radial(colors: colors, startCenter: startCenter, endCenter: endCenter, startRadius: startRadius, endRadius: endRadius, isRelative: isRelative)

		case "conical":

			let colors = try container.decode(Colors.self, forKey: .colors)
			let center = try container.decode(CGPoint.self, forKey: .center)
			let startRadius = try container.decode(CGFloat.self, forKey: .startRadius)
			let endRadius = try container.decode(CGFloat.self, forKey: .endRadius)
			let isRelative = try container.decode(Bool.self, forKey: .isRelative)
			let startAngle = try container.decode(CGFloat.self, forKey: .startAngle)
			let endAngle = try container.decode(CGFloat.self, forKey: .endAngle)

			self = .conical(colors: colors, center: center, startRadius: startRadius, endRadius: endRadius, isRelative: isRelative, startAngle: startAngle, endAngle: endAngle)

		default: fatalError("Key \(type) doesn't exist")
		}

	}

	public func encode(to encoder: Encoder) throws {

		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(name, forKey: .type)


		switch self {

		case let .linear(colors, start, end, isRelative):

			try container.encode(colors, forKey: .colors)
			try container.encode(start, forKey: .start)
			try container.encode(end, forKey: .end)
			try container.encode(isRelative, forKey: .isRelative)

		case let .radial(colors, startCenter, endCenter, startRadius, endRadius, isRelative):

			try container.encode(colors, forKey: .colors)
			try container.encode(startCenter, forKey: .startCenter)
			try container.encode(endCenter, forKey: .endCenter)
			try container.encode(startRadius, forKey: .startRadius)
			try container.encode(endRadius, forKey: .endRadius)
			try container.encode(isRelative, forKey: .isRelative)

		case let .conical(colors, center, startRadius, endRadius, isRelative, startAngle, endAngle):

			try container.encode(colors, forKey: .colors)
			try container.encode(center, forKey: .center)
			try container.encode(startRadius, forKey: .startRadius)
			try container.encode(endRadius, forKey: .endRadius)
			try container.encode(isRelative, forKey: .isRelative)
			try container.encode(startAngle, forKey: .startAngle)
			try container.encode(endAngle, forKey: .endAngle)

		}

	}

}
