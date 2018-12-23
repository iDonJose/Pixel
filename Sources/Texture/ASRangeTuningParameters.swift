//
//  ASRangeTuningParameters.swift
//  Pixel-iOS
//
//  Created by José Donor on 23/12/2018.
//

#if USE_TEXTURE

import AsyncDisplayKit



extension ASRangeTuningParameters: Equatable {

	public static func == (lhs: ASRangeTuningParameters, rhs: ASRangeTuningParameters) -> Bool {
		return lhs.leadingBufferScreenfuls == rhs.leadingBufferScreenfuls
			&& lhs.trailingBufferScreenfuls == rhs.trailingBufferScreenfuls
	}

}

#endif
