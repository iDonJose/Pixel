//
//  Shadow.swift
//  Pixel-iOS
//
//  Created by José Donor on 30/11/2018.
//


// A shadow representation
public struct Shadow: Hashable, Codable {

	/// Color
	public var color: Color
	/// Radius
	public var radius: CGFloat
	/// Offset
	public var offset: CGPoint


	// MARK: - Initialize

    public init() {
        self.init(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    }

	public init(color: ColorConvertible = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
				radius: CGFloat = 0,
				offset: CGPoint = .zero) {
		self.color = color.color
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
		return NSShadow(color: UIColor(color: color),
						radius: radius,
						offset: offset)
	}


    // MARK: - Drawing

    /// Draws Shadow in context
    public func draw(context: CGContext) {

        context.setShadow(offset: offset.to.cgSize,
                          blur: radius,
                          color: UIColor(color: color).cgColor)

    }

}
