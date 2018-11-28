//
//  CGPoint+Conversion.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CGPoint {

	public var to: Converter {
		return Converter(self)
	}


	public struct Converter {

		private let value: CGPoint

		fileprivate init (_ value: CGPoint) {
			self.value = value
		}


		public var cgVector: CGVector {
			return CGVector(dx: value.x, dy: value.y)
		}

		public var cgSize: CGSize {
			return CGSize(width: value.x, height: value.y)
		}

		public var cgRect: CGRect {
			return CGRect(origin: .zero, size: cgSize)
		}

	}

}
