//
//  UIKit+Codable.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


// MARK: UIEdgeInsets

extension UIEdgeInsets: Codable {

	private enum CodingKeys: String, CodingKey {
		case left
		case top
		case right
		case bottom
	}


	public init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: CodingKeys.self)

		let left = try container.decode(CGFloat.self, forKey: .left)
		let top = try container.decode(CGFloat.self, forKey: .top)
		let right = try container.decode(CGFloat.self, forKey: .right)
		let bottom = try container.decode(CGFloat.self, forKey: .bottom)

		self.init(top: top, left: left, bottom: bottom, right: right)

	}

	public func encode(to encoder: Encoder) throws {

		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(left, forKey: .left)
		try container.encode(top, forKey: .top)
		try container.encode(right, forKey: .right)
		try container.encode(bottom, forKey: .bottom)

	}

}


// MARK: - UIRectCorner

extension UIRectCorner: Codable {

	private enum CodingKeys: String, CodingKey {
		case topLeft
		case topRight
		case bottomLeft
		case bottomRight
	}


	public init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: CodingKeys.self)

		let topLeft = try container.decode(Bool.self, forKey: .topLeft)
		let topRight = try container.decode(Bool.self, forKey: .topRight)
		let bottomLeft = try container.decode(Bool.self, forKey: .bottomLeft)
		let bottomRight = try container.decode(Bool.self, forKey: .bottomRight)

		self.init()

		if topLeft { self.update(with: .topLeft) }
		if topRight { self.update(with: .topRight) }
		if bottomLeft { self.update(with: .bottomLeft) }
		if bottomRight { self.update(with: .bottomRight) }


	}

	public func encode(to encoder: Encoder) throws {

		var container = encoder.container(keyedBy: CodingKeys.self)

		let topLeft = self.contains(.topLeft)
		let topRight = self.contains(.topRight)
		let bottomLeft = self.contains(.bottomLeft)
		let bottomRight = self.contains(.bottomRight)

		try container.encode(topLeft, forKey: .topLeft)
		try container.encode(topRight, forKey: .topRight)
		try container.encode(bottomLeft, forKey: .bottomLeft)
		try container.encode(bottomRight, forKey: .bottomRight)

	}

}
