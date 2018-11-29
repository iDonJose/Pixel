//
//  CGRect.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CGRect {

	/// Origin x
	public var x: CGFloat {
		get { return origin.x }
		set { origin.x = newValue }
	}

	/// Origin y
	public var y: CGFloat {
		get { return origin.y }
		set { origin.y = newValue }
	}


	/// Center
	public var center: CGPoint {
		return CGPoint(x: midX, y: midY)
	}

	/// Diagonal size
	public var diagonal: CGFloat {
		return sqrt(pow(width, 2) + pow(height, 2))
	}

}
