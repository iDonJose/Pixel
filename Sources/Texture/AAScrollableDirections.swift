//
//  AAScrollableDirections.swift
//  Pixel-iOS
//
//  Created by José Donor on 14/02/2019.
//

#if USE_TEXTURE

import AsyncDisplayKit



extension ASScrollDirection {

	/// Horiontal direction
	public static var horizontal: ASScrollDirection {
		return [.left, .right]
	}

	/// Vertical direction
	public static var vertical: ASScrollDirection {
		return [.up, .down]
	}

}

#endif
