//
//  CGSize+Conversion.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CGSize {

	public var to: Converter {
		return Converter(self)
	}


	public struct Converter {

		private let value: CGSize

		fileprivate init (_ value: CGSize) {
			self.value = value
		}


		public var cgPoint: CGPoint {
			return CGPoint(x: value.width, y: value.height)
		}

		public var cgVector: CGVector {
			return CGVector(dx: value.width, dy: value.height)
		}

		public var cgRect: CGRect {
			return CGRect(origin: .zero, size: value)
		}

	}

}
