//
//  CGFloat.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CGFloat {

	/// Absolute value
	public var abs: CGFloat {
		return Swift.abs(self)
	}

	/// Restricts to a maximum value.
	public func max(_ maximum: CGFloat) -> CGFloat {
		return Swift.min(self, maximum)
	}

	/// Restricts to a minimum value.
	public func min(_ minimum: CGFloat) -> CGFloat {
		return Swift.max(self, minimum)
	}

	/// Restricts value to a given range.
	public func `in`(_ minimum: CGFloat,
					 _ maximum: CGFloat) -> CGFloat {
		return min(minimum).max(maximum)
	}

	/// Rounds down to nearest integer.
	public var floor: CGFloat {
		return Foundation.floor(self)
	}

	/// Rounds up to nearest integer.
	public var ceil: CGFloat {
		return Foundation.ceil(self)
	}

}
