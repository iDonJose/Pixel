//
//  Shadow.swift
//  Pixel-iOS
//
//  Created by José Donor on 30/11/2018.
//


// A shadow representation
public struct Shadow: Hashable, Codable {

	/// Color
	public var color: UIColor
	/// Radius
	public var radius: CGFloat
	/// Offset
	public var offset: CGPoint


	// MARK: - Initialize

    public init() {
        self.init(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    }

	public init(color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
				radius: CGFloat = 0,
				offset: CGPoint = .zero) {
		self.color = color
		self.radius = radius
		self.offset = offset
	}

	public init(shadow: NSShadow) {
		self.init(color: shadow.color,
				  radius: shadow.radius,
				  offset: shadow.offset)
	}


	/// NSShadow
	public var nsShadow: NSShadow {
		return NSShadow(color: color,
						radius: radius,
						offset: offset)
	}


    // MARK: - Drawing

    /// Draws Shadow in context
    public func draw(context: CGContext) {

        context.setShadow(offset: offset.to.cgSize,
                          blur: radius,
                          color: color.cgColor)

    }



	// MARK: - Codable

	private enum CodingKeys: String, CodingKey {
		case color
		case radius
		case offset
	}

	public init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: CodingKeys.self)
		let color = try container.decode(Color.self, forKey: .color)
		let radius = try container.decode(CGFloat.self, forKey: .radius)
		let offset = try container.decode(CGPoint.self, forKey: .offset)

		self.init(color: UIColor(color: color), radius: radius, offset: offset)
	}

	public func encode(to encoder: Encoder) throws {

		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(color.color, forKey: .color)
		try container.encode(radius, forKey: .radius)
		try container.encode(offset, forKey: .offset)

	}

}
