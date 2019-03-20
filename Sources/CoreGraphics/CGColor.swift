//
//  CGColor.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//

import UIKit



extension CGColor {

	/// Changes alpha.
	public func with(alpha: CGFloat) -> CGColor {
		return copy(alpha: alpha) ?? copy()!
	}

}
