//
//  CGVector+Conversion.swift
//  Pixel-iOS
//
//  Created by José Donor on 26/11/2018.
//


extension CGVector {

	public var to: Converter {
		return Converter(self)
	}


	public struct Converter {

		private let value: CGVector

		fileprivate init (_ value: CGVector) {
			self.value = value
		}


		public var cgPoint: CGPoint {
			return CGPoint(x: value.dx, y: value.dy)
		}

		public var cgSize: CGSize {
			return CGSize(width: value.dx, height: value.dy)
		}

		public var cgRect: CGRect {
			return CGRect(origin: .zero, size: cgSize)
		}

	}

}
