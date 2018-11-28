//
//  UIImage.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//


extension UIImage {

	// MARK: - Image from Color

	/// Creates an Image of a given shape and color
	public convenience init(color: UIColor,
							shape: UIBezierPath?,
							size: CGSize) {
		self.init(color: color,
				  shapeForBounds: { shape ?? UIBezierPath(rect: $0) },
				  size: size)
	}

	#if USE_SVG
	/// Creates an Image of a given shape and color
	public convenience init(color: UIColor,
							shape: BezierPath,
							size: CGSize) {
		self.init(color: color,
				  shapeForBounds: shape.pathForBounds,
				  size: size)
	}
	#endif

	/// Creates an Image of a given shape and color
	public convenience init(color: UIColor,
							shapeForBounds: ((CGRect) -> UIBezierPath)?,
							size: CGSize) {

		let isOpaque = shapeForBounds == nil
		let bounds = CGRect(origin: .zero, size: size)
		let path = shapeForBounds?(bounds) ?? UIBezierPath(rect: bounds)

		UIGraphicsBeginImageContextWithOptions(size, isOpaque, 0)

		color.setFill()
		path.fill()

		let image = UIGraphicsGetCurrentContext()?.makeImage()

		UIGraphicsEndImageContext()

		if let image = image { self.init(cgImage: image) }
		else { self.init() }

	}


	// MARK: - Image from Gradient

	/// Creates an Image of a given shape and gradient
	public convenience init(gradient: Gradient,
							shape: UIBezierPath?,
							size: CGSize) {
		self.init(gradient: gradient,
				  shapeForBounds: { shape ?? UIBezierPath(rect: $0) },
				  size: size)
	}

	#if USE_SVG
	/// Creates an Image of a given shape and gradient
	public convenience init(gradient: Gradient,
							shape: BezierPath,
							size: CGSize) {
		self.init(gradient: gradient,
				  shapeForBounds: shape.pathForBounds,
				  size: size)
	}
	#endif

	/// Creates an Image of a given shape and gradient
	public convenience init(gradient: Gradient,
							shapeForBounds: ((CGRect) -> UIBezierPath)?,
							size: CGSize) {

		let isOpaque = shapeForBounds == nil
		let bounds = CGRect(origin: .zero, size: size)
		let path = shapeForBounds?(bounds) ?? UIBezierPath(rect: bounds)

		UIGraphicsBeginImageContextWithOptions(size, isOpaque, 0)
		let context = UIGraphicsGetCurrentContext()!

		context.addPath(path.cgPath)
		context.clip()
		gradient.draw(in: bounds, context: context)

		let image = UIGraphicsGetCurrentContext()?.makeImage()

		UIGraphicsEndImageContext()

		if let image = image { self.init(cgImage: image) }
		else { self.init() }

	}

}
