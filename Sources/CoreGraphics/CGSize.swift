//
//  CGSize.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CGSize {

	/// Unit size [width: 1, height: 1]
	public static let one = CGSize(width: 1, height: 1)

	/// Middle x
	public var midX: CGFloat {
		return width / 2
	}

	/// Middle y
	public var midY: CGFloat {
		return height / 2
	}

	/// Center
	public var center: CGPoint {
		return CGPoint(x: midX, y: midY)
	}

	/// Diagonal size
	public var diagonal: CGFloat {
		return sqrt(pow(width, 2) + pow(height, 2))
	}


	/// Returns length when projected on a direction
	public func projected(on direction: UICollectionView.ScrollDirection) -> CGFloat {
		switch direction {
		case .horizontal: return width
		case .vertical: return height
		}
	}

}
