//
//  Gradient+Initialize.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//


extension Gradient {

	public init() {
		self = .linear(colors: .init(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), start: .zero, end: .one, isRelative: true)
	}

	public static func uniform(color: UIColor) -> Gradient {
		return Gradient.horizontal(colors: color)
	}


	public static func horizontal(colors: UIColor...) -> Gradient {
		return horizontal(colors: colors)
	}

	public static func horizontal(colors: [UIColor]) -> Gradient {
		return .linear(colors: .init(colors), start: .zero, end: .init(x: 1, y: 0), isRelative: true)
	}

	public static func vertical(colors: UIColor...) -> Gradient {
		return vertical(colors: colors)
	}

	public static func vertical(colors: [UIColor]) -> Gradient {
		return .linear(colors: .init(colors), start: .zero, end: .init(x: 0, y: 1), isRelative: true)
	}


	public static func direction(_ vector: CGVector, colors: UIColor...) -> Gradient {
		return direction(vector, colors: colors)
	}

	public static func direction(_ vector: CGVector, colors: [UIColor]) -> Gradient {

		let angle: CGFloat
		let start: CGPoint

		switch (vector.dx, vector.dy) {

		case let (dx, dy) where dx >= 0 && dy >= 0:
			start = .zero
			angle = -vector.angle(to: .init(dx: 1, dy: 1))
		case let (dx, dy) where dx < 0 && dy >= 0:
			start = CGPoint(x: 1, y: 0)
			angle = -vector.angle(to: .init(dx: -1, dy: 1))
		case let (dx, dy) where dx >= 0 && dy < 0:
			start = CGPoint(x: 0, y: 1)
			angle = -vector.angle(to: .init(dx: 1, dy: -1))
		default:
			start = .one
			angle = -vector.angle(to: .init(dx: -1, dy: -1))
		}

		let distance = cos(angle) * sqrt(2)
		let end = start + (vector.normed() * distance)

		return .linear(colors: .init(colors), start: start, end: end, isRelative: true)
	}

}
