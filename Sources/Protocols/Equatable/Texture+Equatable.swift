//
//  Texture+Equatable.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//

#if USE_TEXTURE

import AsyncDisplayKit



extension ASSizeRange: Equatable {

	public static func == (lhs: ASSizeRange, rhs: ASSizeRange) -> Bool {
		return lhs.min == rhs.min
			&& lhs.max == rhs.max
	}

}

#endif
