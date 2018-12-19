//
//  ASScrollDirection.swift
//  Pixel-iOS
//
//  Created by José Donor on 19/12/2018.
//

#if USE_TEXTURE

import AsyncDisplayKit



extension ASScrollDirection: Hashable {

	public var hashValue: Int {
		return rawValue
	}

}

#endif
