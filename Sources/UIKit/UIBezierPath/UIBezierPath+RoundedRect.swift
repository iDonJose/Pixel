//
//  UIBezierPath+RoundedRect.swift
//  Pixel-iOS
//
//  Created by José Donor on 28/11/2018.
//


extension UIBezierPath {

	public convenience init(roundedRectIn bounds: CGRect,
							cornerRadii: [UIRectCorner: CGFloat]) {

		let width = bounds.width
		let height = bounds.height

		let length = min(width, height)

		guard !(cornerRadii[.allCorners] == length / 2
            && bounds.width == bounds.height) else {
			self.init(ovalIn: bounds)
			return
		}

		self.init()


		var cornerRadii = cornerRadii.mapValues { $0.abs }

		let radius = cornerRadii[.allCorners]

		var tlRadius = radius ?? cornerRadii[.topLeft] ?? 0
		var trRadius = radius ?? cornerRadii[.topRight] ?? 0
		var brRadius = radius ?? cornerRadii[.bottomRight] ?? 0
		var blRadius = radius ?? cornerRadii[.bottomLeft] ?? 0

		// Ensures that radius don't overflow
		if tlRadius + trRadius > width {
			tlRadius = tlRadius.max(width)
			trRadius = width - tlRadius
		}
		if trRadius + brRadius > height {
			trRadius = trRadius.max(height)
			brRadius = height - trRadius
		}
		if brRadius + blRadius > width {
			brRadius = brRadius.max(width)
			blRadius = width - brRadius
		}
		if blRadius + tlRadius > height {
			blRadius = blRadius.max(height)
			tlRadius = width - blRadius
		}


		let minX = bounds.minX
		let minY = bounds.minY
		let maxX = bounds.maxX
		let maxY = bounds.maxY


        move(to: bounds.center)

		var center = CGPoint(x: minX + tlRadius, y: minY + tlRadius)

		if tlRadius == 0 {
			move(to: center)
		}
		else {
			move(to: CGPoint(x: minX, y: minY + tlRadius))
			addArc(withCenter: center, radius: tlRadius, startAngle: .pi, endAngle: .pi * 1.5, clockwise: true)
		}


		center = CGPoint(x: maxX - trRadius, y: minY + trRadius)

		if trRadius == 0 {
			addLine(to: center)
		}
		else {
			addLine(to: CGPoint(x: maxX - trRadius, y: minY))
			addArc(withCenter: center, radius: trRadius, startAngle: .pi * 1.5, endAngle: 0, clockwise: true)
		}


		center = CGPoint(x: maxX - brRadius, y: maxY - brRadius)

		if brRadius == 0 {
			addLine(to: center)
		}
		else {
			addLine(to: CGPoint(x: maxX, y: maxY - brRadius))
			addArc(withCenter: center, radius: brRadius, startAngle: 0, endAngle: .pi * 0.5, clockwise: true)
		}


		center = CGPoint(x: minX + blRadius, y: maxY - blRadius)

		if blRadius == 0 {
			addLine(to: center)
		}
		else {
			addLine(to: CGPoint(x: minX + blRadius, y: maxY))
			addArc(withCenter: center, radius: blRadius, startAngle: .pi * 0.5, endAngle: .pi, clockwise: true)
		}

		close()

	}

}
