//
//  UIView.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//


extension UIView.AutoresizingMask {

	/// Flexible width and height
	public static var flexibleSize: UIView.AutoresizingMask = [.flexibleWidth, .flexibleHeight]

}


extension UIView {

	/// Root View
	public var rootView: UIView? {

		var rootView: UIView? = superview
		while let next = rootView?.superview { rootView = next }

		return rootView
	}

	/// Changes anchor point without changing layer's position
	public func change(anchor: CGPoint) {
		layer.change(anchor: anchor)
	}

}
