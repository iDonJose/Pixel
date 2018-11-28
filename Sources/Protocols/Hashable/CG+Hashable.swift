//
//  CG+Hashable.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


// MARK: CGPoint

extension CGPoint: Hashable {

	public var hashValue: Int {
		return Hash.combine(hashes: x.hashValue, y.hashValue)
	}

}


// MARK: CGVector

extension CGVector: Hashable {

	public var hashValue: Int {
		return Hash.combine(hashes: dx.hashValue, dy.hashValue)
	}

}


// MARK: CGSize

extension CGSize: Hashable {

	public var hashValue: Int {
		return Hash.combine(hashes: width.hashValue, height.hashValue)
	}

}


// MARK: CGRect

extension CGRect: Hashable {

	public var hashValue: Int {
		return Hash.combine(hashes: origin.x.hashValue, origin.y.hashValue, width.hashValue, height.hashValue)
	}

}
