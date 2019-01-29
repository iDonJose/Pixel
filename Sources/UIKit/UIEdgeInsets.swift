//
//  UIEdgeInsets.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//


extension UIEdgeInsets {

	public struct Edge: OptionSet {

		public let rawValue: UInt

		public static let top = Edge(rawValue: 1 << 0)
		public static let bottom = Edge(rawValue: 1 << 1)
		public static let left = Edge(rawValue: 1 << 2)
		public static let right = Edge(rawValue: 1 << 3)

		public static let all: Edge = [.top, .bottom, .left, .right]
		public static let vertical: Edge = [.top, .bottom]
		public static let horizontal: Edge = [.left, .right]

		public init(rawValue: UInt) { self.rawValue = rawValue }

	}



	// MARK: - Initialize

	public init(edges: Edge = .all,
				value: CGFloat) {

		self.init(top: edges.contains(.top) ? value : 0,
				  left: edges.contains(.left) ? value : 0,
				  bottom: edges.contains(.bottom) ? value : 0,
				  right: edges.contains(.right) ? value : 0)
	}

	/// Insets with all values equal to one
	public static let one = UIEdgeInsets(edges: .all, value: 1)



	// MARK: - Properties

	/// Horizontal sum of left inset and right inset.
	public var horizontal: CGFloat {
		return left + right
	}

	/// Vertical sum of top inset and bottom inset.
	public var vertical: CGFloat {
		return top + bottom
	}



	// MARK: - Filtering

	/// Filters edges
	public func filter(edges: Edge) -> UIEdgeInsets {

		return UIEdgeInsets(top: edges.contains(.top) ? top : 0,
							left: edges.contains(.left) ? left : 0,
							bottom: edges.contains(.bottom) ? bottom : 0,
							right: edges.contains(.right) ? right : 0)
	}

	/// Filters edges for given a direction
	public func filter(direction: UICollectionView.ScrollDirection) -> UIEdgeInsets {

		let isHorizontal = direction == .horizontal

		return UIEdgeInsets(top: !isHorizontal ? top : 0,
							left: isHorizontal ? left : 0,
							bottom: !isHorizontal ? bottom : 0,
							right: isHorizontal ? right : 0)
	}

}
