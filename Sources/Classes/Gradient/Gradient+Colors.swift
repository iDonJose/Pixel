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

		private enum CodingKeys: String, CodingKey {
			case colors
		}

		/// Colors
		public let colors: [CGFloat: UIColor]

		/// Locations
		public var locations: [CGFloat] {
			return colors.keys.sorted()
		}



		// MARK: - Initialize

		public init() {
			self.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
		}

		public init(_ colors: UIColor...) {
			self.init(colors)
		}

		public init(_ colors: [UIColor]) {

			if colors.isEmpty {
				self.colors = [0: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), 1: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
			}
			else if colors.count == 1 {
				let color = colors.first!
				self.colors = [0: color, 1: color]
			}
			else {

				let max = CGFloat(colors.count - 1)
				let pairs = colors.enumerated()
					.map { (CGFloat($0.offset) / max, $0.element) }

				self.colors = [CGFloat: UIColor](uniqueKeysWithValues: pairs)

			}

		}

		public init(colors: [CGFloat: UIColor]) {

			if colors.isEmpty {
				self.colors = [0: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), 1: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
			}
			else if colors.count == 1 {
				let color = colors.values.first!
				self.colors = [0: color, 1: color]
			}
			else {

				var colors = colors

				// Checks that keys's bounds matches [0, 1]
				let keys = colors.keys.sorted()

				if let first = keys.first, first != 0 {
					colors[0] = colors[first]
					colors[first] = nil
				}
				if let last = keys.last, last != 1 {
					colors[1] = colors[last]
					colors[last] = nil
				}

				self.colors = colors
			}

		}



		// MARK: - Conversion

		public var cgGradient: CGGradient {

			return CGGradient(colorsSpace: nil,
							  colors: colors.values.map { $0.cgColor } as CFArray,
							  locations: colors.keys.map { $0 })!
		}



		// MARK: - Codable

		public init(from decoder: Decoder) throws {

			let container = try decoder.container(keyedBy: CodingKeys.self)

			let colors = try container.decode([CGFloat: Color].self, forKey: .colors)

			self.colors = colors.mapValues { $0.value }

		}

		public func encode(to encoder: Encoder) throws {

			var container = encoder.container(keyedBy: CodingKeys.self)

			let colors = self.colors.mapValues { Color($0) }

			try container.encode(colors, forKey: .colors)

		}



		// MARK: - Hashable

		public var hashValue: Int {
			return Hash.hash(dictionary: colors)
		}

	}

}
