//
//  CALayer.swift
//  Pixel-iOS
//
//  Created by José Donor on 17/12/2018.
//

import UIKit



extension CALayer {

	/// Changes anchor point without changing layer's position
	public func change(anchor: CGPoint) {

		let size = bounds.size
		let transform = affineTransform()

		/// Actual new anchor point position
		var point_new = CGPoint(x: size.width * anchor.x,
								y: size.height * anchor.y)
		point_new = point_new.applying(transform)

		/// Actual olf anchor point position
		var point_old = CGPoint(x: size.width * anchorPoint.x,
								y: size.height * anchorPoint.y)
		point_old = point_old.applying(transform)

		/// Translation induced by new anchor point
		let delta = point_new - point_old

		position += delta
		anchorPoint = anchor

	}

}
