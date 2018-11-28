//
//  UIKit+Hashable.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


// MARK: UIRectCorner

extension UIRectCorner: Hashable {

	public var hashValue: Int {
		return rawValue.hashValue
	}

}


// MARK: UIEdgeInsets

extension UIEdgeInsets: Hashable {

	public var hashValue: Int {
		return Hash.combine(hashes: top.hashValue, left.hashValue, bottom.hashValue, right.hashValue)
	}

}
