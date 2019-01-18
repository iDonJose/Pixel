//
//  ASButtonNode.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//

#if USE_TEXTURE

import AsyncDisplayKit



extension ASButtonNode {

	/// Changes text's attributes
	public func update(attributedText: NSAttributedString) {
		setAttributedTitle(attributedText, for: .normal)
	}

}

#endif
