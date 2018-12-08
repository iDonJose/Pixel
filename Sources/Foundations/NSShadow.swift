//
//  NSShadow.swift
//  Pixel-iOS
//
//  Created by José Donor on 28/11/2018.
//


extension NSShadow {

	/// Color
	public var color: UIColor {
		get { return (shadowColor as? UIColor) ?? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) }
		set { shadowColor = newValue }
	}

	/// Radius
	public var radius: CGFloat {
		get { return shadowBlurRadius }
		set { shadowBlurRadius = newValue }
	}

	/// Offset
	public var offset: CGPoint {
		get { return shadowOffset.to.cgPoint }
		set { shadowOffset = newValue.to.cgSize }
	}


	// MARK: - Initialize

	public convenience init(color: UIColor,
							radius: CGFloat,
							offset: CGPoint) {
		self.init()

		self.color = color
		self.radius = radius
		self.offset = offset

	}


	// MARK: - Drawing

	/// Draws Shadow in context
	public func draw(context: CGContext) {

		context.setShadow(offset: shadowOffset,
						  blur: shadowBlurRadius,
						  color: color.cgColor)

	}

}
