//
//  BezierPath.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//


/// A Bezier path representation
public enum BezierPath: Hashable, Codable {

	case svg([String], bounds: CGSize, insets: UIEdgeInsets)
	case rect(insets: UIEdgeInsets)
	case roundedRect(corners: UIRectCorner, cornerRadius: CGPoint, isRelative: Bool, insets: UIEdgeInsets)
	case oval(insets: UIEdgeInsets)
	case circle(insets: UIEdgeInsets)
	case squircle(cornerRadius: CGFloat, isRelative: Bool, insets: UIEdgeInsets)
	case arc(radius: CGFloat, isRelative: Bool, startAngle: CGFloat, endAngle: CGFloat, insets: UIEdgeInsets)


	// MARK: Codable

	private enum CodingKeys: String, CodingKey {

		case type

		case svg
		case bounds

		case insets

		case corners
		case cornerRadius
		case isRelative

		case radius
		case startAngle
		case endAngle

	}

	/// Name
	private var name: String {
		switch self {
		case .svg: return "svg"
		case .rect: return "rect"
		case .roundedRect: return "roundedRect"
		case .oval: return "oval"
		case .circle: return "circle"
		case .squircle: return "squircle"
		case .arc: return "arc"
		}
	}


	public init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: CodingKeys.self)

		let type = try container.decode(String.self, forKey: .type)


		switch type {

		case "svg":

			let svg = try container.decode([String].self, forKey: .svg)
			let bounds = try container.decode(CGSize.self, forKey: .bounds)
			let insets = try container.decode(UIEdgeInsets.self, forKey: .insets)

			self = .svg(svg,
						bounds: bounds,
						insets: insets)

		case "rect":

			let insets = try container.decode(UIEdgeInsets.self, forKey: .insets)

			self = .rect(insets: insets)

		case "roundedRect":

			let corners = try container.decode(UIRectCorner.self, forKey: .corners)
			let cornerRadius = try container.decode(CGPoint.self, forKey: .cornerRadius)
			let isRelative = try container.decode(Bool.self, forKey: .isRelative)
			let insets = try container.decode(UIEdgeInsets.self, forKey: .insets)

			self = .roundedRect(corners: corners,
								cornerRadius: cornerRadius,
								isRelative: isRelative,
								insets: insets)

		case "oval":

			let insets = try container.decode(UIEdgeInsets.self, forKey: .insets)

			self = .oval(insets: insets)

		case "circle":

			let insets = try container.decode(UIEdgeInsets.self, forKey: .insets)

			self = .circle(insets: insets)

		case "squircle":

			let cornerRadius = try container.decode(CGFloat.self, forKey: .cornerRadius)
			let isRelative = try container.decode(Bool.self, forKey: .isRelative)
			let insets = try container.decode(UIEdgeInsets.self, forKey: .insets)

			self = .squircle(cornerRadius: cornerRadius,
							 isRelative: isRelative,
							 insets: insets)

		case "arc":

			let radius = try container.decode(CGFloat.self, forKey: .radius)
			let isRelative = try container.decode(Bool.self, forKey: .isRelative)
			let startAngle = try container.decode(CGFloat.self, forKey: .startAngle)
			let endAngle = try container.decode(CGFloat.self, forKey: .endAngle)
			let insets = try container.decode(UIEdgeInsets.self, forKey: .insets)

			self = .arc(radius: radius,
						isRelative: isRelative,
						startAngle: startAngle,
						endAngle: endAngle,
						insets: insets)

		default: fatalError("Key \(type) doesn't exist")
		}

	}

	public func encode(to encoder: Encoder) throws {

		var container = encoder.container(keyedBy: CodingKeys.self)

		switch self {

		case let .svg(svg, bounds, insets):

			try container.encode(name, forKey: .type)
			try container.encode(svg, forKey: .svg)
			try container.encode(bounds, forKey: .bounds)
			try container.encode(insets, forKey: .insets)

		case let .rect(insets):

			try container.encode(name, forKey: .type)
			try container.encode(insets, forKey: .insets)

		case let .oval(insets):

			try container.encode(name, forKey: .type)
			try container.encode(insets, forKey: .insets)

		case let .circle(insets):

			try container.encode(name, forKey: .type)
			try container.encode(insets, forKey: .insets)

		case let .roundedRect(corners, cornerRadius, isRelative, insets):

			try container.encode(name, forKey: .type)
			try container.encode(corners, forKey: .corners)
			try container.encode(cornerRadius, forKey: .cornerRadius)
			try container.encode(isRelative, forKey: .isRelative)
			try container.encode(insets, forKey: .insets)

		case let .squircle(cornerRadius, isRelative, insets):

			try container.encode(name, forKey: .type)
			try container.encode(cornerRadius, forKey: .cornerRadius)
			try container.encode(isRelative, forKey: .isRelative)
			try container.encode(insets, forKey: .insets)

		case let .arc(radius, isRelative, startAngle, endAngle, insets):

			try container.encode(name, forKey: .type)
			try container.encode(radius, forKey: .radius)
			try container.encode(isRelative, forKey: .isRelative)
			try container.encode(startAngle, forKey: .startAngle)
			try container.encode(endAngle, forKey: .endAngle)
			try container.encode(insets, forKey: .insets)

		}

	}

}
