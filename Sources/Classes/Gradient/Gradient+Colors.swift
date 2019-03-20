//
//  Gradient+Colors.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//


extension Gradient {

	/// A set of ordered and located colors.
	/// Locations are relative, though in [0, 1]
	public struct Colors: Hashable, Codable {

		/// Colors
		public let colors: [Double: Color]
		/// Locations
		public var locations: [Double] {
			return Array(colors.keys)
		}



		// MARK: - Initialize

		public init() {
			self.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
		}

		public init(_ colors: ColorConvertible...) {
			self.init(colors)
		}

		public init(_ colors: [ColorConvertible]) {

			if colors.isEmpty {
				self.colors = [0: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), 1: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)].mapValues { $0.color }
			}
			else if colors.count == 1 {
				let color = colors[0]
				self.colors = [0: color, 1: color].mapValues { $0.color }
			}
			else {

				let max = Double(colors.count - 1)
				let pairs = colors
					.enumerated()
					.map { (Double($0.offset) / max, $0.element.color) }

				self.colors = [Double: Color](uniqueKeysWithValues: pairs)

			}

		}

		public init(colors: [Double: ColorConvertible]) {

			if colors.isEmpty {
				self.colors = [0: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), 1: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)].mapValues { $0.color }
			}
			else if colors.count == 1 {
				let color = colors.values.first!
				self.colors = [0: color, 1: color].mapValues { $0.color }
			}
			else {
				self.colors = [Double: Color](uniqueKeysWithValues: colors.map { (min(max($0.key, 0), 1), $0.value.color) })
			}

		}



		/// Gets equivalent CGGradient
		public var cgGradient: CGGradient {
			return CGGradient(colorsSpace: nil,
							  colors: colors.values.map { UIColor(color: $0).cgColor } as CFArray,
							  locations: colors.keys.map { CGFloat($0) })!
		}

	}

}
